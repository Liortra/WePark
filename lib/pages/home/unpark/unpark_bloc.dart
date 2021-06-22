import 'dart:convert';

import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:dio/dio.dart';
import 'package:rxdart/rxdart.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:wepark/data/manager/locationmanager/location_manager.dart';
import 'package:wepark/data/manager/locationmanager/location_state.dart';
import 'package:wepark/data/model/diff_time_funcion.dart';
import 'package:wepark/data/model/entities/action_entity/action_entity.dart';
import 'package:wepark/data/model/entities/element_entity/element_entity.dart';
import 'package:wepark/data/model/weparkhttperror/we_park_http_error.dart';
import 'package:wepark/data/source/action/action_repository.dart';
import 'package:wepark/data/source/user/user_repository.dart';
import 'package:wepark/pages/home/unpark/unpark_state.dart';
import 'package:wepark/utils/utils.dart';

class UnParkBloc extends Cubit<BaseUnParkState>{
  final ActionRepository _actionRepository;
  final UserRepository _userRepository;
  final LocationManager _locationManager;
  final compositeSubscription = CompositeSubscription();
  SharedPreferences _localStorage;

  UnParkBloc(this._actionRepository,
      this._userRepository,
      this._locationManager) : super(InitalUnParkState()){

    _locationManager.locationStreamController
        .stream
        .map((state) => state is LocationDataResultState
        ? state
        : throw LocationErrorException(message:((state as LocationErrorState)?.message)??"Something went wrong with location stream"))
        .map((state) => state.data)
        .map((locationData) {
          //Convert m/s to km/h
          print("BEFORE convert show speed: ${locationData.speed}");
          final speedKmByHour = locationData.speed.convertMeterBySecToKmByHour();
          print("AFTER convert show speed: $speedKmByHour");
          return speedKmByHour;
        })
        .where((speed) => speed >= 20.0) //* Filter check if speed more then 20km/h *//
        .listen((speed) {
          print("~~~~~~~~~~~~~~~~ DO UN-PARK!!! ~~~~~~~~~~~~~~~~");
          unPark();
          },onError: (e) {
          switch(e.runtimeType){
            case LocationErrorException:
              final error = e as LocationErrorException;
              print("******* show error of LocationErrorException :${error.message} *******");
              break;
            default:
              print("******* general error of _locationManager.locationStreamController :$e *******");
              break;
          }
        }).addTo(compositeSubscription);
  }

  checkSharedPreferences() async {
    await init();
    final user = await _userRepository.loadUser();
    if(_localStorage.getBool(user.userId.email) == true){
      ElementEntity element = ElementEntity.fromJson(json.decode(_localStorage.getString(user.userId.email+user.licensePlate)));
      await _actionRepository.saveElementEntity(element);
      var _diffTimeFunction = DiffTimeFunction();
      _diffTimeFunction.start = DateTime.parse(_localStorage.getString(WeParkConsts.START));
      _diffTimeFunction.end = DateTime.now();
      await _actionRepository.saveDiffTimePark(_diffTimeFunction);
    }
  }

  unPark() async {
    try{
      compositeSubscription.clear();
      final diffTimePark = await _actionRepository.loadDiffTimePark();
      diffTimePark.end = DateTime.now();
      final user = await _userRepository.loadUser();
      final element = await _actionRepository.loadCacheElement();
      final actionAttributes = Map<String, dynamic>();
      print("_diffTimeFunction show diff: ${diffTimePark.diffMin}");
      actionAttributes["totalTimeInSystem"] = diffTimePark.diffMin;
      await _actionRepository.markPark(ActionEntity.unPark(user,actionAttributes,element));
      _localStorage.remove(user.userId.email+user.licensePlate);
      _localStorage.remove(WeParkConsts.START);
      _localStorage.setBool(user.userId.email, false);
      emit(FinishUnParkState());
    } on DioError catch(e) {
      var message = "";
      switch(e.error.runtimeType){
        case WeParkHttpError:
          print("SUCCUESS GET WeParkHttpError");
          final error = e.error as WeParkHttpError;
          message = error.message;
          break;
        default:
          print("FAILED GET WeParkHttpError");
          message = "Something wrong, check again";
          break;
      }
      emit(ErrorUnParkState(message, error: e));
    } catch (e,stackTrace) {
      var message = "Catch: Something wrong, check again $e";
      print("show error: $e stack: $stackTrace");
      emit(ErrorUnParkState(message, error: e));
    }
  }

  Future init() async {
    _localStorage = await SharedPreferences.getInstance();
  }
}
import 'dart:async';
import 'dart:convert';
import 'package:dio/dio.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:wepark/data/manager/locationmanager/location_manager.dart';
import 'package:wepark/data/model/diff_time_funcion.dart';
import 'package:wepark/data/model/entities/action_entity/action_entity.dart';
import 'package:wepark/data/model/weparkhttperror/we_park_http_error.dart';
import 'package:wepark/data/source/action/action_repository.dart';
import 'package:wepark/data/source/user/user_repository.dart';
import 'package:wepark/pages/home/result/result_state.dart';
import 'package:wepark/utils/utils.dart';

class ResultBloc extends Cubit<BaseResultState> {
  final ActionRepository _actionRepository;
  final UserRepository _userRepository;
  final LocationManager _locationManager;
  final _diffTimeFunction = DiffTimeFunction();
  SharedPreferences _localStorage;

  ResultBloc(this._actionRepository,this._userRepository, this._locationManager) : super(InitialResultState());


  changeCountUpState(bool active) async{
    if(active){
      _diffTimeFunction.start = DateTime.now();
      await init();
      _localStorage.setString(WeParkConsts.START, _diffTimeFunction.start.toIso8601String());
    }
    emit(ActiveCountUpState(active));
  }


   park() async {
    try{
      _diffTimeFunction.end = DateTime.now();
      await _actionRepository.saveDiffTimePark(_diffTimeFunction);
      final user = await _userRepository.loadUser();
      final element = await _actionRepository.loadCacheElement();
      final actionAttributes = Map<String, dynamic>();
      if(_diffTimeFunction.diffMin == -1){
        print("DiffTime is -1 error");
        return;
      }
      print("_diffTimeFunction show diff: ${_diffTimeFunction.diffMin}");
      actionAttributes["averageWaitingTime_q"] = _diffTimeFunction.diffMin;
      await _actionRepository.markPark(ActionEntity.park(user,actionAttributes,element));
      _localStorage.setString(user.userId.email+user.licensePlate, json.encode(element));
      _localStorage.setBool(user.userId.email, true);
      emit(FinishParkState());
    } on DioError catch(e) {
      var message = "";
      switch(e.error.runtimeType){
        case WeParkHttpError:
          print("SUCCESS GET WeParkHttpError");
          final error = e.error as WeParkHttpError;
          message = error.message;
          break;
        default:
          print("FAILED GET WeParkHttpError");
          message = "Something wrong, check again";
          break;
      }
      emit(ErrorResultState(message, error: e));
    } catch (e,stackTrace) {
      var message = "Catch: Something wrong, check again $e";
      print("show error: $e stack: $stackTrace");
      emit(ErrorResultState(message, error: e));
    }
  }

  @override
  Future<void> close() {
    _locationManager.stopService();
    return super.close();
  }

  Future init() async {
    _localStorage = await SharedPreferences.getInstance();
  }

}

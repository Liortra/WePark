import 'dart:async';
import 'package:dio/dio.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:wepark/data/manager/locationmanager/location_manager.dart';
import 'package:wepark/data/manager/locationmanager/location_state.dart';
import 'package:wepark/data/model/entities/action_entity/action_entity.dart';
import 'package:wepark/data/model/weparkhttperror/we_park_http_error.dart';
import 'package:wepark/data/source/action/action_repository.dart';
import 'package:wepark/data/source/user/user_repository.dart';
import 'package:wepark/pages/home/scan/scan_states.dart';

class ScanBloc extends Cubit<BaseScanState> {
  final UserRepository _userRepository;
  final ActionRepository _actionRepository;
  final LocationManager _locationManager;
  final statusLocationStreamController = StreamController<LocationSensorPermissionState>.broadcast();

  ScanBloc(this._userRepository, this._actionRepository, this._locationManager) : super(LoadingScanState());


  //getting lat & lng from the gps or from the mockup
  findParking() async {
    try {
      final user = await _userRepository.loadUser();
      final actionAttributes = Map<String, dynamic>();
      _locationManager.activeLocationService();
      final lastLatLng = await _locationManager.getLastLatLng();
      await _actionRepository.findParking(ActionEntity.fromUserAndActionAttributesFind(user, actionAttributes));
      print("Show last latLang: $lastLatLng");
      emit(FinishScanningSuccessfullyState());
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
      emit(ErrorScanState(message, error: e));
    } catch (e,stackTrace) {
      var message = "Catch: Something wrong, check again $e";
      print("show error: $e stack: $stackTrace");
      emit(ErrorScanState(message, error: e));
    }
  }
}

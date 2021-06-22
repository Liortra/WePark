import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:wepark/data/model/newuserdetails/new_user_details.dart';
import 'package:wepark/data/model/user_role.dart';
import 'package:wepark/data/model/weparkhttperror/we_park_http_error.dart';
import 'package:wepark/data/source/user/user_repository.dart';
import 'package:wepark/pages/registration/registation_validations.dart';
import 'package:wepark/pages/registration/registration_states.dart';
import 'package:dio/dio.dart';
import 'package:wepark/utils/utils.dart';

class RegistrationBloc extends Cubit<BaseRegistrationState> {
  SharedPreferences _localStorage;
  String _email;
  String _userName;
  String _licensePlate;
  final UserRepository _userRepository;

  RegistrationBloc(this._userRepository)
      : super(DefaultRegistrationState(false));

  void validFields(String text, RegistrationFieldsType type) {
    switch (type) {
      case RegistrationFieldsType.EMAIL:
        _email = text;
        break;
      case RegistrationFieldsType.USER_NAME:
        _userName = text;
        break;
      case RegistrationFieldsType.LICENSE_PLATE:
        _licensePlate = text;
        break;
    }
    emit(DefaultRegistrationState(_checkEmail() && _checkUserName() && _checkLicensePlate()));
  }

  bool _checkEmail() => _email.isNotNullOrEmpty() && _email.isValidEmail();

  bool _checkUserName() => _userName.isNotNullOrEmpty();

  bool _checkLicensePlate() => _licensePlate.isNotNullOrEmpty() && _licensePlate.isNumeric();

  createUser() async {
    emit(LoadingRegistrationState());
    try {
      await _userRepository
          .createUser(NewUserDetails(_email, UserRole.ACTOR, _userName, _licensePlate));
      await init();
      _localStorage.setInt(_email+_userName, 100);
      _localStorage.setBool(_email, false);
      emit(FinishRegistrationState());
    } on DioError catch(e){
      var message = "";
      switch(e.error.runtimeType) {
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
      emit(ErrorRegistrationState(message, error: e));
    } catch (e,stackTrace) {
      var message = "Catch: Something wrong, check again $e";
      print("show error: $e stack: $stackTrace");
      emit(ErrorRegistrationState(message, error: e));
    }
  }

  Future init() async {
    _localStorage = await SharedPreferences.getInstance();
  }
}

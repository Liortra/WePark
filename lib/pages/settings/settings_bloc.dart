import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:dio/dio.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:wepark/data/model/weparkhttperror/we_park_http_error.dart';
import 'package:wepark/data/source/user/user_repository.dart';
import 'package:wepark/data/model/entities/entities.dart';
import 'package:wepark/pages/settings/settings_states.dart';
import 'package:wepark/pages/settings/settings_validations.dart';
import 'package:wepark/utils/utils.dart';

class SettingsBloc extends Cubit<BaseSettingsState> {
  SharedPreferences _localStorage;
  String _userName;
  String _licensePlate;
  int _percent;
  UserEntity _userEntity;
  final UserRepository _userRepository;

  SettingsBloc(this._userRepository) : super(DefaultSettingsState(false)); //first

  start() async{
    try{
      _userEntity = await _userRepository.loadUser();
      await init();
      _userName = _userEntity.username;
      _licensePlate = _userEntity.licensePlate;
      _percent = _localStorage.getInt(_userEntity.userId.email+_userName);
      emit(InitalSettingsState(_userEntity,_percent));
    }
    on DioError catch(e) {
      var message = "";
      switch (e.error.runtimeType) {
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
      emit(ErrorSettingsState(message, error: e));
    }
    catch(e,stackTrace){
      var message = "Catch: Something wrong, check again $e";
      print("show error: $e stack: $stackTrace");
      emit(ErrorSettingsState(message, error: e));
    }
  }

  void validField(String text, SettingsFieldsType type) {
    switch (type) {
      case SettingsFieldsType.USER_NAME:
        _userName = text;
        break;
      case SettingsFieldsType.LICENSE_PLATE:
        _licensePlate = text;
        break;
      case SettingsFieldsType.EMAIL:
        break;
      case SettingsFieldsType.PERCENT:
        _percent = int.parse(text);
        break;
    }
    emit(DefaultSettingsState(_checkUserName() && _checkLicensePlate()));
  }

  bool _checkUserName() => _userName.isNotNullOrEmpty();

  bool _checkLicensePlate() => _licensePlate.isNotNullOrEmpty() && _licensePlate.isNumeric();

  updateUser(String valueChoose) async {
    emit(LoadingSettingsState());
    try {
      print(_userName);
      final _newUser = UserEntity(_userEntity.userId, _userEntity.role, _userName, _userEntity.licensePlate);
      await _userRepository.updateUser(
          _userEntity.userId.domain, _userEntity.userId.email, _newUser);
      _localStorage.setInt(_userEntity.userId.email+_userName, int.parse(valueChoose));
      emit(FinishSettingsState());
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
      emit(ErrorSettingsState(message, error: e));
    } catch (e,stackTrace) {
      var message = "Catch: Something wrong, check again $e";
      print("show error: $e stack: $stackTrace");
      emit(ErrorSettingsState(message, error: e));
    }
  }

  Future init() async {
    _localStorage = await SharedPreferences.getInstance();
  }
}

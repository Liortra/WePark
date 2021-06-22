import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:dio/dio.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:wepark/data/source/user/user_repository.dart';
import 'package:wepark/application/api_configuration.dart';
import 'package:wepark/pages/login/login_vaildations.dart';
import 'package:wepark/utils/utils.dart';
import 'package:wepark/data/model/weparkhttperror/we_park_http_error.dart';
import 'login_states.dart';

class LoginBloc extends Cubit<BaseLoginState> {
  SharedPreferences _localStorage;
  final UserRepository _userRepository;

  String _email;

  LoginBloc(this._userRepository) : super(DefaultLoginState(false));

  void validFields(String text, LoginFieldsType type) {
    switch (type) {
      case LoginFieldsType.EMAIL:
        _email = text;
        break;
    }
    _email = text;
    emit(DefaultLoginState(_checkEmail()));
  }

  bool _checkEmail() => _email.isNotNullOrEmpty() && _email.isValidEmail();

  login() async {
    emit(LoadingLoginState());
    try {
      await _userRepository.login(ApiConfiguration.DOMAIN, _email);
      await init();
      var park = false;
      if(_localStorage != null && _localStorage.containsKey(_email))
        park = _localStorage.getBool(_email);
      emit(FinishLoginState(park));
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
      emit(ErrorLoginState(message, error: e));
    } catch (e,stackTrace) {
      var message = "Catch: Something wrong, check again $e";
      print("show error: $e stack: $stackTrace");
      emit(ErrorLoginState(message, error: e));
    }
  }

  Future init() async {
    _localStorage = await SharedPreferences.getInstance();
  }
}

import 'dart:async';
import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get_it/get_it.dart';
import 'package:wepark/pages/home/main/main_page.dart';
import 'package:wepark/pages/home/unpark/unpark_page.dart';
import 'package:wepark/pages/login/login_bloc.dart';
import 'package:wepark/pages/login/login_states.dart';
import 'package:wepark/pages/login/login_vaildations.dart';
import 'package:wepark/pages/registration/registration_page.dart';
import 'package:wepark/widgets/widgets.dart';

class LoginPage extends StatefulWidget {
  @override
  _LoginPageState createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  final _bloc = GetIt.I.get<LoginBloc>();
  Timer _timer;


  @override
  void initState() {
    super.initState();

    _bloc.where((state) => state is FinishLoginState)
        .listen((event){
          var _isPark = (event as FinishLoginState).isPark;
          if(_isPark)
            _moveToUnPark();
          else
            _moveToMain();
        });

    _bloc.where((state) => state is ErrorLoginState)
        .listen((event){
          var _message = (event as ErrorLoginState).message;
          GeneralWeParkDialog.show(context: context,
              title: "Error!",
              message: _message,
              buttonTxt: "Close",
              onClick: ()=> print("this"));
          });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Container(
          padding: EdgeInsets.symmetric(vertical: 100),
          height: MediaQuery.of(context).size.height,
          decoration: BoxDecoration(
            gradient: LinearGradient(
                colors: [Colors.blue, Colors.teal],
                begin: Alignment.topCenter,
                end: Alignment.bottomCenter),
          ),
          child: Column(
            children: [
              _headerSection(),
              BlocBuilder<LoginBloc, BaseLoginState>(
                  cubit: _bloc,
                  builder: (context, state) {
                    switch (state.runtimeType) {
                      case LoadingLoginState:
                        return CircularProgressIndicator();
                      case DefaultLoginState:
                        final enable = (state as DefaultLoginState).enable;
                        return _loginFields(enable);
                      default:
                        return _loginFields(false);
                    }
                  }),
            ],
          ),
        ),
      ),
    );
  }

  Widget _loginFields(bool enable) {
    return Column(
      children: [
        _textSection(),
        _buttonSection(enable),
        _registarSection(),
      ],
    );
  }

  Widget _headerSection() {
    return Logo(
        path: "assets/images/logo.png", horizontal: 20.0, vertical: 30.0);
  }

  Widget _textSection() {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 20.0),
      child: Column(
        children: <Widget>[
          _txtField("Email", Icons.email,TextInputType.emailAddress, LoginFieldsType.EMAIL),
          SizedBox(height: 30.0)
        ],
      ),
    );
  }

  Widget _txtField(String title, IconData icon,TextInputType inputType ,LoginFieldsType type) {
    return EditText(
      icon: Icon(icon, color: Colors.white70),
      hint: title,
      textInputType:inputType,
      onChange: (text) => _bloc.validFields(text, type),
    );
  }

  Widget _registarSection() {
    return Container(
        padding: EdgeInsets.symmetric(horizontal: 20.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            SizedBox(height: 30.0),
            InkWell(
              onTap: () => _moveToRegister(),
              child: Text(
                'Register',
                style: TextStyle(
                    color: Colors.orangeAccent,
                    fontWeight: FontWeight.bold,
                    fontFamily: 'Montserrat',
                    decoration: TextDecoration.underline),
              ),
            ),
          ],
        ));
  }

  Widget _buttonSection(bool enable) {
    return Container(
      width: MediaQuery.of(context).size.width,
      height: 40.0,
      margin: EdgeInsets.only(top: 30.0),
      padding: EdgeInsets.symmetric(horizontal: 20.0),
      child: Button(
        enable: enable,
        title: "Login",
        onClick: () => _bloc.login(),
      ),
    );
  }

  void _moveToRegister() {
    Route route = MaterialPageRoute(builder: (context) => RegistrationPage());
    Navigator.pushReplacement(context, route);
  }

  void _moveToMain() {
    Route route = MaterialPageRoute(builder: (context) => MainPage());
    Navigator.pushReplacement(context, route);
  }

  void _moveToUnPark() {
    Route route = MaterialPageRoute(builder: (context) => UnParkPage());
    Navigator.pushReplacement(context, route);
  }

  @override
  void dispose() {
    _timer = null;
    super.dispose();
  }
}


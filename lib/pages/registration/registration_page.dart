import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get_it/get_it.dart';
import 'package:wepark/pages/home/main/main_page.dart';
import 'package:wepark/pages/login/login_page.dart';
import 'package:wepark/pages/registration/registation_validations.dart';
import 'package:wepark/pages/registration/registration_bloc.dart';
import 'package:wepark/pages/registration/registration_states.dart';
import 'package:wepark/widgets/widgets.dart';

class RegistrationPage extends StatefulWidget {
  @override
  _RegistrationPageState createState() => _RegistrationPageState();
}

class _RegistrationPageState extends State<RegistrationPage> {
  final _bloc = GetIt.I.get<RegistrationBloc>();
  Timer _timer;


  @override
  void initState() {
    super.initState();

    _bloc.where((state) => state is FinishRegistrationState)
        .listen((_) => _moveToMain());

    _bloc.where((state) => state is ErrorRegistrationState)
        .listen((event) {
      var _message = (event as ErrorRegistrationState).message;
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
              BlocBuilder<RegistrationBloc, BaseRegistrationState>(
                cubit: _bloc,
                builder: (context, state) {
                  switch (state.runtimeType) {
                    case LoadingRegistrationState:
                      return CircularProgressIndicator();
                    case DefaultRegistrationState:
                      final enable = (state as DefaultRegistrationState).enable;
                      return _registrationFields(enable);
                    case FinishRegistrationState:
                      return _registrationFields(false);
                    default:
                      return _registrationFields(false);
                  }
                },
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _registrationFields(bool enable) {
    return Column(
      children: [
        _textSection(),
        _buttonSection(enable),
        _loginSection(),
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
          _txtField("Email", Icons.email, RegistrationFieldsType.EMAIL, TextInputType.emailAddress),
          SizedBox(height: 30.0),
          _txtField("User Name", Icons.verified_user,
              RegistrationFieldsType.USER_NAME, TextInputType.name),
          SizedBox(height: 30.0),
          _txtField("License Plate", Icons.speed,
              RegistrationFieldsType.LICENSE_PLATE, TextInputType.number)
        ],
      ),
    );
  }

  Widget _txtField(String title, IconData icon, RegistrationFieldsType type, TextInputType inputType) {
    return EditText(
      icon: Icon(icon, color: Colors.white70),
      hint: title,
      textInputType:inputType,
      onChange: (text) => _bloc.validFields(text, type),
    );
  }

  Widget _loginSection() {
    return Container(
        padding: EdgeInsets.symmetric(horizontal: 20.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            SizedBox(height: 30.0),
            InkWell(
              onTap: () => _moveToLogin(),
              child: Text(
                'Back',
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
        onClick: () => _bloc.createUser(),
      ),
    );
  }

  void _moveToLogin() {
    Route route = MaterialPageRoute(builder: (context) => LoginPage());
    Navigator.pushReplacement(context, route);
  }

  void _moveToMain() {
    Route route = MaterialPageRoute(builder: (context) => MainPage());
    Navigator.pushReplacement(context, route);
  }

  @override
  void dispose() {
    _timer = null;
    super.dispose();
  }
}

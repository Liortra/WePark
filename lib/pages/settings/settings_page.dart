import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get_it/get_it.dart';
import 'package:wepark/pages/home/main/main_page.dart';
import 'package:wepark/pages/settings/settings_bloc.dart';
import 'package:wepark/pages/settings/settings_states.dart';
import 'package:wepark/pages/settings/settings_validations.dart';
import 'package:wepark/widgets/widgets.dart';
import 'package:wepark/utils/utils.dart';

class SettingsPage extends StatefulWidget {
  SettingsPage({Key key}) : super(key: key);

  @override
  _SettingsPageState createState() => _SettingsPageState();
}

class _SettingsPageState extends State<SettingsPage> {
  final _bloc = GetIt.I.get<SettingsBloc>();
  Timer _timer;
  String valueChoose;
  List listItem = ["100","90","80","70","60","50"];

  @override
  void initState() {
    super.initState();
    _bloc.start();
    _bloc.where((state) => state is InitalSettingsState)
        .listen((event) {
          var percent = ((event as InitalSettingsState).percent).toString();
          valueChoose = listItem.firstWhere((element) => element == percent);
      });


    _bloc.where((state) => state is FinishSettingsState)
        .listen((_) => _moveToMain());

    _bloc.where((state) => state is ErrorSettingsState).
    listen((event) {
      var _message = (event as ErrorSettingsState).message;
      GeneralWeParkDialog.show(context: context,
          title: "Error!",
          message: _message,
          buttonTxt: "Close",
          onClick: () => print("this"));
    });
  }

  @override
  Widget build(BuildContext context) {
    SizeConfig().init(context);
    return Scaffold(
      body: SingleChildScrollView(
        child: Container(
          padding: EdgeInsets.symmetric(vertical: 100),
          height: MediaQuery
              .of(context)
              .size
              .height,
          decoration: BoxDecoration(
            gradient: LinearGradient(
                colors: [Colors.blue, Colors.teal],
                begin: Alignment.topCenter,
                end: Alignment.bottomCenter),
          ),
          child: Column(
            children: [
              _headerSection(),
              BlocBuilder<SettingsBloc, BaseSettingsState>(
                  cubit: _bloc,
                  builder: (context, state) {
                    switch (state.runtimeType) {
                      case LoadingSettingsState:
                        return CircularProgressIndicator();
                      case DefaultSettingsState:
                        final enable = (state as DefaultSettingsState).enable;
                        return _updateField(enable);
                      case FinishSettingsState:
                        return _updateField(false);
                      default:
                        return _updateField(false);
                    }
                  })
            ],
          ),
        ),
      ),
    );
  }

  Widget _updateField(bool enable) {
    return Column(
      children: [_textSection(), _buttonSection(enable), _mainSection()],
    );
  }

  Widget _headerSection() {
    return Logo(
        path: "assets/images/logo.png", horizontal: 20.0, vertical: 30.0);
  }

  Widget _textSection() {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 20.0),
      child: BlocBuilder<SettingsBloc, BaseSettingsState>( //todo add dropdown
          cubit: _bloc,
          buildWhen: (prev, current) => current is InitalSettingsState,
          builder: (context, state) {
            final user = state is InitalSettingsState ? state.userEntity : null;
            print("${user?.username}");
            return Column(
              children: <Widget>[
                _txtField(
                    "User Name", Icons.verified_user,
                    SettingsFieldsType.USER_NAME, TextInputType.name,
                    initialValue: user?.username),
                SizedBox(height: 30.0),
                _txtField("License Plate", Icons.speed,
                    SettingsFieldsType.LICENSE_PLATE, TextInputType.number,
                    initialValue: user?.licensePlate),
                SizedBox(height: 30.0),
                Text("Select your % for finding park", style: TextStyle(color: Colors.white70, fontSize: SizeConfig.font_medium),),
                _dropDown()
              ],
            );
          }
      ),
    );
  }

  Widget _txtField(String title, IconData icon, SettingsFieldsType type,
      TextInputType inputType, {String initialValue}) {
    return EditText(
      icon: Icon(icon, color: Colors.white70),
      hint: title,
      initialValue: initialValue,
      textInputType: inputType,
      onChange: (text) => _bloc.validField(text, type),
    );
  }

  Widget _dropDown() {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Container(
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(10.0),
          color: Colors.cyan,
          border: Border.all()
        ),
        child: DropdownButton(
          hint: Text("Select Your %: "),
          dropdownColor: Colors.blue,
          icon: Icon(Icons.arrow_drop_down),
          iconSize: 36,
          style: TextStyle(
            color:  Colors.black,
            fontSize: 22
          ),
          value: valueChoose,
          onChanged: (newValue){
            setState(() {
              valueChoose = newValue;
              _bloc.validField(valueChoose, SettingsFieldsType.PERCENT);
            });
          },
          items: listItem.map((valueItem){
            return DropdownMenuItem(
                value: valueItem,
                child: Text(valueItem)
            );
          }).toList(),
        ),
      ),
    );
  }

  Widget _buttonSection(bool enable) {
    return Container(
      width: MediaQuery
          .of(context)
          .size
          .width,
      height: 40.0,
      margin: EdgeInsets.only(top: 30.0),
      padding: EdgeInsets.symmetric(horizontal: 20.0),
      child: Button(
        enable: enable,
        title: "Update",
        onClick: () => _bloc.updateUser(valueChoose),
      ),
    );
  }

  Widget _mainSection() {
    return Container(
        padding: EdgeInsets.symmetric(horizontal: 20.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            SizedBox(height: 30.0),
            InkWell(
              onTap: () => _moveToMain(),
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
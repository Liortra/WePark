import 'package:flutter/material.dart';
import 'package:get_it/get_it.dart';
import 'package:location/location.dart';
import 'package:rxdart/rxdart.dart';
import 'package:shadow/shadow.dart';
import 'package:wepark/data/manager/locationmanager/location_state.dart';
import 'package:wepark/pages/home/main/main_bloc.dart';
import 'package:wepark/pages/home/scan/scan_page.dart';
import 'package:wepark/pages/settings/settings_page.dart';
import 'package:wepark/pages/login/login_page.dart';
import 'package:wepark/utils/utils.dart';
import 'package:wepark/widgets/widgets.dart';

import 'main_states.dart';

class MainPage extends StatefulWidget {

  @override
  _MainPageState createState() => _MainPageState();
}

class _MainPageState extends State<MainPage> {

  final _bloc = GetIt.I<MainBloc>();
  final compositeSubscription = CompositeSubscription(); // -> clean stream prevent leak memory!!!!!!


  @override
  void initState() {
    super.initState();

    _bloc.checkSharedPreferences();

    _bloc.where((state) => state is LocationPermissionState)
        .map((state) => state as LocationPermissionState)
        .listen((state) {
      switch (state.locationState) {
        case LocationSensorPermissionState.SENSOR_NOT_ACTIVE:
          _requestLocationSensor();
          break;
        case LocationSensorPermissionState.PERMISSION_NOT_GRANTED:
          _requestLocationPermission();
          break;
        default:
          _scanning();
          break;
      }
    }).addTo(compositeSubscription);

    _bloc.where((state) => state is MainLogout).listen((event) => _logout());
  }


  _requestLocationPermission() async {
    final permission = await Location().requestPermission();
    switch(permission){
      case PermissionStatus.granted:
        _scanning();
        break;
      case PermissionStatus.grantedLimited:
        GeneralWeParkDialog.show(context: context,
            title: "Error!",
            message: "For using the app please approve the permission",
            buttonTxt: "Close",);
        break;
      case PermissionStatus.denied:
        GeneralWeParkDialog.show(context: context,
            title: "Error!",
            message: "For using the app please approve the permission",
            buttonTxt: "Close",);
        break;
      case PermissionStatus.deniedForever:
        GeneralWeParkDialog.show(context: context,
            title: "Error!",
            message: "For using the app please approve the permission",
            buttonTxt: "Close",);
        break;
    }
  }

  _requestLocationSensor() async {
    final enable = await Location().requestService();
    if(enable){
      _bloc.askLocationPermission();
    }else{
      GeneralWeParkDialog.show(context: context,
          title: "Error!",
          message: "Please open you GPS",
          buttonTxt: "Close",);
    }
  }

  @override
  Widget build(BuildContext context) {
    SizeConfig().init(context);
    return Scaffold(
      body: Container(
        decoration: BoxDecoration(
          gradient: LinearGradient(
              colors: [Colors.blue, Colors.teal],
              begin: Alignment.topCenter,
              end: Alignment.bottomCenter),
        ),
        child: Column(
          children: [
            _headerSection(),
            _searchSection(),
            _buttonSection(true, "Settings",()=> _setting()),
            _buttonSection(true, "Logout",()=> _bloc.logout()),
          ],
        ),
      ),
    );
  }

  Widget _headerSection() {
    return Logo(
        path: "assets/images/logo.png", horizontal: 20.0, vertical: 30.0);
  }

  Widget _searchSection() {
    return Shadow(
      offset: Offset(10,10),
      opacity: 0.7,
      child: Container(
          padding: EdgeInsets.all(10),
          child: InkWell(
            onTap: () =>
                _bloc.askLocationPermission(),
            child: Image.asset("assets/images/p_icon.png",),
          ),
      ),
    );
  }

  Widget _buttonSection(bool enable, String title, Function function) {
    return Container(
      width: MediaQuery.of(context).size.width,
      height: 40.0,
      margin: EdgeInsets.only(top: 30.0),
      padding: EdgeInsets.symmetric(horizontal: 20.0),
      child: Button(
        enable: enable,
        title: title,
        onClick: () => function(),
      ),
    );
  }

  void _logout() {
    Route route = MaterialPageRoute(builder: (context) => LoginPage());
    Navigator.pushReplacement(context, route);
  }

  void _setting() {
    Route route = MaterialPageRoute(builder: (context) => SettingsPage());
    Navigator.push(context, route);
  }

  void _scanning() {
    Route route = MaterialPageRoute(builder: (context) => ScanPage());
    Navigator.push(context, route);
  }

  @override
  void dispose() {
    print("DISPOSE");
    compositeSubscription.clear();
    super.dispose();
  }
}

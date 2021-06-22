import 'dart:async';

import 'package:flutter/material.dart';
import 'package:get_it/get_it.dart';
import 'package:location/location.dart';
import 'package:wepark/data/manager/locationmanager/location_state.dart';
import 'package:wepark/pages/home/list/list_page.dart';
import 'package:wepark/pages/home/main/main_page.dart';
import 'package:wepark/pages/home/result/result_page.dart';
import 'package:wepark/pages/home/scan/scan_bloc.dart';
import 'package:wepark/pages/home/scan/scan_states.dart';
import 'package:wepark/utils/coordinates/wepark_coordinates.dart';
import 'package:wepark/widgets/alertdialog/general_we_park_dialog.dart';

class ScanPage extends StatefulWidget {
  @override
  _ScanPageState createState() => _ScanPageState();
}

class _ScanPageState extends State<ScanPage> with SingleTickerProviderStateMixin {
  final _bloc = GetIt.I.get<ScanBloc>();
  AnimationController _animationController;
  Animation<double> _animDouble;

  Timer _timer;

  @override
  void initState() {
    super.initState();


    _animationController = new AnimationController(
      vsync: this,
      duration: new Duration(milliseconds: 500),
    );
    _animDouble = CurvedAnimation(
      parent: _animationController,
      curve: Curves.decelerate,
    );
    _animationController.repeat();

    _bloc.listen((state) => _handleScanStates(state));

    _bloc.findParking();

  }



  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        decoration: BoxDecoration(
          gradient: LinearGradient(
              colors: [Colors.blue, Colors.teal],
              begin: Alignment.topCenter,
              end: Alignment.bottomCenter),
        ),
        child: Center(child: _loader()),
      ),
    );
  }

  Widget _loader() {
    return RotationTransition(
      turns: _animDouble,
      child: Image.asset("assets/images/p_rotation.png",
          width: 150, height: 150, fit: BoxFit.contain),
    );
  }

  _handleScanStates(BaseScanState state) {
    switch (state.runtimeType) {
      case FinishScanningSuccessfullyState:
        Navigator.pushReplacement(
            context, MaterialPageRoute(builder: (_) => ListPage()/*ResultPage()*/));
        break;
      case ErrorScanState:
        final _message = (state as ErrorScanState).message;
        GeneralWeParkDialog.show(context: context,
            title: "Error!",
            message: _message,
            buttonTxt: "Close",
            onClick: ()=> _moveToMain());
        break;
      default:
        print("do nothing");
        break;
    }
  }

  void _moveToMain() {
    Route route = MaterialPageRoute(builder: (context) => MainPage());
    Navigator.pushReplacement(context, route);
  }

  @override
  void dispose() {
    _animationController.dispose();
    _bloc.close();
    super.dispose();
  }
}

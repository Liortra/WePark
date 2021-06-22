import 'package:flutter/material.dart';
import 'package:get_it/get_it.dart';
import 'package:wepark/pages/home/unpark/unpark_bloc.dart';
import 'package:wepark/pages/home/unpark/unpark_state.dart';
import 'package:wepark/utils/utils.dart';
import 'package:wepark/widgets/widgets.dart';

import '../main/main_page.dart';

class UnParkPage extends StatefulWidget {
  UnParkPage({Key key}) : super(key: key);

  @override
  _UnParkPageState createState() => _UnParkPageState();
}

class _UnParkPageState extends State<UnParkPage> {
  final _bloc = GetIt.I.get<UnParkBloc>();


  @override
  void initState() {
    super.initState();

    _bloc.checkSharedPreferences();

    _bloc.where((state) => state is ErrorUnParkState)
        .listen((event) {
          var _message = (event as ErrorUnParkState).message;
          GeneralWeParkDialog.show(context: context,
              title: "Error!",
              message: _message,
              buttonTxt: "Close",
              onClick: ()=> print("this"));
        });

    _bloc.where((state) => state is FinishUnParkState)
        .listen((_) => _moveToMain());
  }

  @override
  Widget build(BuildContext context) {
    SizeConfig().init(context);
    return Scaffold(
      body: Container(
        // padding: EdgeInsets.symmetric(vertical: 50),
        decoration: BoxDecoration(
          gradient: LinearGradient(
              colors: [Colors.blue, Colors.teal],
              begin: Alignment.topCenter,
              end: Alignment.bottomCenter),
        ),
        child: Padding(
          padding: EdgeInsets.all(SizeConfig.spacing_medium_horizontal),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Flexible(
                  child: _headerSection()),
              SizedBox(height: SizeConfig.spacing_extra_vertical,),
              Expanded(
               child: _unParkSection(),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _unParkSection() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        Expanded(
            child: Button(title: "UnPark", onClick: () => _unPark(), textSize: 100, backgroundColor: Colors.blueGrey,)),
        Flexible(
            child: _bottomSection()),
      ],
    );
  }

  Widget _headerSection() {
    return Logo(
        path: "assets/images/logo.png", horizontal: 20.0, vertical: 30.0);
  }

  Widget _bottomSection() {
    return Logo(
        path: "assets/images/unpark.png", horizontal:0, vertical: 0);
  }

  void _unPark() {
    print("im here");
    _bloc.unPark();
  }

  void _moveToMain() {
    Route route = MaterialPageRoute(builder: (context) => MainPage());
    Navigator.pushReplacement(context, route);
  }

}

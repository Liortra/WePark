import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get_it/get_it.dart';
import 'package:wepark/pages/home/main/main_page.dart';
import 'package:wepark/pages/home/result/result_bloc.dart';
import 'package:wepark/pages/home/result/result_state.dart';
import 'package:wepark/pages/home/unpark/unpark_page.dart';
import 'package:wepark/utils/utils.dart';
import 'package:wepark/widgets/widgets.dart';

class ResultPage extends StatefulWidget {
  ResultPage({Key key}) : super(key: key);

  @override
  _ResultPageState createState() => _ResultPageState();
}

class _ResultPageState extends State<ResultPage> {
  final _bloc = GetIt.I.get<ResultBloc>();

  @override
  void initState() {
    super.initState();

    _bloc.where((state) => state is ErrorResultState)
        .listen((event) {
          var _message = (event as ErrorResultState).message;
          GeneralWeParkDialog.show(context: context,
              title: "Error!",
              message: _message,
              buttonTxt: "Close",
              onClick: ()=> _moveToMain());
        });

    _bloc.where((state) => state is FinishParkState)
        .listen((_) => _moveToUnPark());
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
        child: Padding(
          padding: EdgeInsets.all(SizeConfig.spacing_normal_horizontal),
          child: _resultStateWidget(),
        ),
      ),
    );
  }

  Widget _resultStateWidget(){
    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Flexible(
          child: Padding(
            padding: EdgeInsets.only(top: SizeConfig.spacing_medium_vertical),
            child: Center(
              child: Text("Time waiting for parking",
                style: TextStyle(color: Colors.white, fontSize: SizeConfig.font_huge, fontFamily: "Montserrat"),textAlign: TextAlign.center,),
            ),
          ),
        ),
        Expanded(
          flex: 3,
          child: BlocBuilder<ResultBloc, BaseResultState>(
            cubit: _bloc,
            buildWhen: (prev,current)=> current is ActiveCountUpState,
            builder: (context, state) {
              final active = state is ActiveCountUpState ? state.active : false;
              return Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Center(child: CountUp(active: active,)),
                  if(!active)...[
                    Expanded(
                        flex:2,
                        child: SizedBox()),
                    Expanded(
                      flex:4,
                      child: Button(title: "Start",
                        onClick: () => _bloc.changeCountUpState(true),
                        textSize: SizeConfig.font_subscription,
                        backgroundColor: Colors.blueGrey,
                      ),
                    )
                  ] else ...[
                    Expanded(
                        flex:3,
                        child: _decision())
                  ]
                ],
              );
            }
          ),
        ),
      ],
    );
  }


  Widget _decision() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        SizedBox(height: SizeConfig.spacing_medium_vertical,),
        Expanded(
          child: Button(
            title: "Park",
            onClick: () => _bloc.park(),
            textSize: SizeConfig.font_subscription,
            backgroundColor: Colors.blueGrey,
          ),
        ),
        SizedBox(height: SizeConfig.spacing_medium_vertical,),
        Expanded(
          child: Button(
            title: "Give up",
            onClick: () => _moveToMain(),
            textSize: 90,
            backgroundColor: Colors.blueGrey,
          ),
        ),
      ],
    );
  }


  void _moveToPark() {
    _bloc.park();
  }

  void _moveToUnPark(){
    Route route = MaterialPageRoute(builder: (context) => UnParkPage());
    Navigator.pushReplacement(context, route);
  }

  void _moveToMain() {
    Route route = MaterialPageRoute(builder: (context) => MainPage());
    Navigator.pushReplacement(context, route);
  }

  @override
  void dispose() {
    _bloc.close();
    super.dispose();
  }

}

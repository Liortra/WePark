import 'dart:math';

import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:wepark/data/model/entities/element_entity/element_entity.dart';
import 'package:wepark/pages/home/result/result_page.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get_it/get_it.dart';
import 'package:wepark/pages/home/list/list_bloc.dart';
import 'package:wepark/pages/home/list/list_state.dart';
import 'package:wepark/utils/utils.dart';
import 'package:wepark/widgets/alertdialog/general_we_park_dialog.dart';

class ListPage extends StatefulWidget {
  @override
  _ListPageState createState() => _ListPageState();
}

class _ListPageState extends State<ListPage> {
  final _bloc = GetIt.I.get<ListBloc>();
  @override
  void initState() {
    super.initState();

    _bloc.where((state) => state is NavigateResultState)
        .map((state) => state as NavigateResultState)
        .listen((state) {
      launchWaze(state.latLng.latitude, state.latLng.longitude);
          _moveToResult();
        });

     _bloc.loadList();

    _bloc.where((state) => state is ErrorListState)
        .listen((event) {
      var _message = (event as ErrorListState).message;
      GeneralWeParkDialog.show(context: context,
          title: "Error!",
          message: _message,
          buttonTxt: "Close",
          onClick: ()=> print("this"));
    });
  }

  @override
  Widget build(BuildContext context) {
    SizeConfig().init(context);
    return Scaffold(
      body: Container(
        decoration: BoxDecoration(
          gradient: LinearGradient(
            colors: [Colors.blue,Colors.teal],
            begin:  Alignment.topCenter,
            end: Alignment.bottomCenter
          ),
        ),
        child: Padding(
          padding: EdgeInsets.all(SizeConfig.spacing_normal_horizontal),
          child: _listViewWidget(),
        ),
      ),
    );
  }

  Widget _listViewWidget() {
    return BlocBuilder<ListBloc,BaseListState>(
        buildWhen: (prev,current) => current is DisplayParkingState,
        cubit: _bloc,
        builder: (context, state){
          switch (state.runtimeType){
            case DisplayParkingState:
              final list = (state as DisplayParkingState).list;
              final myLocation = (state as DisplayParkingState).myLocation;
              return Center(child: _showList(list,myLocation));
            default:
              return Container();
          }
        });
  }

  Widget _showList(List<ElementEntity> list, LatLng myLocation) {
      return ListView.builder(
          itemCount: list.length,
          itemExtent: SizeConfig.screenWidth,
          itemBuilder: (context, index){
            final item = list[index];
            return Padding(
              padding: const EdgeInsets.symmetric(vertical: 1.0, horizontal: 4.0),
              child: Card(
                child: Container(
                  height: MediaQuery.of(context).size.height * 0.6,
                  width: MediaQuery.of(context).size.width * 0.8,
                  child: Center(
                    child: ListTile(
                      onTap: () {
                        _bloc.saveElementEntityThenGo(item);
                      },
                      title: Text("${item.name},\n${(item.time * 100).toInt()} min.\n${(myLocation.distanceBetween(item.center).toInt()/1000).round()} Km",
                        style: new TextStyle(
                          fontSize: 50,
                        ),
                      ),
                      leading: CircleAvatar(
                        backgroundImage: AssetImage("assets/images/app_logo.png"),
                      ),
                    ),
                  ),
                ),
              ),
            );
          });
  }

  void _moveToResult() {
    Route route = MaterialPageRoute(builder: (context) => ResultPage());
    Navigator.pushReplacement(context, route);
  }

  void launchWaze(double lat, double lng) async {
    var url = 'waze://?ll=${lat.toString()},${lng.toString()}';
    var fallbackUrl =
        'https://waze.com/ul?ll=${lat.toString()},${lng.toString()}&navigate=yes';
    try {
      bool launched =
      await launch(url, forceSafariVC: false, forceWebView: false);
      if (!launched) {
        await launch(fallbackUrl, forceSafariVC: false, forceWebView: false);
      }
    } catch (e) {
      await launch(fallbackUrl, forceSafariVC: false, forceWebView: false);
    }
  }

  void launchGoogleMaps(double lat, double lng) async {
    var url = 'google.navigation:q=${lat.toString()},${lng.toString()}';
    var fallbackUrl =
        'https://www.google.com/maps/search/?api=1&query=${lat.toString()},${lng.toString()}';
    try {
      bool launched =
      await launch(url, forceSafariVC: false, forceWebView: false);
      if (!launched) {
        await launch(fallbackUrl, forceSafariVC: false, forceWebView: false);
      }
    } catch (e) {
      await launch(fallbackUrl, forceSafariVC: false, forceWebView: false);
    }
  }

  @override
  void dispose() {
    _bloc.close();
    super.dispose();
  }

}











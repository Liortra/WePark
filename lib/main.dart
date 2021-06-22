import 'package:flutter/material.dart';
import 'package:get_it/get_it.dart';
import 'package:wepark/application/getitmodules/bloc_binding_module.dart';
import 'package:wepark/application/getitmodules/manager_binding_module.dart';
import 'package:wepark/application/getitmodules/net_binding_module.dart';
import 'package:wepark/pages/login/login_page.dart';
import 'application/getitmodules/repository_bind_module.dart';

void setupLocator() {
  NetBindingModule.provideNetModules();
  RepositoryBindingModule.provideRepositories();
  ManagerBindingModule.providesModules();
  BlocBindingModule.providesBlocsModule();
}

void main() {
  WidgetsFlutterBinding.ensureInitialized();
  setupLocator();
  runApp(FutureBuilder(
      future: GetIt.I.allReady(),
      builder: (context, snapshot){
        if(snapshot.connectionState == ConnectionState.done) return MyApp();
        else return LoadingConfigPage();
      })
  );
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'We Park',
      home: LoginPage(),
    );
  }
}

class LoadingConfigPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      color: Colors.white,
      child: Center(
        child: CircularProgressIndicator(),
      ),
    );
  }
}

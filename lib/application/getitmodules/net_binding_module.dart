import 'package:dio/dio.dart';
import 'package:get_it/get_it.dart';
import 'package:pretty_dio_logger/pretty_dio_logger.dart';
import 'package:flutter/foundation.dart';
import 'package:wepark/data/source/action/api/action_api.dart';
import 'package:wepark/data/source/user/api/user_api.dart';
import 'package:wepark/utils/errorhttpinterceptor/error_http_interceptor.dart';

class NetBindingModule {
  static provideNetModules() {
    _provideDio();
    _provideUserApi();
    _providerActionAci();
  }

  static _provideDio() {
    GetIt.I.registerFactory(() {
      final dio = Dio();
      if (kDebugMode) dio.interceptors.add(PrettyDioLogger(requestBody: true));
      dio.interceptors.add(ErrorHttpInterceptor());
      return dio;
    });
  }

  static void _provideUserApi() => GetIt.I.registerFactory(() => UserApi(GetIt.I.get()));

  static void _providerActionAci() => GetIt.I.registerFactory(() => ActionApi(GetIt.I.get()));
}

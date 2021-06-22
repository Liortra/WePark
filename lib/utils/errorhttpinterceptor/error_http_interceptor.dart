import 'package:dio/dio.dart';
import 'package:wepark/data/model/weparkhttperror/we_park_http_error.dart';

class ErrorHttpInterceptor extends Interceptor {
  @override
  Future onError(DioError err) {
    final data = err?.response?.data;
    if (data is Map<String, dynamic> && data.isNotEmpty && data["path"] != null) {
      //start parse...
      final jsonError = err.response.data as Map<String, dynamic>;
      final weParkHttpError = WeParkHttpError.fromJson(jsonError);
      throw weParkHttpError;
    } else {
      return super.onError(err);
    }
  }


}

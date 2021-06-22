// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'action_api.dart';

// **************************************************************************
// RetrofitGenerator
// **************************************************************************

class _ActionApi implements ActionApi {
  _ActionApi(this._dio, {this.baseUrl}) {
    ArgumentError.checkNotNull(_dio, '_dio');
    baseUrl ??= 'https://spring-wepark.herokuapp.com/';
  }

  final Dio _dio;

  String baseUrl;

  @override
  Future<List<ElementEntity>> findParking(actionEntity) async {
    ArgumentError.checkNotNull(actionEntity, 'actionEntity');
    const _extra = <String, dynamic>{};
    final queryParameters = <String, dynamic>{};
    final _data = <String, dynamic>{};
    _data.addAll(actionEntity?.toJson() ?? <String, dynamic>{});
    final _result = await _dio.request<List<dynamic>>('acs/actions',
        queryParameters: queryParameters,
        options: RequestOptions(
            method: 'POST',
            headers: <String, dynamic>{},
            extra: _extra,
            baseUrl: baseUrl),
        data: _data);
    var value = _result.data
        .map((dynamic i) => ElementEntity.fromJson(i as Map<String, dynamic>))
        .toList();
    return value;
  }

  @override
  Future<void> markPark(actionEntity) async {
    ArgumentError.checkNotNull(actionEntity, 'actionEntity');
    const _extra = <String, dynamic>{};
    final queryParameters = <String, dynamic>{};
    final _data = <String, dynamic>{};
    _data.addAll(actionEntity?.toJson() ?? <String, dynamic>{});
    await _dio.request<void>('acs/actions',
        queryParameters: queryParameters,
        options: RequestOptions(
            method: 'POST',
            headers: <String, dynamic>{},
            extra: _extra,
            baseUrl: baseUrl),
        data: _data);
    return null;
  }
}

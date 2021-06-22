// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'user_api.dart';

// **************************************************************************
// RetrofitGenerator
// **************************************************************************

class _UserApi implements UserApi {
  _UserApi(this._dio, {this.baseUrl}) {
    ArgumentError.checkNotNull(_dio, '_dio');
    baseUrl ??= 'https://spring-wepark.herokuapp.com/';
  }

  final Dio _dio;

  String baseUrl;

  @override
  Future<UserEntity> getLogin(userDomain, userEmail) async {
    ArgumentError.checkNotNull(userDomain, 'userDomain');
    ArgumentError.checkNotNull(userEmail, 'userEmail');
    const _extra = <String, dynamic>{};
    final queryParameters = <String, dynamic>{};
    final _data = <String, dynamic>{};
    final _result = await _dio.request<Map<String, dynamic>>(
        'acs/users/login/$userDomain/$userEmail',
        queryParameters: queryParameters,
        options: RequestOptions(
            method: 'GET',
            headers: <String, dynamic>{},
            extra: _extra,
            baseUrl: baseUrl),
        data: _data);
    final value = UserEntity.fromJson(_result.data);
    return value;
  }

  @override
  Future<UserEntity> createUser(newUserDetails) async {
    ArgumentError.checkNotNull(newUserDetails, 'newUserDetails');
    const _extra = <String, dynamic>{};
    final queryParameters = <String, dynamic>{};
    final _data = <String, dynamic>{};
    _data.addAll(newUserDetails?.toJson() ?? <String, dynamic>{});
    final _result = await _dio.request<Map<String, dynamic>>('acs/users',
        queryParameters: queryParameters,
        options: RequestOptions(
            method: 'POST',
            headers: <String, dynamic>{},
            extra: _extra,
            baseUrl: baseUrl),
        data: _data);
    final value = UserEntity.fromJson(_result.data);
    return value;
  }

  @override
  Future<void> updateUser(userDomain, userEmail, userEntity) async {
    ArgumentError.checkNotNull(userDomain, 'userDomain');
    ArgumentError.checkNotNull(userEmail, 'userEmail');
    ArgumentError.checkNotNull(userEntity, 'userEntity');
    const _extra = <String, dynamic>{};
    final queryParameters = <String, dynamic>{};
    final _data = <String, dynamic>{};
    _data.addAll(userEntity?.toJson() ?? <String, dynamic>{});
    await _dio.request<void>('acs/users/$userDomain/$userEmail',
        queryParameters: queryParameters,
        options: RequestOptions(
            method: 'PUT',
            headers: <String, dynamic>{},
            extra: _extra,
            baseUrl: baseUrl),
        data: _data);
    return null;
  }
}

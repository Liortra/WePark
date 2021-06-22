import 'package:retrofit/http.dart';
import 'package:wepark/application/api_configuration.dart';
import 'package:wepark/data/model/newuserdetails/new_user_details.dart';
import 'package:dio/dio.dart';

import 'package:wepark/data/model/entities/entities.dart';

part 'user_api.g.dart';

@RestApi(baseUrl: ApiConfiguration.BASE_URL)
abstract class UserApi {
  factory UserApi(Dio dio, {String baseUrl}) = _UserApi;

  @GET("acs/users/login/{userDomain}/{userEmail}")
  Future<UserEntity> getLogin(@Path("userDomain") String userDomain,
      @Path("userEmail") String userEmail);

  @POST("acs/users")
  Future<UserEntity> createUser(@Body() NewUserDetails newUserDetails);

  @PUT("acs/users/{userDomain}/{userEmail}")
  Future<void> updateUser(@Path("userDomain") String userDomain,
      @Path("userEmail") String userEmail, @Body() UserEntity userEntity);
}

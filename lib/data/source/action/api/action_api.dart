import 'package:retrofit/http.dart';
import 'package:dio/dio.dart';
import 'package:wepark/application/api_configuration.dart';
import 'package:wepark/data/model/entities/entities.dart';

part 'action_api.g.dart';

@RestApi(baseUrl: ApiConfiguration.BASE_URL)
abstract class ActionApi {
  factory ActionApi(Dio dio, {String baseUrl}) = _ActionApi;

  @POST("acs/actions")
  Future<List<ElementEntity>> findParking(@Body() ActionEntity actionEntity);

  @POST("acs/actions")
  Future<void> markPark(@Body() ActionEntity actionEntity);

  /*
  * FIND - entity
  * PARK - bool
  * UNPARK - bool
  * */
}
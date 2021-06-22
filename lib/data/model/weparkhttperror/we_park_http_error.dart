import 'package:json_annotation/json_annotation.dart';
part 'we_park_http_error.g.dart';

@JsonSerializable()
class WeParkHttpError implements Exception {

  @JsonKey(name:"status")
  final int status;
  @JsonKey(name:"error")
  final String error;
  @JsonKey(name:"message")
  final String message;

  WeParkHttpError(this.status, this.error, this.message);

  Map<String, dynamic> toJson() => _$WeParkHttpErrorToJson(this);

  factory WeParkHttpError.fromJson(Map<String, dynamic> item) => _$WeParkHttpErrorFromJson(item);

}


// {
// timestamp: "2021-01-25T10:08:35.672+00:00",
// status: 500,
// error: "Internal Server Error",
// message: "",
// path: "/acs/actions"
// }
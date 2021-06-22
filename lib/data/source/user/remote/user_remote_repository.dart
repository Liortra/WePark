import 'package:wepark/data/model/newuserdetails/new_user_details.dart';
import 'package:wepark/data/source/user/api/user_api.dart';
import 'package:wepark/data/source/user/user_data_source.dart';
import 'package:wepark/data/model/entities/entities.dart';

class UserRemoteRepository implements UserDataSourceRemote {
  final UserApi _api;

  UserRemoteRepository(this._api);

  @override
  Future<UserEntity> createUser(NewUserDetails newUserDetails) =>
      _api.createUser(newUserDetails);

  @override
  Future<UserEntity> login(String domain, String email) =>
      _api.getLogin(domain, email);

  @override
  Future<void> updateUser(String domain, String email, UserEntity userEntity) =>
      _api.updateUser(domain, email, userEntity);
}

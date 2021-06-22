import 'package:wepark/data/model/newuserdetails/new_user_details.dart';
import 'package:wepark/data/source/user/user_data_source.dart';
import 'package:wepark/utils/exceptions/wepark_exceptions.dart';
import 'package:wepark/data/model/entities/entities.dart';

class UserRepository {
  final UserDataSourceLocal _local;
  final UserDataSourceRemote _remote;

  UserRepository(this._local, this._remote);

  Future<UserEntity> createUser(NewUserDetails newUserDetails) {
    return _remote
        .createUser(newUserDetails)
        .then((userEntity) => _local.saveUserEntity(userEntity))
        .then((_) => _local.loadUser());
  }

  Future<UserEntity> login(String domain, String email) {
    return _remote
        .login(domain, email)
        .then((userEntity) => _local.saveUserEntity(userEntity))
        .then((_) => _local.loadUser());
  }

  Future<void> updateUser(String domain, String email, UserEntity userEntity) {
    return _remote
        .updateUser(domain, email, userEntity)
        .then((value) => _local.saveUserEntity(userEntity));
  }

  Future<UserEntity> loadUser() {
    return _local.loadUser().then((user) {
      if (user == null)
        throw UserNotExistsInCache(message: "user is null");
      else
        return user;
    });
  }
}

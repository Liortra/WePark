import 'package:wepark/data/source/user/user_data_source.dart';

import 'package:wepark/data/model/entities/entities.dart';

class UserLocalRepository implements UserDataSourceLocal {
  UserEntity _userEntityCache;

  @override
  Future<UserEntity> loadUser() async {
    return _userEntityCache;
  }

  @override
  Future<void> saveUserEntity(UserEntity userEntity) async {
    _userEntityCache = userEntity;
  }
}

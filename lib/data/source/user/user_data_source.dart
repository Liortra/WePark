import 'package:wepark/data/model/newuserdetails/new_user_details.dart';
import 'package:wepark/data/model/entities/entities.dart';

class UserDataSourceLocal {
  Future<void> saveUserEntity(UserEntity userEntity) {}

  Future<UserEntity> loadUser() {}
}

class UserDataSourceRemote {
  Future<UserEntity> createUser(NewUserDetails newUserDetails) {}

  Future<UserEntity> login(String domain, String email) {}

  Future<void> updateUser(String domain, String email, UserEntity userEntity) {}
}

import 'package:wepark/data/model/entities/entities.dart';

abstract class BaseSettingsState {}

class InitalSettingsState extends BaseSettingsState{
  final UserEntity userEntity;
  final int percent;

  InitalSettingsState(this.userEntity, this.percent);
}
class DefaultSettingsState extends BaseSettingsState {
  final bool enable;

  DefaultSettingsState(this.enable);
}

class LoadingSettingsState extends BaseSettingsState {}

class FinishSettingsState extends BaseSettingsState {}

class ErrorSettingsState extends BaseSettingsState {
  final String message;
  final dynamic error;

  ErrorSettingsState(this.message, {this.error});
}

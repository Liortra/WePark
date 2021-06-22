abstract class BaseRegistrationState {}

class DefaultRegistrationState extends BaseRegistrationState {
  final bool enable;

  DefaultRegistrationState(this.enable);
}

class LoadingRegistrationState extends BaseRegistrationState {}

class FinishRegistrationState extends BaseRegistrationState {}

class ErrorRegistrationState extends BaseRegistrationState {
  final String message;
  final dynamic error;

  ErrorRegistrationState(this.message, {this.error});
}

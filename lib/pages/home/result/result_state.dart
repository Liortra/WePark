abstract class BaseResultState {}
class InitialResultState extends BaseResultState {}

class ActiveCountUpState extends BaseResultState {
  final bool active;

  ActiveCountUpState(this.active);
}


// class DisplayTimerState extends BaseResultState {
//   final int seconds;
//   DisplayTimerState(this.seconds);
// }
//
// class FinishTimerState extends BaseResultState {}
//
class FinishParkState extends BaseResultState{}

class ErrorResultState extends BaseResultState{
  final String message;
  final dynamic error;

  ErrorResultState(this.message, {this.error});
}

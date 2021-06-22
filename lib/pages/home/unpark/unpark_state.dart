abstract class BaseUnParkState {}

class InitalUnParkState extends BaseUnParkState{}

class FinishUnParkState extends BaseUnParkState{}

class ErrorUnParkState extends BaseUnParkState{
  final String message;
  final dynamic error;

  ErrorUnParkState(this.message, {this.error});
}
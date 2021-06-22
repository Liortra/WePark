import 'package:wepark/data/model/entities/element_entity/element_entity.dart';

abstract class BaseScanState {}
class LoadingScanState extends BaseScanState {}
class FinishScanningSuccessfullyState extends BaseScanState {}
class ErrorScanState extends BaseScanState {
  final String message;
  final dynamic error;

  ErrorScanState(this.message, {this.error});
}
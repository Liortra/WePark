import 'package:wepark/data/model/diff_time_funcion.dart';

class CalculateDiffTimeUtils {

  static Future<DiffTimeFunction> calculateDiffAsync(Future<void> future) async {
    final difFunc = DiffTimeFunction();
    difFunc.start = DateTime.now();
    await future;
    difFunc.end = DateTime.now();
    return difFunc;
  }

  static DiffTimeFunction calculateDiff(Function function) {
    final difFunc = DiffTimeFunction();
    difFunc.start = DateTime.now();
    function.call();
    difFunc.end = DateTime.now();
    return difFunc;
  }
}

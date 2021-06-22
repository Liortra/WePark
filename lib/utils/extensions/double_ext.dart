extension DoubleExt on double {

  String printDuration() {
    final duration = Duration(seconds: this.toInt());
    String twoDigits(int n) => n.toString().padLeft(2, "0");
    String twoDigitMinutes = twoDigits(duration.inMinutes.remainder(60));
    String twoDigitSeconds = twoDigits(duration.inSeconds.remainder(60));
    return "${twoDigits(duration.inHours)}:$twoDigitMinutes:$twoDigitSeconds";
  }

  double convertMeterBySecToKmByHour(){
    return (this * 18.0)/5.0;
  }

}
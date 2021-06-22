import 'dart:async';

import 'package:flutter/material.dart';
import 'package:wepark/utils/sizeconfig/size_config.dart';

class CountUp extends StatefulWidget {

  final bool active;

  const CountUp({Key key, this.active = false}) : super(key: key);

  @override
  _CountUpState createState() => _CountUpState();
}

class _CountUpState extends State<CountUp> {

  Timer timer;
  var countUpText = "00:00:00";


  @override
  void initState() {
    super.initState();
    if(widget.active) _activeCountUp();
  }


  @override
  void didUpdateWidget(CountUp oldWidget) {
    super.didUpdateWidget(oldWidget);
    if(!oldWidget.active && widget.active) _activeCountUp();
  }

  _activeCountUp(){
    timer = Timer.periodic(Duration(seconds: 1), (timer) {
      final duration = Duration(seconds: timer.tick);
      String twoDigits(int n) => n.toString().padLeft(2, "0");
      String twoDigitMinutes = twoDigits(duration.inMinutes.remainder(60));
      String twoDigitSeconds = twoDigits(duration.inSeconds.remainder(60));
      setState(() {
        countUpText = "${twoDigits(duration.inHours)}:$twoDigitMinutes:$twoDigitSeconds";
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    SizeConfig().init(context);
    return Container(
      child: Text(countUpText,style: TextStyle(fontSize: SizeConfig.spacing_extra_vertical,color: Colors.white),textAlign: TextAlign.center,),
    );
  }


  @override
  void dispose() {
    timer?.cancel();
    timer = null;
    super.dispose();
  }
}

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class GeneralWeParkDialog {
  static Future<void> show(
      {@required BuildContext context,
      @required String title,
      @required String message,
      @required String buttonTxt,
      Function onClick}) {
    return showDialog(
        context: context,
        builder: (_) => AlertDialog(
              title: Text(title),
              content: Text(message),
              actions: [
                TextButton(
                  onPressed: () {
                    Navigator.pop(context);
                    onClick?.call();
                  },
                  child: Text(buttonTxt),
                ),
              ],
            ));
  }
}

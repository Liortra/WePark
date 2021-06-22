import 'package:flutter/material.dart';

class Logo extends StatefulWidget {
  final double horizontal;
  final double vertical;
  final String path;

  const Logo({Key key, this.horizontal, this.vertical, @required this.path})
      : super(key: key);

  @override
  _LogoState createState() => _LogoState();
}

class _LogoState extends State<Logo> {
  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.symmetric(
          horizontal: widget.horizontal??0, vertical: widget.vertical??0),
      child: Image.asset(widget.path),
    );
  }
}

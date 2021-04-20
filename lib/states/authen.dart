import 'package:flutter/material.dart';

class Authen extends StatefulWidget {
  @override
  _AuthenState createState() => _AuthenState();
}

class _AuthenState extends State<Authen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: buildLogo(),
    );
  }

  Container buildLogo() {
    return Container(
      width: 120,
      child: Image.asset('images/logo.png'),
    );
  }
}

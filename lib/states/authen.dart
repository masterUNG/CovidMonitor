import 'dart:convert';

import 'package:covidmonitor/models/user_model.dart';
import 'package:covidmonitor/utility/dialog.dart';
import 'package:covidmonitor/utility/my_constant.dart';
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class Authen extends StatefulWidget {
  @override
  _AuthenState createState() => _AuthenState();
}

class _AuthenState extends State<Authen> {
  String user, password;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          buildWall(),
          buildContent(),
          buildCreateAccount(),
        ],
      ),
    );
  }

  Container buildWall() {
    return Container(
      decoration: BoxDecoration(
        image: DecorationImage(
          image: AssetImage('images/wall.jpg'),
          fit: BoxFit.cover,
        ),
      ),
    );
  }

  Column buildCreateAccount() {
    return Column(
      mainAxisAlignment: MainAxisAlignment.end,
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              'Non Account',
              style: TextStyle(
                color: Colors.white,
              ),
            ),
            TextButton(
              onPressed: () => Navigator.pushNamed(context, '/createAccount'),
              child: Text('Create New Account!'),
            ),
          ],
        ),
      ],
    );
  }

  Center buildContent() {
    return Center(
      child: SingleChildScrollView(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            buildLogo(),
            buildText(),
            buildUser(),
            buildPassword(),
            buildLogin(),
          ],
        ),
      ),
    );
  }

  Container buildLogin() {
    return Container(
      width: 250,
      child: ElevatedButton(
        onPressed: () {
          if ((user?.isEmpty ?? true) || (password?.isEmpty ?? true)) {
            normalDialog(context, 'กรอกไม่ครบ ?', 'กรุณากรอก ทุกช่องคะ !!!');
          } else {
            checkAuthen();
          }
        },
        child: Text('Login'),
        style: ElevatedButton.styleFrom(
          shape:
              RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
          primary: Colors.red[900],
        ),
      ),
    );
  }

  Future<Null> checkAuthen() async {
    String path =
        '${MyConstant().domain}/covidmonitor/getUserWhereUser.php?isAdd=true&user=$user';
    await Dio().get(path).then((value) async {
      print('response form API ==> $value');
      if (value.toString() == 'null') {
        normalDialog(context, 'User False ?', 'No This $user in my database');
      } else {
        for (var item in json.decode(value.data)) {
          print('item ==> $item');
          UserModel model = UserModel.fromMap(item);
          // String password = item['password'];
          // String password = model.password;
          if (password == model.password) {
            SharedPreferences preferences =
                await SharedPreferences.getInstance();
            preferences.setString('user', model.user);
            preferences.setString('name', model.name);
            preferences.setString('id', model.id);

            Navigator.pushNamedAndRemoveUntil(
                context, '/myService', (route) => false);
          } else {
            normalDialog(
                context, 'Password False', 'Please Try Agains Password False');
          }
        }
      }
    });
  }

  Container buildUser() {
    return Container(
      decoration: BoxDecoration(
          color: Colors.white70, borderRadius: BorderRadius.circular(20)),
      width: 250,
      child: TextField(
        onChanged: (value) => user = value.trim(),
        decoration: InputDecoration(
          labelText: 'User :',
          prefixIcon: Icon(Icons.account_circle_rounded),
          border: OutlineInputBorder(borderRadius: BorderRadius.circular(20)),
        ),
      ),
    );
  }

  Container buildPassword() {
    return Container(
      decoration: BoxDecoration(
          color: Colors.white70, borderRadius: BorderRadius.circular(20)),
      margin: EdgeInsets.symmetric(vertical: 16),
      width: 250,
      child: TextField(
        onChanged: (value) => password = value.trim(),
        obscureText: true,
        decoration: InputDecoration(
          labelText: 'Password :',
          prefixIcon: Icon(Icons.lock_rounded),
          border: OutlineInputBorder(borderRadius: BorderRadius.circular(20)),
        ),
      ),
    );
  }

  Container buildText() => Container(
        margin: EdgeInsets.symmetric(vertical: 16),
        child: Text(
          'Covid Monitor',
          style: TextStyle(
            fontSize: 30,
            fontWeight: FontWeight.bold,
            color: Colors.yellow[300],
          ),
        ),
      );

  Container buildLogo() {
    return Container(
      width: 120,
      child: Image.asset('images/logo.png'),
    );
  }
}

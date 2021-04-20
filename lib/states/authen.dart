import 'package:flutter/material.dart';

class Authen extends StatefulWidget {
  @override
  _AuthenState createState() => _AuthenState();
}

class _AuthenState extends State<Authen> {
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
              onPressed: () {},
              child: Text('Create New Account!'),
            ),
          ],
        ),
      ],
    );
  }

  Center buildContent() {
    return Center(
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
    );
  }

  Container buildLogin() {
    return Container(
      width: 250,
      child: ElevatedButton(
        onPressed: () {},
        child: Text('Login'),
        style: ElevatedButton.styleFrom(
          shape:
              RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
          primary: Colors.red[900],
        ),
      ),
    );
  }

  Container buildUser() {
    return Container(
      decoration: BoxDecoration(
          color: Colors.white70, borderRadius: BorderRadius.circular(20)),
      width: 250,
      child: TextField(
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

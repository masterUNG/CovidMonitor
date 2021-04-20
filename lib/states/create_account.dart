import 'package:flutter/material.dart';

class CreateAccount extends StatefulWidget {
  @override
  _CreateAccountState createState() => _CreateAccountState();
}

class _CreateAccountState extends State<CreateAccount> {
  String gender;

  Container buildName() {
    return Container(
      margin: EdgeInsets.only(top: 16),
      decoration: BoxDecoration(
          color: Colors.white70, borderRadius: BorderRadius.circular(20)),
      width: 250,
      child: TextField(
        decoration: InputDecoration(
          labelText: 'Name :',
          prefixIcon: Icon(Icons.fingerprint),
          border: OutlineInputBorder(borderRadius: BorderRadius.circular(20)),
        ),
      ),
    );
  }

  Container buildAddress() {
    return Container(
      margin: EdgeInsets.symmetric(vertical: 16),
      decoration: BoxDecoration(
          color: Colors.white70, borderRadius: BorderRadius.circular(20)),
      width: 250,
      child: TextField(
        decoration: InputDecoration(
          labelText: 'Address :',
          prefixIcon: Icon(Icons.home),
          border: OutlineInputBorder(borderRadius: BorderRadius.circular(20)),
        ),
      ),
    );
  }

  Container buildPhone() {
    return Container(
      decoration: BoxDecoration(
          color: Colors.white70, borderRadius: BorderRadius.circular(20)),
      width: 250,
      child: TextField(
        decoration: InputDecoration(
          labelText: 'Phone :',
          prefixIcon: Icon(Icons.phone),
          border: OutlineInputBorder(borderRadius: BorderRadius.circular(20)),
        ),
      ),
    );
  }

  Container buildUser() {
    return Container(
      margin: EdgeInsets.symmetric(vertical: 16),
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
      width: 250,
      child: TextField(
        decoration: InputDecoration(
          labelText: 'Password :',
          prefixIcon: Icon(Icons.lock),
          border: OutlineInputBorder(borderRadius: BorderRadius.circular(20)),
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('สมัครสมาชิค'),
      ),
      body: Center(
        child: SingleChildScrollView(
          child: Column(
            children: [
              Container(width: 350,
                child: Image.asset('images/account.png'),
              ),
              buildName(),
              buildTitle(),
              buildRow(),
              buildAddress(),
              buildPhone(),
              buildUser(),
              buildPassword(),
              Container(
                  width: 250,
                  margin: EdgeInsets.symmetric(vertical: 16),
                  child: ElevatedButton.icon(
                    onPressed: () {},
                    icon: Icon(Icons.cloud_upload),
                    label: Text('Create Account'),
                  )),
            ],
          ),
        ),
      ),
    );
  }

  Row buildRow() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Container(
          width: 150,
          child: RadioListTile(
            value: 'male',
            groupValue: gender,
            onChanged: (value) {
              setState(() {
                gender = value;
              });
            },
            title: Text('Male'),
          ),
        ),
        Container(
          width: 150,
          child: RadioListTile(
            value: 'female',
            groupValue: gender,
            onChanged: (value) {
              setState(() {
                gender = value;
              });
            },
            title: Text('Female'),
          ),
        ),
      ],
    );
  }

  Container buildTitle() {
    return Container(
      margin: EdgeInsets.only(top: 16),
      width: 250,
      child: Text(
        'Gender :',
        style: TextStyle(
          fontWeight: FontWeight.bold,
        ),
      ),
    );
  }
}

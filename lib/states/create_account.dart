import 'package:covidmonitor/utility/dialog.dart';
import 'package:covidmonitor/utility/my_constant.dart';
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';

class CreateAccount extends StatefulWidget {
  @override
  _CreateAccountState createState() => _CreateAccountState();
}

class _CreateAccountState extends State<CreateAccount> {
  String gender, name, address, phone, user, password;

  Container buildName() {
    return Container(
      margin: EdgeInsets.only(top: 16),
      decoration: BoxDecoration(
          color: Colors.white70, borderRadius: BorderRadius.circular(20)),
      width: 250,
      child: TextField(
        onChanged: (value) => name = value.trim(),
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
        onChanged: (value) => address = value.trim(),
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
        onChanged: (value) => phone = value.trim(),
        keyboardType: TextInputType.phone,
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
      width: 250,
      child: TextField(
        onChanged: (value) => password = value.trim(),
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
              Container(
                width: 350,
                child: Image.asset('images/account.png'),
              ),
              buildName(),
              buildTitle(),
              buildRow(),
              buildAddress(),
              buildPhone(),
              buildUser(),
              buildPassword(),
              buildButtonCreateAccount(),
            ],
          ),
        ),
      ),
    );
  }

  Container buildButtonCreateAccount() {
    return Container(
        width: 250,
        margin: EdgeInsets.symmetric(vertical: 16),
        child: ElevatedButton.icon(
          onPressed: () {
            if ((name?.isEmpty ?? true) ||
                (address?.isEmpty ?? true) ||
                (phone?.isEmpty ?? true) ||
                (user?.isEmpty ?? true) ||
                (password?.isEmpty ?? true)) {
              normalDialog(context, 'Have Space ?', 'Please Fill Every Blank');
            } else if (gender == null) {
              normalDialog(context, 'No Gender ?', 'Please Tap Male or Female');
            } else {
              checkUser();
            }
          },
          icon: Icon(Icons.cloud_upload),
          label: Text('Create Account'),
        ));
  }

  Future<Null> checkUser() async {
    String path =
        '${MyConstant().domain}/covidmonitor/getUserWhereUser.php?isAdd=true&user=$user';
    await Dio().get(path).then((value) async {
      print('value = $value');
      if (value.toString() != 'null') {
        normalDialog(
            context, 'User False', '$user user นี่ มีคนอื่นใช้ไปแล้ว คะ');
      } else {
        String path2 =
            '${MyConstant().domain}/covidmonitor/insertUser.php?isAdd=true&name=$name&gender=$gender&address=$address&phone=$phone&user=$user&password=$password';
        await Dio().get(path2).then((value) {
          if (value.toString() == 'true') {
            Navigator.pop(context);
          } else {
            normalDialog(
                context, 'Create User False', 'Please Fill EveryBlank');
          }
        });
      }
    });
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

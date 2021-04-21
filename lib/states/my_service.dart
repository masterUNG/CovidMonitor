import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class MyService extends StatefulWidget {
  @override
  _MyServiceState createState() => _MyServiceState();
}

class _MyServiceState extends State<MyService> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('My Service'),
      ),
      drawer: Drawer(
        child: buildSignOut(),
      ),
    );
  }

  Column buildSignOut() {
    return Column(
      mainAxisAlignment: MainAxisAlignment.end,
      children: [
        ListTile(
          leading: Icon(
            Icons.exit_to_app,
            color: Colors.white,
            size: 36,
          ),
          title: Text(
            'Sign Out',
            style: TextStyle(color: Colors.white),
          ),
          subtitle: Text(
            'ออกจาก Account ที่ Login อยู่',
            style: TextStyle(color: Colors.white),
          ),
          tileColor: Colors.red,
          onTap: () async {
            SharedPreferences preferences =
                await SharedPreferences.getInstance();
            preferences.clear();

            Navigator.pushNamedAndRemoveUntil(
                context, '/authen', (route) => false);
          },
        ),
      ],
    );
  }
}

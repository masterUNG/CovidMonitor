import 'package:covidmonitor/widget/informaion.dart';
import 'package:covidmonitor/widget/list_temp.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class MyService extends StatefulWidget {
  @override
  _MyServiceState createState() => _MyServiceState();
}

class _MyServiceState extends State<MyService> {
  String name;
  Widget current = ListTemp();

  @override
  void initState() {
    super.initState();
    findUser();
  }

  Future<Null> findUser() async {
    SharedPreferences preferences = await SharedPreferences.getInstance();
    setState(() {
      name = preferences.getString('name');
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('My Service'),
      ),
      drawer: Drawer(
        child: Stack(
          children: [
            buildSignOut(),
            Column(
              children: [
                buildUserAccountsDrawerHeader(),
                buildMenuListTemp(),
                buildMenuInformation(),
              ],
            ),
          ],
        ),
      ),
      body: current,
    );
  }

  ListTile buildMenuListTemp() {
    return ListTile(
      leading: Icon(
        Icons.fact_check,
        size: 36,
      ),
      title: Text('List Temp'),
      subtitle: Text('อุณหภูมิ ที่วัดได้'),
      onTap: () {
        setState(() {
          current = ListTemp();
        });
        Navigator.pop(context);
      },
    );
  }

  ListTile buildMenuInformation() {
    return ListTile(
      leading: Icon(
        Icons.article,
        size: 36,
      ),
      title: Text('Information'),
      subtitle: Text('รายละเอียด ของ User ที่ Login อยู่'),
      onTap: () {
        setState(() {
          current = Information();
        });
        Navigator.pop(context);
      },
    );
  }

  UserAccountsDrawerHeader buildUserAccountsDrawerHeader() {
    return UserAccountsDrawerHeader(
      decoration: BoxDecoration(
        image: DecorationImage(
          image: AssetImage('images/wall.jpg'),
          fit: BoxFit.cover,
        ),
      ),
      accountName: Text(name == null ? 'Name ?' : name),
      accountEmail: Text('Login'),
      currentAccountPicture: Image.asset('images/logo.png'),
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

import 'package:covidmonitor/states/add_temp.dart';
import 'package:covidmonitor/states/authen.dart';
import 'package:covidmonitor/states/create_account.dart';
import 'package:covidmonitor/states/my_service.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

final Map<String, WidgetBuilder> map = {
  '/authen': (BuildContext context) => Authen(),
  '/createAccount': (BuildContext context) => CreateAccount(),
  '/myService': (BuildContext context) => MyService(),
  '/addTemp': (BuildContext context) => AddTemp(),
};

String initialRount = '/authen';

// main() => runApp(MyApp());

Future<Null> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  SharedPreferences preferences = await SharedPreferences.getInstance();
  String user = preferences.getString('user');
  print('###### user => $user');
  if (user?.isEmpty ?? true) {
    initialRount = '/authen';
    runApp(MyApp());
  } else {
    initialRount = '/myService';
    runApp(MyApp());
  }
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      routes: map,
      initialRoute: initialRount,
    );
  }
}

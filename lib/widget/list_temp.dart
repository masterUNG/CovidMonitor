import 'package:covidmonitor/utility/my_constant.dart';
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class ListTemp extends StatefulWidget {
  @override
  _ListTempState createState() => _ListTempState();
}

class _ListTempState extends State<ListTemp> {
  bool statusLoad = true;

  @override
  void initState() {
    super.initState();
    readTemp();
  }

  Future<Null> readTemp() async {
    SharedPreferences preferences = await SharedPreferences.getInstance();
    String idUser = preferences.getString('id');

    String path =
        '${MyConstant().domain}/covidmonitor/getTempWhereIdUser.php?isAdd=true&idUser=$idUser';

    await Dio().get(path).then((value) {
      print('### value @ idUser = $idUser ===> $value');
      setState(() {
        statusLoad = false;
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: statusLoad
          ? Center(child: CircularProgressIndicator())
          : Text('Load Finish'),
    );
  }
}

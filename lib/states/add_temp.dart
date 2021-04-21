
import 'dart:io';
import 'dart:math';

import 'package:covidmonitor/utility/dialog.dart';
import 'package:covidmonitor/utility/my_constant.dart';
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:intl/intl.dart';
import 'package:shared_preferences/shared_preferences.dart';

class AddTemp extends StatefulWidget {
  @override
  _AddTempState createState() => _AddTempState();
}

class _AddTempState extends State<AddTemp> {
  String recDateTime, recHourTime, recTemp, urlTemp, idUser;
  File file;

  @override
  void initState() {
    super.initState();
    findDateHourTime();
  }

  Future<Null> findDateHourTime() async {
    DateTime dateTime = DateTime.now();
    print('### dateTime = $dateTime');
    DateFormat dateFormat = DateFormat('dd/MM/yyyy');
    DateFormat timeFormat = DateFormat('HH:mm');

    setState(() {
      recDateTime = dateFormat.format(dateTime);
      recHourTime = timeFormat.format(dateTime);
    });
    print('recDateTime = $recDateTime');
    print('recHourTime = $recHourTime');
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Add Data'),
      ),
      body: Center(
        child: SingleChildScrollView(
          child: Column(
            children: [
              buildImage(),
              buildICamera(),
              buildShowDateTime(),
              buildTime(),
              buildRecord(),
            ],
          ),
        ),
      ),
    );
  }

  Container buildRecord() {
    return Container(
      margin: EdgeInsets.only(top: 16),
      child: ElevatedButton(
        onPressed: () => confirmTemp(),
        child: Text('Record'),
      ),
    );
  }

  Future<Null> confirmTemp() async {
    showDialog(
      context: context,
      builder: (context) => SimpleDialog(
        title: ListTile(
          leading: Image.file(file),
          title: Text('กรอก Temp ด้วย คะ'),
          subtitle: Text('กรุณากรอง Temp ที่วันได้ใน ช่องว่างด้วยคะ'),
        ),
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Container(
                width: 200,
                child: TextField(
                  onChanged: (value) => recTemp = value.trim(),
                  keyboardType: TextInputType.number,
                  decoration: InputDecoration(
                    border: OutlineInputBorder(),
                    hintText: 'xx.x',
                  ),
                ),
              ),
            ],
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              TextButton(
                  onPressed: () {
                    Navigator.pop(context);
                    if (recTemp?.isEmpty ?? true) {
                      normalDialog(
                          context, 'ต้องกรอก Temp', 'กรุณากรอก Temp ด้วยคะ');
                    } else {
                      processUploadAndInsertTemp();
                    }
                  },
                  child: Text('Confirm')),
              TextButton(
                  onPressed: () => Navigator.pop(context),
                  child: Text('Cancel')),
            ],
          )
        ],
      ),
    );
  }

  Text buildTime() {
    return Text(
      recHourTime == null ? 'HH:mm' : recHourTime,
      style: TextStyle(
        fontSize: 20,
        fontWeight: FontWeight.bold,
      ),
    );
  }

  Container buildShowDateTime() {
    return Container(
      margin: EdgeInsets.symmetric(vertical: 16),
      child: Text(
        recDateTime == null ? 'DateTime' : recDateTime,
        style: TextStyle(
          fontSize: 20,
          fontWeight: FontWeight.bold,
        ),
      ),
    );
  }

  IconButton buildICamera() => IconButton(
        icon: Icon(
          Icons.add_a_photo,
          size: 48,
        ),
        onPressed: () => takePhoto(),
      );

  Future<Null> takePhoto() async {
    try {
      var object = await ImagePicker().getImage(
        source: ImageSource.camera,
        maxWidth: 800,
        maxHeight: 800,
      );
      setState(() {
        file = File(object.path);
      });
    } catch (e) {}
  }

  Container buildImage() {
    return Container(
      margin: EdgeInsets.symmetric(
        vertical: 36,
      ),
      width: 250,
      height: 250,
      child: file == null ? Image.asset('images/logo.png') : Image.file(file),
    );
  }

  Future<Null> processUploadAndInsertTemp() async {
    int i = Random().nextInt(100000);
    String nameImage = 'temp$i.jpg';
    String pathSaveFile = '${MyConstant().domain}/covidmonitor/saveFile.php';

    SharedPreferences preferences = await SharedPreferences.getInstance();
    idUser = preferences.getString('id');

    try {
      Map<String, dynamic> map = Map();
      map['file'] =
          await MultipartFile.fromFile(file.path, filename: nameImage);
      FormData data = FormData.fromMap(map);
      await Dio().post(pathSaveFile, data: data).then((value) async {
        urlTemp = '/covidmonitor/upload/$nameImage';
        print('urlTemp ==> ${MyConstant().domain}$urlTemp');
        String pathInsertData =
            '${MyConstant().domain}/covidmonitor/insertTemp.php?isAdd=true&idUser=$idUser&recDateTime=$recDateTime&recHourTime=$recHourTime&recTemp=$recTemp&urlTemp=$urlTemp';
        await Dio().get(pathInsertData).then((value) {
          if (value.toString() == 'true') {
            Navigator.pop(context);
          } else {
            normalDialog(context, 'Cannot Upload', 'Please Try Again');
          }
        });
      });
    } catch (e) {}
  }
}

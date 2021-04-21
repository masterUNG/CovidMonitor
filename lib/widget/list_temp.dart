import 'dart:convert';

import 'package:covidmonitor/models/temp_model.dart';
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
  bool haveData;
  List<TempModel> tempModels = [];

  @override
  void initState() {
    super.initState();
    readTemp();
  }

  Future<Null> readTemp() async {
    if (tempModels.length != 0) {
      tempModels.clear();
    }

    SharedPreferences preferences = await SharedPreferences.getInstance();
    String idUser = preferences.getString('id');

    String path =
        '${MyConstant().domain}/covidmonitor/getTempWhereIdUser.php?isAdd=true&idUser=$idUser';

    await Dio().get(path).then((value) {
      print('### value @ idUser = $idUser ===> $value');
      if (value.toString() == 'null') {
        setState(() {
          haveData = false;
        });
      } else {
        for (var item in json.decode(value.data)) {
          TempModel model = TempModel.fromMap(item);
          setState(() {
            tempModels.add(model);
          });
        }

        setState(() {
          haveData = true;
        });
      }
      setState(() {
        statusLoad = false;
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      floatingActionButton: FloatingActionButton(
        onPressed: () => Navigator.pushNamed(context, '/addTemp')
            .then((value) => readTemp()),
        child: Text('Add'),
      ),
      body: statusLoad
          ? Center(child: CircularProgressIndicator())
          : haveData
              ? ListView.builder(
                  itemCount: tempModels.length,
                  itemBuilder: (context, index) => Card(
                                      child: Padding(
                                        padding: const EdgeInsets.all(16.0),
                                        child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          tempModels[index].recDateTime,
                          style: TextStyle(
                            fontSize: 30,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        Row(mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Column(
                              children: [
                                Text(tempModels[index].recHourTime),
                                Text(tempModels[index].recTemp, style: TextStyle(fontSize: 20, color: Colors.red),),
                              ],
                            ),
                            Container(
                              width: 200,
                              child: Image.network(
                                  '${MyConstant().domain}${tempModels[index].urlTemp}'),
                            ),
                          ],
                        )
                      ],
                    ),
                                      ),
                  ),
                )
              : buildNoData(),
    );
  }

  Center buildNoData() => Center(
          child: Text(
        'No Data',
        style: TextStyle(fontSize: 40, fontWeight: FontWeight.bold),
      ));
}

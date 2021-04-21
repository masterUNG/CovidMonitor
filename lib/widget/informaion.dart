import 'package:covidmonitor/models/user_model.dart';
import 'package:flutter/material.dart';

class Information extends StatelessWidget {
  UserModel userModel;

  Information({this.userModel});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: Card(color: Colors.green[100],
              child: Container(padding: EdgeInsets.all(16),
          height: MediaQuery.of(context).size.height * 0.3,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              buildName(),
              buildGender(),
              buildAddress(),
              buildPhone(),
            ],
          ),
        ),
      ),
    );
  }

  Row buildName() {
    return Row(
      children: [
        Expanded(
          flex: 1,
          child: Text(
            'Name :',
            style: TextStyle(
              fontWeight: FontWeight.bold,
              fontSize: 16,
            ),
          ),
        ),
        Expanded(
            flex: 3,
            child: Text(
              userModel.name,
              style: TextStyle(
                fontWeight: FontWeight.w500,
                fontSize: 16,
              ),
            )),
      ],
    );
  }

  Row buildAddress() {
    return Row(
      children: [
        Expanded(
          flex: 1,
          child: Text(
            'Address :',
            style: TextStyle(
              fontWeight: FontWeight.bold,
              fontSize: 16,
            ),
          ),
        ),
        Expanded(
            flex: 3,
            child: Text(
              userModel.address,
              style: TextStyle(
                fontWeight: FontWeight.w500,
                fontSize: 16,
              ),
            )),
      ],
    );
  }

  Row buildPhone() {
    return Row(
      children: [
        Expanded(
          flex: 1,
          child: Text(
            'Phone :',
            style: TextStyle(
              fontWeight: FontWeight.bold,
              fontSize: 16,
            ),
          ),
        ),
        Expanded(
            flex: 3,
            child: Text(
              userModel.phone,
              style: TextStyle(
                fontWeight: FontWeight.w500,
                fontSize: 16,
              ),
            )),
      ],
    );
  }

  Row buildGender() {
    return Row(
      children: [
        Expanded(
          flex: 1,
          child: Text(
            'Gender :',
            style: TextStyle(
              fontWeight: FontWeight.bold,
              fontSize: 16,
            ),
          ),
        ),
        Expanded(
            flex: 3,
            child: Text(
              userModel.gender,
              style: TextStyle(
                fontWeight: FontWeight.w500,
                fontSize: 16,
              ),
            )),
      ],
    );
  }
}

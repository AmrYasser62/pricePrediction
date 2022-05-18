import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart';
import 'package:rflutter_alert/rflutter_alert.dart';
import 'package:http/http.dart' as http;
import '../loading/loading.dart';
import 'form.dart';

class Result extends StatefulWidget {
  final area, houseAge, roomsNum, bedroomsNum, population;
  Result(
      {this.area,
      this.houseAge,
      this.roomsNum,
      this.bedroomsNum,
      this.population});

  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<Result> {
  int prediction;

  Future<void> predict() async {
    try {
      String  url =
          'https://flutteruse.herokuapp.com/predict/?areaincome=${widget.area}&areahouseage=${widget.houseAge}&areanorooms=${widget.roomsNum}&areanobedrooms=${widget.bedroomsNum}&areapopulation=${widget.population}';
      Response data = await http.get(Uri.parse(url));

          setState(() {
        prediction = jsonDecode(data.body)['prediction'];
      });
    } catch (e) {
      Alert(
              context: context,
              title: 'Error',
              desc: e.message,
              buttons: [],
      )
          .show();
    }
  }

  @override
  void initState() {
    predict();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    if (prediction == null) {
      return Loading();
    } else {
      return Scaffold(
        body: Builder(
          builder: (context) => SingleChildScrollView(
            child: Container(
              height: MediaQuery.of(context).size.height,
              width: MediaQuery.of(context).size.width,
              padding: EdgeInsets.all(10),
              decoration: BoxDecoration(
              ),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  SizedBox(
                    height: 20,
                  ),
                  Center(
                    child: Text(
                      'Predicted Price according to the Details',
                      textAlign: TextAlign.center,
                      style: TextStyle(
                          fontSize: 20,
                          fontWeight: FontWeight.bold),
                    ),
                  ),
                  SizedBox(
                    height: 5,
                  ),
                  Center(
                    child: Text(
                      'Result = $prediction ',
                      textAlign: TextAlign.center,
                      style: TextStyle(
                          fontSize: 30,
                          fontWeight: FontWeight.bold),
                    ),
                  ),
                  SizedBox(
                    height: 30,
                  ),
                  TextButton.icon(
                    icon: const Icon(
                      Icons.home,
                    ),
                    label: const Text(
                      'Predict another House Price',
                    ),
                    onPressed: () {
                      Navigator.pushReplacement(context,
                          MaterialPageRoute(builder: (context) => Getdata()));
                    },
                  ),
                ],
              ),
            ),
          ),
        ),
      );
    }
  }
}

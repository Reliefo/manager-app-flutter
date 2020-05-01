import 'package:adhara_socket_io_example/authentication/login.dart';
import 'package:adhara_socket_io_example/startingPage.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

void main() => runApp(MyApp());

//const String URI = "http://192.168.0.9:5050/";
//var connectingURI = "http://192.168.0.9:5050/login";

class MyApp extends StatefulWidget {
  @override
  _MyAppState createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  @override
  void initState() {
    Login login = Login();
    login.login();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    SystemChrome.setPreferredOrientations([
      DeviceOrientation.landscapeLeft,
      DeviceOrientation.landscapeRight,
    ]);
    return StartingPage();
  }
}

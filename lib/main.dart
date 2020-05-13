import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:http/http.dart' as http;
import 'package:manager_app/authentication/loadingPage.dart';
import 'package:manager_app/authentication/loginPage.dart';
import 'package:manager_app/fetchData/socketConnection.dart';
import 'package:manager_app/url.dart';
import 'package:shared_preferences/shared_preferences.dart';

void main() => runApp(MyApp());

class MyApp extends StatefulWidget {
  @override
  _MyAppState createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
//  String refreshUrl = "http://192.168.0.9:5050/refresh";
  bool authentication = false;
  bool showLoading = true;
  String accessToken;
  String restaurantId;
  String objectId;
  Future<Map<String, dynamic>> _getSavedData() async {
    print("getData");

    final credentials = await SharedPreferences.getInstance();

    final restaurantId = credentials.getString('restaurantId');
    final objectId = credentials.getString('objectId');
    final refreshToken = credentials.getString('refreshToken');

    Map<String, dynamic> savedData = {
      "restaurantId": restaurantId,
      "staffId": objectId,
//      "jwt": jwt,
      "refreshToken": refreshToken
    };

    print(savedData);

    return savedData;
  }

  refresh(url) async {
    var savedData = await _getSavedData();

    setState(() {
      restaurantId = savedData["restaurantId"];
      objectId = savedData["objectId"];
    });

    Map<String, String> headers = {
      "Authorization": "Bearer ${savedData["refreshToken"]}"
    };
    print("headers $headers");
    http.Response response = await http.post(url, headers: headers);

    int statusCode = response.statusCode;
    // this API passes back the id of the new item added to the body
    var decoded = json.decode(response.body);
    print("status in main page code");
    print(decoded);
    print(statusCode);
    if (statusCode == 200) {
      setState(() {
        accessToken = decoded["access_token"];
        showLoading = false;
        authentication = true;
      });
    } else {
      setState(() {
        authentication = false;
        showLoading = false;
      });
    }
  }

  @override
  void initState() {
    refresh(refreshUrl);

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    SystemChrome.setPreferredOrientations([
      DeviceOrientation.landscapeLeft,
      DeviceOrientation.landscapeRight,
    ]);

    print("here build method");
    print(refreshUrl);
    return showLoading == true
        ? LoadingPage()
        : authentication == true
            ? SocketConnection(
                jwt: accessToken,
//      objectId: objectId,
                restaurantId: restaurantId,
              )
            : LoginPage();
  }
}

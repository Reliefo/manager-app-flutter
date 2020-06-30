import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:manager_app/Drawer/Dashboard/dashboard.dart';
import 'package:manager_app/Drawer/configureRestaurant/configure.dart';
import 'package:manager_app/Drawer/orderHistory/orderHistory.dart';
import 'package:manager_app/authentication/loginPage.dart';
import 'package:manager_app/constants.dart';
import 'package:manager_app/data.dart';
import 'package:shared_preferences/shared_preferences.dart';

class DrawerMenu extends StatelessWidget {
  final String managerName;
  final jsSocket;
  final Restaurant restaurant;

  DrawerMenu({
    this.restaurant,
    this.managerName,
    this.jsSocket,
  });
  clearData() async {
    SharedPreferences preferences = await SharedPreferences.getInstance();
    preferences.clear();
  }

  @override
  Widget build(BuildContext context) {
    return ListView(
      children: <Widget>[
        DrawerHeader(
          child: Column(
            children: <Widget>[
              restaurant.name != null
                  ? Text(
                      restaurant.name,
                      style: kHeaderStyleSmall,
                      textAlign: TextAlign.left,
                    )
                  : Container(),
              Text(
                managerName,
                style: kTitleStyle,
                textAlign: TextAlign.left,
              ),
            ],
          ),
        ),

        FlatButton(
          child: Row(
            children: <Widget>[
              Text(
                'Configure Restaurant',
                style: kHeaderStyleSmall,
                textAlign: TextAlign.left,
              ),
            ],
          ),
          onPressed: () {
            Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) => Configure(),
              ),
            );
          },
        ),

        Divider(),

        FlatButton(
          child: Row(
            children: <Widget>[
              Text(
                'Order History',
                style: kHeaderStyleSmall,
                textAlign: TextAlign.left,
              ),
            ],
          ),
          onPressed: () {
            Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) => OrderHistoryPage(),
              ),
            );
          },
        ),
        Divider(),

        FlatButton(
          child: Row(
            children: <Widget>[
              Text(
                'Dashboard',
                style: kHeaderStyleSmall,
                textAlign: TextAlign.left,
              ),
            ],
          ),
          onPressed: () {
            Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) => Dashboard(),
              ),
            );
          },
        ),
        Divider(),

        FlatButton(
          child: Row(
            children: <Widget>[
              Text(
                'Refresh',
                style: kHeaderStyleSmall,
                textAlign: TextAlign.left,
              ),
            ],
          ),
          onPressed: () {
            jsSocket.socketEmit("fetch_rest_manager",
                jsonEncode({"restaurant_id": restaurant.restaurantId}));
          },
        ),
        Divider(),
        ///////////////////
        FlatButton(
          child: Row(
            children: <Widget>[
              Text(
                'Logout',
                style: kHeaderStyleSmall,
                textAlign: TextAlign.left,
              ),
            ],
          ),
          onPressed: () {
            clearData();
            Navigator.pushAndRemoveUntil(
                context,
                MaterialPageRoute(
                  builder: (context) => LoginPage(),
                ),
                (route) => false);
          },
        ),
      ],
    );
  }
}

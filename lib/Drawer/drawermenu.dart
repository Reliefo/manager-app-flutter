import 'dart:convert';

import 'package:custom_switch/custom_switch.dart';
import 'package:flutter/material.dart';
import 'package:manager_app/Drawer/Dashboard/dashboard.dart';
import 'package:manager_app/Drawer/configureRestaurant/configure.dart';
import 'package:manager_app/Drawer/orderHistory/orderHistory.dart';
import 'package:manager_app/authentication/loginPage.dart';
import 'package:manager_app/constants.dart';
import 'package:manager_app/data.dart';
import 'package:manager_app/fetchData/configureRestaurantData.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';

class DrawerMenu extends StatefulWidget {
  final String managerName;
  final sockets;
  final Restaurant restaurant;

  DrawerMenu({
    this.restaurant,
    this.managerName,
    this.sockets,
  });

  @override
  _DrawerMenuState createState() => _DrawerMenuState();
}

class _DrawerMenuState extends State<DrawerMenu> {
  bool switchStatus;

  updateOrderingStatusToBackend(restaurantData, bool boolData, String type) {
    Map<String, dynamic> data = {"status": boolData};

    restaurantData.sendConfiguredDataToBackend(data, type);
  }

  clearData() async {
    SharedPreferences preferences = await SharedPreferences.getInstance();
    preferences.clear();
  }

  @override
  Widget build(BuildContext context) {
    RestaurantData restaurantData = Provider.of<RestaurantData>(context);
    switchStatus = restaurantData.restaurant.orderingAbility;

    return ListView(
      children: <Widget>[
        DrawerHeader(
          child: Column(
            children: <Widget>[
              widget.restaurant.name != null
                  ? Text(
                      widget.restaurant.name,
                      style: kHeaderStyleSmall,
                      textAlign: TextAlign.left,
                    )
                  : Container(),
              Text(
                widget.managerName,
                style: kTitleStyle,
                textAlign: TextAlign.left,
              ),
            ],
          ),
        ),

        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16.0),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: <Widget>[
              Text(
                "Accept Orders",
                style: kHeaderStyleSmall,
              ),
              CustomSwitch(
                activeColor: Colors.green,
                value: switchStatus,
                onChanged: (value) {
                  setState(() {
                    switchStatus = value;
                  });

                  updateOrderingStatusToBackend(
                      restaurantData, switchStatus, "ordering-ability_manage");
                },
              ),
            ],
          ),
        ),

        Divider(),
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
//            widget.sockets['working'].emit("fetch_rest_manager", [
//              jsonEncode({"restaurant_id": widget.restaurant.restaurantId})
//            ]);
            widget.sockets['liqr'].emit("fetch_rest_manager",
                jsonEncode({"restaurant_id": widget.restaurant.restaurantId}));
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

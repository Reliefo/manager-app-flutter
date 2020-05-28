import 'package:flutter/material.dart';
import 'package:manager_app/Drawer/configureRestaurant/configure.dart';
import 'package:manager_app/Drawer/orderHistory/orderHistory.dart';
import 'package:manager_app/authentication/loginPage.dart';
import 'package:shared_preferences/shared_preferences.dart';

class DrawerMenu extends StatelessWidget {
  clearData() async {
    SharedPreferences preferences = await SharedPreferences.getInstance();
    preferences.clear();
  }

  @override
  Widget build(BuildContext context) {
    return ListView(
      children: <Widget>[
        DrawerHeader(
          child: Container(),
        ),

        FlatButton(
          child: Center(
            child: Text('configure restaurant'),
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
          child: Center(
            child: Text('Order History'),
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
        ///////////////////

        FlatButton(
          child: Center(
            child: Text('Logout'),
          ),
          onPressed: () {
            clearData();

            Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) => LoginPage(),
              ),
            );
          },
        ),
        FlatButton(
          child: Text('get'),
          onPressed: () {
//            getRest();
          },
        ),
      ],
    );
  }
}

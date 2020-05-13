import 'package:flutter/material.dart';
import 'package:manager_app/Drawer/configureRestaurant/configure.dart';

class DrawerMenu extends StatelessWidget {
//  final Restaurant restaurant;
//  final updateConfigDetailsToCloud;
//
//  final getRest;
//  final login;
//
//  DrawerMenu({
//    @required this.restaurant,
//    this.updateConfigDetailsToCloud,
//    this.getRest,
//    this.login,
//  });
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
                builder: (context) => Configure(
//                  updateConfigDetailsToCloud: updateConfigDetailsToCloud,
//                  restaurant: rest.restaurant,
                    ),
              ),
            );
          },
        ),

        Divider(),
        ///////////////////

        FlatButton(
          child: Text('login'),
          onPressed: () {
//            login();
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

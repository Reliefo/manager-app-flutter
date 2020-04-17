import 'package:adhara_socket_io_example/Drawer/configureRestaurant/configure.dart';
import 'package:adhara_socket_io_example/data.dart';
import 'package:flutter/material.dart';

class DrawerMenu extends StatelessWidget {
  final Restaurant restaurant;
  final updateConfigDetailsToCloud;

  final getRest;
  final login;

  DrawerMenu({
    @required this.restaurant,
    this.updateConfigDetailsToCloud,
    this.getRest,
    this.login,
  });
  @override
  Widget build(BuildContext context) {
    return ListView(
      children: <Widget>[
        DrawerHeader(
          child: Container(),
        ),

        GestureDetector(
          child: Container(
            padding: EdgeInsets.all(12),
            child: Text('configure restaurant'),
          ),
          onTap: () {
            Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) => Configure(
                  updateConfigDetailsToCloud: updateConfigDetailsToCloud,
                  restaurant: restaurant,
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
            login();
          },
        ),
        FlatButton(
          child: Text('get'),
          onPressed: () {
            getRest();
          },
        ),
      ],
    );
  }
}

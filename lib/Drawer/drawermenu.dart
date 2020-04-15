import 'package:adhara_socket_io_example/data.dart';
import 'package:flutter/material.dart';

import 'addMenu.dart';
import 'add_Data.dart';
import 'assign_Staff.dart';

class DrawerMenu extends StatelessWidget {
  final Restaurant restaurant;
  final updateTableDetailsToCloud;

  final updateMenuToCloud;
  final get_rest;
  final login;

  DrawerMenu({
    @required this.restaurant,
    this.updateTableDetailsToCloud,
    this.updateMenuToCloud,
    this.get_rest,
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
            child: Text('Add Data'),
          ),
          onTap: () {
            Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) => AddData(
                  updateTableDetailsToCloud: updateTableDetailsToCloud,
                  restaurant: restaurant,
                ),
              ),
            );
          },
        ),
        Divider(),
        GestureDetector(
          child: Container(
            padding: EdgeInsets.all(12),
            child: Text('Assign Server'),
          ),
          onTap: () {
            Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) => AssignStaff(
                  restaurant: restaurant,
                  updateTableDetailsToCloud: updateTableDetailsToCloud,
                ),
              ),
            );
          },
        ),
        Divider(),
        GestureDetector(
          child: Container(
            padding: EdgeInsets.all(12),
            child: Text('Add Menu'),
          ),
          onTap: () {
            Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) => AddMenu(
                  restaurant: restaurant,
                  updateMenuToCloud: updateMenuToCloud,
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
            get_rest();
          },
        ),
      ],
    );
  }
}

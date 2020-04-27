import 'package:adhara_socket_io_example/Drawer/configureRestaurant/addBarMenu.dart';
import 'package:adhara_socket_io_example/Drawer/configureRestaurant/addFoodMenu.dart';
import 'package:adhara_socket_io_example/Drawer/configureRestaurant/addStaff.dart';
import 'package:adhara_socket_io_example/Drawer/configureRestaurant/assignStaff.dart';
import 'package:adhara_socket_io_example/Drawer/configureRestaurant/configureHomeScreen/configureHome.dart';
import 'package:adhara_socket_io_example/Drawer/configureRestaurant/test.dart';
import 'package:adhara_socket_io_example/data.dart';
import 'package:flutter/material.dart';

import 'addTable.dart';

class Configure extends StatelessWidget {
  final Restaurant restaurant;
  final updateConfigDetailsToCloud;

  Configure({
    @required this.restaurant,
    @required this.updateConfigDetailsToCloud,
  });
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
          backgroundColor: Colors.grey,
          title: Text('Configure Restaurant'),
        ),
        body: Container(
          child: Column(
            children: <Widget>[
              Expanded(
                child: Row(children: <Widget>[
                  Expanded(
                    child: Container(
                      padding: EdgeInsets.all(25),
                      child: GestureDetector(
                        child: Card(
                          color: Color(0xffE5EDF1),
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(20.0),
                          ),
                          child: Center(child: Text('Tables')),
                        ),
                        onTap: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) => AddData(
                                updateConfigDetailsToCloud:
                                    updateConfigDetailsToCloud,
                                restaurant: restaurant,
                              ),
                            ),
                          );
                        },
                      ),
                    ),
                  ),
                  Expanded(
                    child: Container(
                      padding: EdgeInsets.all(25),
                      child: GestureDetector(
                        child: Card(
                          color: Color(0xffE5EDF1),
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(20.0),
                          ),
                          child: Center(child: Text('Staff')),
                        ),
                        onTap: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) => AddStaff(
                                updateConfigDetailsToCloud:
                                    updateConfigDetailsToCloud,
                                restaurant: restaurant,
                              ),
                            ),
                          );
                        },
                      ),
                    ),
                  ),
                  Expanded(
                    child: Container(
                      padding: EdgeInsets.all(25),
                      child: GestureDetector(
                        child: Card(
                          color: Color(0xffE5EDF1),
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(20.0),
                          ),
                          child: Center(child: Text('Assign Staff')),
                        ),
                        onTap: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) => AssignStaff(
                                updateConfigDetailsToCloud:
                                    updateConfigDetailsToCloud,
                                restaurant: restaurant,
                              ),
                            ),
                          );
                        },
                      ),
                    ),
                  ),
                ]),
              ),
              Expanded(
                child: Row(children: <Widget>[
                  Expanded(
                    child: Container(
                      padding: EdgeInsets.all(25),
                      child: GestureDetector(
                        child: Card(
                          color: Color(0xffE5EDF1),
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(20.0),
                          ),
                          child: Center(
                            child: Text('Food Menu'),
                          ),
                        ),
                        onTap: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) => AddFoodMenu(
                                updateConfigDetailsToCloud:
                                    updateConfigDetailsToCloud,
                                restaurant: restaurant,
                              ),
                            ),
                          );
                        },
                      ),
                    ),
                  ),
                  Expanded(
                    child: Container(
                      padding: EdgeInsets.all(25),
                      child: GestureDetector(
                        child: Card(
                          color: Color(0xffE5EDF1),
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(20.0),
                          ),
                          child: Center(
                            child: Text('Bar Menu'),
                          ),
                        ),
                        onTap: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) => AddBarMenu(
                                updateConfigDetailsToCloud:
                                    updateConfigDetailsToCloud,
                                restaurant: restaurant,
                              ),
                            ),
                          );
                        },
                      ),
                    ),
                  ),
                  Expanded(
                    child: Container(
                      padding: EdgeInsets.all(25),
                      child: GestureDetector(
                        child: Card(
                          color: Color(0xffE5EDF1),
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(20.0),
                          ),
                          child: Center(
                            child: Text('Home Screen'),
                          ),
                        ),
                        onTap: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) => ConfigureHomeScreen(
                                restaurant: restaurant,
                              ),
                            ),
                          );
                        },
                      ),
                    ),
                  ),
                ]),
              ),
              Expanded(
                child: Row(children: <Widget>[
                  Expanded(
                    child: Container(
                      padding: EdgeInsets.all(25),
                      child: GestureDetector(
                        child: Card(
                          color: Color(0xffE5EDF1),
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(20.0),
                          ),
                          child: Center(
                            child: Text('testing'),
                          ),
                        ),
                        onTap: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) => TestScreen(),
                            ),
                          );
                        },
                      ),
                    ),
                  ),
                ]),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
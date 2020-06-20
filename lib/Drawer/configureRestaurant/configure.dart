import 'package:flutter/material.dart';
import 'package:manager_app/Drawer/configureRestaurant/Inventory/Inventory.dart';
import 'package:manager_app/Drawer/configureRestaurant/Kitchen/addKitchen.dart';
import 'package:manager_app/Drawer/configureRestaurant/addBarMenu.dart';
import 'package:manager_app/Drawer/configureRestaurant/addFoodMenu.dart';
import 'package:manager_app/Drawer/configureRestaurant/addStaff.dart';
import 'package:manager_app/Drawer/configureRestaurant/assignStaff.dart';
import 'package:manager_app/Drawer/configureRestaurant/configureHomeScreen/configureHomeScreen.dart';
import 'package:manager_app/Drawer/configureRestaurant/setTax.dart';
import 'package:manager_app/constants.dart';
import 'package:manager_app/data.dart';

import 'addTable.dart';

class Configure extends StatelessWidget {
  final Restaurant restaurant;
  final updateConfigDetailsToCloud;

  Configure({
    this.restaurant,
    this.updateConfigDetailsToCloud,
  });
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
          backgroundColor: kThemeColor,
          title: Text(
            'Configure Restaurant',
          ),
        ),
        body: Container(
          child: Column(
            children: <Widget>[
              Expanded(
                child: Row(children: <Widget>[
                  Expanded(
                    child: Container(
                      padding: EdgeInsets.all(25),
                      child: Card(
                        color: Color(0xffE5EDF1),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(20.0),
                        ),
                        child: FlatButton(
                          child: Center(
                            child: Text(
                              'Tables',
                              style: kHeaderStyleSmall,
                            ),
                          ),
                          onPressed: () {
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (context) => AddData(),
                              ),
                            );
                          },
                        ),
                      ),
                    ),
                  ),
                  Expanded(
                    child: Container(
                      padding: EdgeInsets.all(25),
                      child: Card(
                        color: Color(0xffE5EDF1),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(20.0),
                        ),
                        child: FlatButton(
                          child: Center(
                            child: Text(
                              'Staff',
                              style: kHeaderStyleSmall,
                            ),
                          ),
                          onPressed: () {
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (context) => AddStaff(),
                              ),
                            );
                          },
                        ),
                      ),
                    ),
                  ),
                  Expanded(
                    child: Container(
                      padding: EdgeInsets.all(25),
                      child: Card(
                        color: Color(0xffE5EDF1),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(20.0),
                        ),
                        child: FlatButton(
                          child: Center(
                            child: Text(
                              'Assign Staff',
                              style: kHeaderStyleSmall,
                            ),
                          ),
                          onPressed: () {
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (context) => AssignStaff(),
                              ),
                            );
                          },
                        ),
                      ),
                    ),
                  ),
                ]),
              ),
              Expanded(
                child: Row(
                  children: <Widget>[
                    Expanded(
                      child: Container(
                        padding: EdgeInsets.all(25),
                        child: Card(
                          color: Color(0xffE5EDF1),
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(20.0),
                          ),
                          child: FlatButton(
                            child: Center(
                              child: Text(
                                'Food Menu',
                                style: kHeaderStyleSmall,
                              ),
                            ),
                            onPressed: () {
                              Navigator.push(
                                context,
                                MaterialPageRoute(
                                  builder: (context) => AddFoodMenu(),
                                ),
                              );
                            },
                          ),
                        ),
                      ),
                    ),
                    Expanded(
                      child: Container(
                        padding: EdgeInsets.all(25),
                        child: Card(
                          color: Color(0xffE5EDF1),
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(20.0),
                          ),
                          child: FlatButton(
                            child: Center(
                              child: Text(
                                'Bar Menu',
                                style: kHeaderStyleSmall,
                              ),
                            ),
                            onPressed: () {
                              Navigator.push(
                                context,
                                MaterialPageRoute(
                                  builder: (context) => AddBarMenu(),
                                ),
                              );
                            },
                          ),
                        ),
                      ),
                    ),
                    Expanded(
                      child: Container(
                        padding: EdgeInsets.all(25),
                        child: Card(
                          color: Color(0xffE5EDF1),
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(20.0),
                          ),
                          child: FlatButton(
                            child: Center(
                              child: Text(
                                'Home Screen',
                                style: kHeaderStyleSmall,
                              ),
                            ),
                            onPressed: () {
                              Navigator.push(
                                context,
                                MaterialPageRoute(
                                  builder: (context) => ConfigureHomeScreen(
//
                                      ),
                                ),
                              );
                            },
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
              Expanded(
                child: Row(
                  children: <Widget>[
                    Expanded(
                      child: Container(
                        padding: EdgeInsets.all(25),
                        child: Card(
                          color: Color(0xffE5EDF1),
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(20.0),
                          ),
                          child: FlatButton(
                            child: Center(
                              child: Text(
                                'Add Kitchen',
                                style: kHeaderStyleSmall,
                              ),
                            ),
                            onPressed: () {
                              Navigator.push(
                                context,
                                MaterialPageRoute(
                                  builder: (context) => AddKitchen(),
                                ),
                              );
                            },
                          ),
                        ),
                      ),
                    ),
                    Expanded(
                      child: Container(
                        padding: EdgeInsets.all(25),
                        child: Card(
                          color: Color(0xffE5EDF1),
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(20.0),
                          ),
                          child: FlatButton(
                            child: Center(
                              child: Text(
                                'Taxes',
                                style: kHeaderStyleSmall,
                              ),
                            ),
                            onPressed: () {
                              Navigator.push(
                                context,
                                MaterialPageRoute(
                                  builder: (context) => SetTaxes(),
                                ),
                              );
                            },
                          ),
                        ),
                      ),
                    ),
                    Expanded(
                      child: Container(
                        padding: EdgeInsets.all(25),
                        child: Card(
                          color: Color(0xffE5EDF1),
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(20.0),
                          ),
                          child: FlatButton(
                            child: Center(
                              child: Text(
                                'Inventory',
                                style: kHeaderStyleSmall,
                              ),
                            ),
                            onPressed: () {
                              Navigator.push(
                                context,
                                MaterialPageRoute(
                                  builder: (context) => Inventory(),
                                ),
                              );
                            },
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

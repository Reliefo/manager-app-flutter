import 'package:flutter/material.dart';
import 'package:manager_app/Drawer/configureRestaurant/configureHomeScreen/configureChefSpecial.dart';
import 'package:manager_app/Drawer/configureRestaurant/configureHomeScreen/configureMostPopular.dart';
import 'package:manager_app/Drawer/configureRestaurant/configureHomeScreen/configureTags/HomeScreenTags/configureHomeScreenTags.dart';
import 'package:manager_app/Drawer/configureRestaurant/configureHomeScreen/configureTags/navigateBetter/ConfigureNavigateBetterTags.dart';
import 'package:manager_app/Drawer/configureRestaurant/test.dart';

class ConfigureHomeScreen extends StatelessWidget {
//  final Restaurant restaurant;
//  final updateConfigDetailsToCloud;
//
//  ConfigureHomeScreen({
//    @required this.restaurant,
//    this.updateConfigDetailsToCloud,
//  });
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
          backgroundColor: Colors.grey,
          title: Text('Configure Home Screen'),
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
                            child: Text('On Offer'),
                          ),
                          onPressed: () {
//                            Navigator.push(
//                              context,
//                              MaterialPageRoute(
//                                builder: (context) => AddFoodMenu(
//                                  updateConfigDetailsToCloud:
//                                      updateConfigDetailsToCloud,
//                                  restaurant: restaurant,
//                                ),
//                              ),
//                            );
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
                            child: Text('Navigate Better Tags'),
                          ),
                          onPressed: () {
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (context) =>
                                    ConfigureNavigateBetterTags(
//                                  updateConfigDetailsToCloud:
//                                      updateConfigDetailsToCloud,
//                                  restaurant: restaurant,
                                        ),
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
                            child: Text('Home Screen Tags'),
                          ),
                          onPressed: () {
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (context) => ConfigureHomeScreenTags(
//                                  updateConfigDetailsToCloud:
//                                      updateConfigDetailsToCloud,
//                                  restaurant: restaurant,
                                    ),
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
                            child: Text('Most Popular'),
                          ),
                          onPressed: () {
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (context) => MostPopular(
//                                  restaurant: restaurant,
                                    ),
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
                            child: Text('Daily Special'),
                          ),
                          onPressed: () {
//                            Navigator.push(
//                              context,
//                              MaterialPageRoute(
//                                builder: (context) => ConfigureDaily(),
//                              ),
//                            );
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
                            child: Text('Chef Special'),
                          ),
                          onPressed: () {
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (context) => ConfigureChefSpecial(),
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
                            child: Text('Happy Hours'),
                          ),
                          onPressed: () {
//                            Navigator.push(
//                              context,
//                              MaterialPageRoute(
//                                builder: (context) => ConfigureHomeScreen(
//                                  restaurant: restaurant,
//                                ),
//                              ),
//                            );
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
                            child: Text('nothing'),
                          ),
                          onPressed: () {
//                            Navigator.push(
//                              context,
//                              MaterialPageRoute(
//                                builder: (context) => ConfigureHomeScreen(
//                                  restaurant: restaurant,
//                                ),
//                              ),
//                            );
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
                            child: Text('testing'),
                          ),
                          onPressed: () {
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

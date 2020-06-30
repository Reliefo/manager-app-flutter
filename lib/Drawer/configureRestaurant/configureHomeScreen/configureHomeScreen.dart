import 'package:flutter/material.dart';
import 'package:manager_app/Drawer/configureRestaurant/configureHomeScreen/ChefSpecial.dart';
import 'package:manager_app/Drawer/configureRestaurant/configureHomeScreen/DailySpecial.dart';
import 'package:manager_app/Drawer/configureRestaurant/configureHomeScreen/MostPopular.dart';
import 'package:manager_app/Drawer/configureRestaurant/configureHomeScreen/configureTags/HomeScreenTags/configureHomeScreenTags.dart';
import 'package:manager_app/Drawer/configureRestaurant/configureHomeScreen/configureTags/navigateBetter/ConfigureNavigateBetterTags.dart';
import 'package:manager_app/Drawer/configureRestaurant/configureHomeScreen/onOffer.dart';
import 'package:manager_app/constants.dart';

class ConfigureHomeScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
          backgroundColor: kThemeColor,
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
                            child: Text(
                              'Navigate Better Tags',
                              style: kHeaderStyleSmall,
                            ),
                          ),
                          onPressed: () {
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (context) =>
                                    ConfigureNavigateBetterTags(
//
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
                            child: Text(
                              'Home Screen Tags',
                              style: kHeaderStyleSmall,
                            ),
                          ),
                          onPressed: () {
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (context) => ConfigureHomeScreenTags(),
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
                              'On Offer',
                              style: kHeaderStyleSmall,
                            ),
                          ),
                          onPressed: () {
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (context) => OnOffer(),
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
                            child: Text(
                              'Most Popular',
                              style: kHeaderStyleSmall,
                            ),
                          ),
                          onPressed: () {
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (context) => MostPopular(),
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
                              'Daily Special',
                              style: kHeaderStyleSmall,
                            ),
                          ),
                          onPressed: () {
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (context) => DailySpecial(),
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
                              'Chef Special',
                              style: kHeaderStyleSmall,
                            ),
                          ),
                          onPressed: () {
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (context) => ChefSpecial(),
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
//                      padding: EdgeInsets.all(25),
//                      child: Card(
//                        color: Color(0xffE5EDF1),
//                        shape: RoundedRectangleBorder(
//                          borderRadius: BorderRadius.circular(20.0),
//                        ),
//                        child: FlatButton(
//                          child: Center(
//                            child: Text(
//                              'Happy Hours',
//                              style: kHeaderStyleSmall,
//                            ),
//                          ),
//                          onPressed: () {
////                            Navigator.push(
////                              context,
////                              MaterialPageRoute(
////                                builder: (context) => ConfigureHomeScreen(
////                                  restaurant: restaurant,
////                                ),
////                              ),
////                            );
//                          },
//                        ),
//                      ),
                        ),
                  ),
                  Expanded(
                    child: Container(
//                      padding: EdgeInsets.all(25),
//                      child: Card(
//                        color: Color(0xffE5EDF1),
//                        shape: RoundedRectangleBorder(
//                          borderRadius: BorderRadius.circular(20.0),
//                        ),
//                        child: FlatButton(
//                          child: Center(
//                            child: Text(
//                              'Image Test',
//                              style: kHeaderStyleSmall,
//                            ),
//                          ),
//                          onPressed: () {
//                            Navigator.push(
//                              context,
//                              MaterialPageRoute(
//                                builder: (context) => SelectImage(),
//                              ),
//                            );
//                          },
//                        ),
//                      ),
                        ),
                  ),
                  Expanded(
                    child: Container(
//                      padding: EdgeInsets.all(25),
//                      child: Card(
//                        color: Color(0xffE5EDF1),
//                        shape: RoundedRectangleBorder(
//                          borderRadius: BorderRadius.circular(20.0),
//                        ),
//                        child: FlatButton(
//                          child: Center(
//                            child: Text(
//                              'testing',
//                              style: kHeaderStyleSmall,
//                            ),
//                          ),
//                          onPressed: () {
//                            Navigator.push(
//                              context,
//                              MaterialPageRoute(
//                                builder: (context) => TestScreen(),
//                              ),
//                            );
//                          },
//                        ),
//                      ),
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

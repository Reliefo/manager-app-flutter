import 'package:flutter/material.dart';
import 'package:manager_app/constants.dart';
import 'package:manager_app/fetchData/configureRestaurantData.dart';
import 'package:provider/provider.dart';

import 'singleTable.dart';

class TableView extends StatelessWidget {
  Color getColour(index, restaurantData) {
    if (restaurantData.restaurant.tables[index].users.isNotEmpty) {
      if (restaurantData.restaurant.tables[index].cookingCount >
          restaurantData.restaurant.tables[index].queueCount) {
        return Colors.yellow;
      } else if (restaurantData.restaurant.tables[index].queueCount >
          restaurantData.restaurant.tables[index].cookingCount) {
        return Colors.red[100];
      }
      return Colors.green[100];
    } else
      return Colors.grey[200];
  }

  @override
  Widget build(BuildContext context) {
    final RestaurantData restaurantData = Provider.of<RestaurantData>(context);

    return SafeArea(
      child: Scaffold(
        body: Container(
          padding: EdgeInsets.all(10),
          child: restaurantData.restaurant.tables != null
              ? GridView.builder(
                  itemCount: restaurantData.restaurant.tables.length,
                  gridDelegate: SliverGridDelegateWithMaxCrossAxisExtent(
                    mainAxisSpacing: 4.0,
                    crossAxisSpacing: 4.0,
                    childAspectRatio: 1,
                    maxCrossAxisExtent: 240,
                  ),
                  itemBuilder: (BuildContext context, index) {
                    return GestureDetector(
                      child: Container(
                        decoration: BoxDecoration(
                          color: getColour(index, restaurantData),
                          borderRadius: BorderRadius.all(
                            Radius.circular(15.0),
                          ),
                        ),
                        margin: EdgeInsets.all(4),
                        padding: EdgeInsets.symmetric(vertical: 10),
                        child: Column(
                          children: <Widget>[
                            Text(
                              restaurantData.restaurant.tables[index].name,
                              style: kHeaderStyleSmall,
                            ),
                            SizedBox(height: 4.0),
                            Container(
                              width: double.maxFinite,
                              padding: EdgeInsets.symmetric(horizontal: 20),
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: <Widget>[
                                  Row(
                                    children: <Widget>[
                                      Text(
                                        'Servers : ',
                                        style: kTitleStyle,
                                      ),
                                      Text(
                                        restaurantData.restaurant.tables[index]
                                                    .staff !=
                                                null
                                            ? restaurantData.restaurant
                                                .tables[index].staff.length
                                                .toString()
                                            : '0',
                                        style: kTitleStyle,
                                      ),
                                    ],
                                  ),
                                  SizedBox(height: 4.0),
                                  Row(
                                    children: <Widget>[
                                      Text(
                                        'Scanned : ',
                                        style: kTitleStyle,
                                      ),
                                      Text(
                                        restaurantData.restaurant.tables[index]
                                                    .users !=
                                                null
                                            ? restaurantData.restaurant
                                                .tables[index].users.length
                                                .toString()
                                            : '0',
                                        style: kTitleStyle,
                                      ),
                                    ],
                                  ),
                                  SizedBox(height: 4.0),
                                  Row(
                                    children: <Widget>[
                                      Text(
                                        'Cooking : ',
                                        style: kTitleStyle,
                                      ),
                                      Text(
                                        restaurantData.restaurant.tables[index]
                                            .cookingCount
                                            .toString(),
                                        style: kTitleStyle,
                                      ),
                                    ],
                                  ),
                                  SizedBox(height: 4.0),
                                  Row(
                                    children: <Widget>[
                                      Text(
                                        'Queued : ',
                                        style: kTitleStyle,
                                      ),
                                      Text(
                                        restaurantData
                                            .restaurant.tables[index].queueCount
                                            .toString(),
                                        style: kTitleStyle,
                                      ),
                                    ],
                                  ),
                                ],
                              ),
                            ),
                          ],
                        ),
                      ),
                      onTap: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(builder: (context) => SingleTable(
                            table: restaurantData.restaurant.tables[index],
                            bill: restaurantData.billTheTable,
                          )),
                        );
                        /*
                        showModalBottomSheet(
                          context: context,
                          builder: (context) => SingleTable(
                            table: restaurantData.restaurant.tables[index],
                            bill: restaurantData.billTheTable,
                          ),
                        );*/
                      },
                    );
                  },
                )
              : Container(
                  child: Center(
                    child: Text("go to configure rest and add tables"),
                  ),
                ),
        ),
      ),
    );
  }
}

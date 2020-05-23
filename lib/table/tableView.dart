import 'package:flutter/material.dart';
import 'package:manager_app/constants.dart';
import 'package:manager_app/fetchData/configureRestaurantData.dart';
import 'package:provider/provider.dart';

import 'singleTable.dart';

class TableView extends StatelessWidget {
  Color getColour(index, restaurantData) {
    if (restaurantData.restaurant.tables[index].users != null) {
      if (restaurantData.restaurant.tables[index].cookingCount >
          restaurantData.restaurant.tables[index].queueCount) {
        return Colors.yellow;
      } else if (restaurantData.restaurant.tables[index].queueCount >
          restaurantData.restaurant.tables[index].cookingCount) {
        return Colors.red;
      }
      return Colors.green;
    } else
      return Colors.grey;
  }

  @override
  Widget build(BuildContext context) {
    final RestaurantData restaurantData = Provider.of<RestaurantData>(context);

    return SafeArea(
      child: Scaffold(
        body: Container(
          padding: EdgeInsets.all(10),
//          color: Colors.blueGrey,
          child: restaurantData.restaurant.tables != null
              ? GridView.builder(
                  itemCount: restaurantData.restaurant.tables.length,
                  gridDelegate: SliverGridDelegateWithMaxCrossAxisExtent(
                    mainAxisSpacing: 4.0,
                    crossAxisSpacing: 4.0,
                    childAspectRatio: 1,
                    maxCrossAxisExtent: 200,
                  ),
                  itemBuilder: (BuildContext context, index) {
                    return GestureDetector(
                      child: Card(
                        color: getColour(index, restaurantData),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(15.0),
                        ),
                        child: Container(
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
                                          restaurantData.restaurant
                                                      .tables[index].staff !=
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
                                          restaurantData.restaurant
                                                      .tables[index].users !=
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
                                          restaurantData.restaurant
                                              .tables[index].cookingCount
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
                                          restaurantData.restaurant
                                              .tables[index].queueCount
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
                      ),
                      onTap: () {
                        showModalBottomSheet(
                          context: context,
                          builder: (context) => SingleTable(
                            table: restaurantData.restaurant.tables[index],
                            bill: restaurantData.billTheTable,
                          ),
                        );
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

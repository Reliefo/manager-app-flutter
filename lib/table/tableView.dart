import 'package:flutter/material.dart';
import 'package:manager_app/constants.dart';
import 'package:manager_app/fetchData/configureRestaurantData.dart';
import 'package:provider/provider.dart';

import 'singleTable.dart';

class TableView extends StatelessWidget {
//  final Restaurant restaurantData.restaurant;
//  final cookingOrders;
//  final queueOrders;
//  final assistanceReq;
//
//  TableView({
////    @required this.restaurantData.restaurant,
////    @required this.cookingOrders,
////    @required this.queueOrders,
//    @required this.assistanceReq,
//  });

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
    }

    ///////////////////////////works correctly wen user is scanned////////////

//    else if (restaurantData.restaurant.tables[index].cookingCount >
//        restaurantData.restaurant.tables[index].queueCount) {
//      return Colors.yellow;
//    } else if (restaurantData.restaurant.tables[index].queueCount >
//        restaurantData.restaurant.tables[index].cookingCount) {
//      return Colors.red;
//    }

    else
      return Colors.grey;
  }

  @override
  Widget build(BuildContext context) {
    final RestaurantData restaurantData = Provider.of<RestaurantData>(context);

    return SafeArea(
      child: Scaffold(
        body: Container(
          padding: EdgeInsets.all(10),
          color: Colors.blueGrey,
          child: restaurantData.restaurant.tables != null
              ? GridView.builder(
                  itemCount: restaurantData.restaurant.tables.length,
                  gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: 5,
                  ),
                  itemBuilder: (BuildContext context, index) {
                    return GestureDetector(
                      child: Card(
                        color: Colors.white,
                        child: Container(
                          color: getColour(index, restaurantData),
                          padding: EdgeInsets.symmetric(vertical: 10),
                          child: Column(
                            children: <Widget>[
                              Text(
                                'Table-${restaurantData.restaurant.tables[index].name}',
                                style: homePageS1,
                              ),
                              Container(
                                padding: EdgeInsets.symmetric(horizontal: 10),
                                child: Container(
                                  child: Row(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceBetween,
                                    children: <Widget>[
                                      Column(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        children: <Widget>[
                                          TextDisplay(
                                            text:
                                                'Servers : ${restaurantData.restaurant.tables[index].staff != null ? restaurantData.restaurant.tables[index].staff.length : '0'}',
                                          ),
                                          TextDisplay(
                                            text:
                                                'Scanned : ${restaurantData.restaurant.tables[index].users != null ? restaurantData.restaurant.tables[index].users.length : '0'}',
                                          ),
                                          TextDisplay(
                                              text:
                                                  'Cooking : ${restaurantData.restaurant.tables[index].cookingCount}'),
                                          TextDisplay(
                                              text:
                                                  'Queued : ${restaurantData.restaurant.tables[index].queueCount}'),
                                        ],
                                      ),
                                    ],
                                  ),
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
//                            assistanceReq: assistanceReq,
//                            cookingOrders: cookingOrders,
//                            queueOrders: queueOrders,
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

class TextDisplay extends StatelessWidget {
  final String text;
  TextDisplay({@required this.text});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(8),
      child: Text(
        text,
        style: homePageS2,
      ),
    );
  }
}

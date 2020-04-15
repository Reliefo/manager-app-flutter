import 'package:adhara_socket_io_example/constants.dart';
import 'package:adhara_socket_io_example/data.dart';
import 'package:date_format/date_format.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class Cooking extends StatelessWidget {
  final List<TableOrder> cookingOrders;
  Cooking({
    @required this.cookingOrders,
  });

  @override
  Widget build(BuildContext context) {
    return cookingOrders.length > 0
        ? Flexible(
            fit: FlexFit.loose,
            child: ListView.builder(
              primary: false,
              shrinkWrap: true,
              itemCount: cookingOrders.length,
              itemBuilder: (context, index) {
                return Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: <Widget>[
                        Container(
                          padding:
                              EdgeInsets.symmetric(vertical: 8, horizontal: 12),
                          child: Text(
                            'Table : ${cookingOrders[index].table}' ?? " ",
                            style: homePageS1,
                          ),
                        ),
                        Container(
                          padding:
                              EdgeInsets.symmetric(vertical: 2, horizontal: 12),
                          child: Text(
//
                            'Arrival Time : ${formatDate(
                                  (cookingOrders[index].timeStamp),
                                  [HH, ':', nn],
                                )}' ??
                                " ",
                            style: homePageS3,
                          ),
                        ),
                      ],
                    ),
                    ListView.builder(
                      primary: false,
                      itemCount: cookingOrders[index].orders.length,
                      shrinkWrap: true,
                      itemBuilder: (context, index2) {
                        return ListView.builder(
                            primary: false,
                            shrinkWrap: true,
                            itemCount: cookingOrders[index]
                                .orders[index2]
                                .foodList
                                .length,
                            itemBuilder: (context, index3) {
                              return Container(
                                  padding: EdgeInsets.symmetric(
                                      vertical: 8, horizontal: 12),
                                  child:
                                      // for checking instructions
                                      cookingOrders[index]
                                                  .orders[index2]
                                                  .foodList[index3]
                                                  .instructions ==
                                              "no"
                                          ? Column(
                                              crossAxisAlignment:
                                                  CrossAxisAlignment.start,
                                              children: <Widget>[
                                                Text(
                                                  '${cookingOrders[index].orders[index2].foodList[index3].name} x ${cookingOrders[index].orders[index2].foodList[index3].quantity}' ??
                                                      " ",
//
                                                  style: homePageS3,
                                                ),
                                              ],
                                            )
                                          : Column(
                                              crossAxisAlignment:
                                                  CrossAxisAlignment.start,
                                              children: <Widget>[
                                                Text(
                                                  '${cookingOrders[index].orders[index2].foodList[index3].name} x ${cookingOrders[index].orders[index2].foodList[index3].quantity}' ??
                                                      " ",
//
                                                  style: homePageS3,
                                                ),

                                                // for checking instructions

                                                Text(
                                                  cookingOrders[index]
                                                          .orders[index2]
                                                          .foodList[index3]
                                                          .instructions ??
                                                      " ",
                                                ),
                                              ],
                                            ));
                            });
                      },
                    ),
                    Divider(
                      thickness: 2,
                    ),
                  ],
                );
              },
            ),
          )
        : Flexible(
            fit: FlexFit.loose,
            child: Container(
              padding: EdgeInsets.symmetric(vertical: 12),
              child: Text('No Orders'),
            ),
          );

    // display when there in nothing in the queue
  }
}
//    : Flexible(
//fit: FlexFit.loose,
//child: Container(
//child: Column(
//children: <Widget>[
//Expanded(
//child: Padding(
//padding: const EdgeInsets.all(20.0),
//child: Image.asset(
//'assets/icons/plate.png',
//),
//),
//),
//Expanded(
//child: Center(
//child: Text(
//'No Orders Yet',
//style: homePageS4,
//),
//),
//),
//],
//),
//),
//);

import 'package:adhara_socket_io_example/constants.dart';
import 'package:adhara_socket_io_example/data.dart';
import 'package:date_format/date_format.dart';
import 'package:flutter/material.dart';

class Completed extends StatelessWidget {
  final List<TableOrder> completedOrders;
  Completed({
    @required this.completedOrders,
  });

  @override
  Widget build(BuildContext context) {
    return completedOrders.length > 0
        ? Flexible(
            fit: FlexFit.loose,
            child: ListView.builder(
              primary: false,
              shrinkWrap: true,
              itemCount: completedOrders.length,
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
                            'Table : ${completedOrders[index].table}' ?? " ",
                            style: homePageS1,
                          ),
                        ),
                        Container(
                          padding:
                              EdgeInsets.symmetric(vertical: 2, horizontal: 12),
                          child: Text(
//
                            'Arrival Time : ${formatDate(
                                  (completedOrders[index].timeStamp),
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
                      itemCount: completedOrders[index].orders.length,
                      shrinkWrap: true,
                      itemBuilder: (context, index2) {
                        return ListView.builder(
                            primary: false,
                            shrinkWrap: true,
                            itemCount: completedOrders[index]
                                .orders[index2]
                                .foodList
                                .length,
                            itemBuilder: (context, index3) {
                              return Container(
                                  padding: EdgeInsets.symmetric(
                                      vertical: 8, horizontal: 12),
                                  child:
                                      // for checking instructions
                                      completedOrders[index]
                                                  .orders[index2]
                                                  .foodList[index3]
                                                  .instructions ==
                                              "no"
                                          ? Column(
                                              crossAxisAlignment:
                                                  CrossAxisAlignment.start,
                                              children: <Widget>[
                                                Text(
                                                  '${completedOrders[index].orders[index2].foodList[index3].name} x ${completedOrders[index].orders[index2].foodList[index3].quantity}' ??
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
                                                  '${completedOrders[index].orders[index2].foodList[index3].name} x ${completedOrders[index].orders[index2].foodList[index3].quantity}' ??
                                                      " ",
//
                                                  style: homePageS3,
                                                ),

                                                // for checking instructions

                                                Text(
                                                  completedOrders[index]
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
  }
}

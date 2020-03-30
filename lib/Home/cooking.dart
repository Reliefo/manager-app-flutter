import 'package:adhara_socket_io_example/constants.dart';
import 'package:adhara_socket_io_example/data.dart';
import 'package:date_format/date_format.dart';
import 'package:flutter/material.dart';

class Cooking extends StatelessWidget {
  final List<TableOrder> queueOrders;
  final List<TableOrder> cookingOrders;
  Cooking({@required this.queueOrders, @required this.cookingOrders});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(8),
      color: Colors.blueGrey,
      child: Column(
        children: <Widget>[
          Container(
            child: Text(
              'Cooking',
              style: homePageS4,
            ),
          ),

          //to check if there is orders in queue or not
          cookingOrders.length > 0
              ? Expanded(
                  child: ListView.builder(
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
                                padding: EdgeInsets.symmetric(
                                    vertical: 8, horizontal: 12),
                                child: Text(
                                  'Table : ${cookingOrders[index].table}' ??
                                      " ",
                                  style: homePageS1,
                                ),
                              ),
                              Container(
                                padding: EdgeInsets.symmetric(
                                    vertical: 2, horizontal: 12),
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
                                      .foodlist
                                      .length,
                                  itemBuilder: (context, index3) {
                                    return Container(
                                        padding: EdgeInsets.symmetric(
                                            vertical: 8, horizontal: 12),
                                        child:
                                            // for checking instructions
                                            cookingOrders[index]
                                                        .orders[index2]
                                                        .foodlist[index3]
                                                        .instructions ==
                                                    "no"
                                                ? Column(
                                                    crossAxisAlignment:
                                                        CrossAxisAlignment
                                                            .start,
                                                    children: <Widget>[
                                                      Text(
                                                        '${cookingOrders[index].orders[index2].foodlist[index3].name} x ${cookingOrders[index].orders[index2].foodlist[index3].quantity}' ??
                                                            " ",
//
                                                        style: homePageS3,
                                                      ),
                                                    ],
                                                  )
                                                : Column(
                                                    crossAxisAlignment:
                                                        CrossAxisAlignment
                                                            .start,
                                                    children: <Widget>[
                                                      Text(
                                                        '${cookingOrders[index].orders[index2].foodlist[index3].name} x ${cookingOrders[index].orders[index2].foodlist[index3].quantity}' ??
                                                            " ",
//
                                                        style: homePageS3,
                                                      ),

                                                      // for checking instructions

                                                      Text(
                                                        cookingOrders[index]
                                                                .orders[index2]
                                                                .foodlist[
                                                                    index3]
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

              // display when there in nothing in the queue
              : Expanded(
                  child: Container(
                    width: double.maxFinite,
                    child: Column(
                      children: <Widget>[
                        Expanded(
                          child: Padding(
                            padding: const EdgeInsets.all(20.0),
                            child: Image.asset(
                              'assets/icons/plate.png',
                            ),
                          ),
                        ),
                        Expanded(
                          child: Center(
                            child: Text(
                              'No Orders Yet',
                              style: homePageS4,
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
        ],
      ),
    );
  }
}

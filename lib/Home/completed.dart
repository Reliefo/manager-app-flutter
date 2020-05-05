import 'package:adhara_socket_io_example/constants.dart';
import 'package:adhara_socket_io_example/fetchData/fetchOrderData.dart';
import 'package:date_format/date_format.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class Completed extends StatelessWidget {
//  final List<TableOrder> completedOrders;
//  Completed({
//    @required this.completedOrders,
//  });

  @override
  Widget build(BuildContext context) {
    final OrderData orderData = Provider.of<OrderData>(context);
    return orderData.completedOrders.length > 0
        ? Flexible(
            fit: FlexFit.loose,
            child: ListView.builder(
              primary: false,
              shrinkWrap: true,
              itemCount: orderData.completedOrders.length,
              itemBuilder: (context, index) {
//                print(orderData.completedOrders[index].timeStamp.runtimeType);
                return Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: <Widget>[
                        Flexible(
                          child: Container(
                            padding: EdgeInsets.symmetric(
                                vertical: 8, horizontal: 12),
                            child: Text(
                              'Table : ${orderData.completedOrders[index].table}' ??
                                  " ",
                              style: homePageS1,
                              textAlign: TextAlign.start,
                            ),
                          ),
                        ),
                        Flexible(
                          child: Container(
                            padding: EdgeInsets.symmetric(
                                vertical: 2, horizontal: 12),
                            child: Text(
//
                              'Arrival Time : ${formatDate(
                                    (orderData
                                        .completedOrders[index].timeStamp),
                                    [HH, ':', nn],
                                  )}' ??
                                  " ",
                              style: homePageS3, textAlign: TextAlign.end,
                            ),
                          ),
                        ),
                      ],
                    ),
                    ListView.builder(
                      primary: false,
                      itemCount: orderData.completedOrders[index].orders.length,
                      shrinkWrap: true,
                      itemBuilder: (context, index2) {
                        return ListView.builder(
                            primary: false,
                            shrinkWrap: true,
                            itemCount: orderData.completedOrders[index]
                                .orders[index2].foodList.length,
                            itemBuilder: (context, index3) {
                              return Container(
                                  padding: EdgeInsets.symmetric(
                                      vertical: 8, horizontal: 12),
                                  child:
                                      // for checking instructions
                                      orderData
                                                  .completedOrders[index]
                                                  .orders[index2]
                                                  .foodList[index3]
                                                  .instructions ==
                                              "no"
                                          ? Column(
                                              crossAxisAlignment:
                                                  CrossAxisAlignment.start,
                                              children: <Widget>[
                                                Text(
                                                  '${orderData.completedOrders[index].orders[index2].foodList[index3].name} x ${orderData.completedOrders[index].orders[index2].foodList[index3].quantity}' ??
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
                                                  '${orderData.completedOrders[index].orders[index2].foodList[index3].name} x ${orderData.completedOrders[index].orders[index2].foodList[index3].quantity}' ??
                                                      " ",
//
                                                  style: homePageS3,
                                                ),

                                                // for checking instructions

                                                Text(
                                                  orderData
                                                          .completedOrders[
                                                              index]
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

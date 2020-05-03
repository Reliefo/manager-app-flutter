import 'package:adhara_socket_io_example/constants.dart';
import 'package:adhara_socket_io_example/fetchData/fetchOrderData.dart';
import 'package:date_format/date_format.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class Queued extends StatelessWidget {
//  final List<TableOrder> queueOrders;
//  Queued({@required this.queueOrders});
  @override
  Widget build(BuildContext context) {
    final OrderData orderData = Provider.of<OrderData>(context);
    return Container(
      margin: EdgeInsets.symmetric(horizontal: 1),
      color: Colors.grey,
      child: Column(
        children: <Widget>[
          Container(
            color: Colors.black26,
            width: double.maxFinite,
            child: Center(
              child: Text(
                'Queued',
                style: homePageS4,
              ),
            ),
          ),

          //to check if there is orders in queue or not
          orderData.queueOrders.length > 0
              ? Expanded(
                  child: ListView.builder(
                    shrinkWrap: true,
                    itemCount: orderData.queueOrders.length,
                    itemBuilder: (context, index) {
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
                                    'Table : ${orderData.queueOrders[index].table}' ??
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
                                              .queueOrders[index].timeStamp),
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
                            itemCount:
                                orderData.queueOrders[index].orders.length,
                            shrinkWrap: true,
                            itemBuilder: (context, index2) {
                              return ListView.builder(
                                  primary: false,
                                  shrinkWrap: true,
                                  itemCount: orderData.queueOrders[index]
                                      .orders[index2].foodList.length,
                                  itemBuilder: (context, index3) {
                                    return Container(
                                        padding: EdgeInsets.symmetric(
                                            vertical: 8, horizontal: 12),
                                        child:
                                            // for checking instructions
                                            orderData
                                                        .queueOrders[index]
                                                        .orders[index2]
                                                        .foodList[index3]
                                                        .instructions ==
                                                    "no"
                                                ? Column(
                                                    crossAxisAlignment:
                                                        CrossAxisAlignment
                                                            .start,
                                                    children: <Widget>[
                                                      Text(
                                                        '${orderData.queueOrders[index].orders[index2].foodList[index3].name} x ${orderData.queueOrders[index].orders[index2].foodList[index3].quantity}' ??
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
                                                        '${orderData.queueOrders[index].orders[index2].foodList[index3].name} x ${orderData.queueOrders[index].orders[index2].foodList[index3].quantity}' ??
                                                            " ",
//
                                                        style: homePageS3,
                                                      ),

                                                      // for checking instructions

                                                      Text(
                                                        orderData
                                                                .queueOrders[
                                                                    index]
                                                                .orders[index2]
                                                                .foodList[
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

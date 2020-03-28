import 'package:adhara_socket_io_example/constants.dart';
import 'package:adhara_socket_io_example/data.dart';
import 'package:date_format/date_format.dart';
import 'package:flutter/material.dart';

class Queued extends StatelessWidget {
  final List<TableOrder> queueOrders;
  Queued({@required this.queueOrders});
  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.symmetric(horizontal: 1),
      padding: EdgeInsets.all(8),
      color: Colors.grey,
      child: Column(
        children: <Widget>[
          Container(
            child: Text(
              'Queued',
              style: homePageS4,
            ),
          ),

          //to check if there is orders in queue or not
          queueOrders.length > 0
              ? Expanded(
                  child: ListView.builder(
                    shrinkWrap: true,
                    itemCount: queueOrders.length,
                    itemBuilder: (context, index) {
                      return Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: <Widget>[
                          Container(
                            padding: EdgeInsets.symmetric(
                                vertical: 8, horizontal: 12),
                            child: Text(
                              queueOrders[index].table ?? " ",
                              style: homePageS1,
                            ),
                          ),
                          Container(
                            padding: EdgeInsets.symmetric(
                                vertical: 2, horizontal: 12),
                            child: Text(
//
                              'Arrival Time : ${formatDate(
                                    (queueOrders[index].timeStamp),
                                    [HH, ':', nn],
                                  )}' ??
                                  " ",
                              style: homePageS3,
                            ),
                          ),
                          ListView.builder(
                            primary: false,
                            itemCount: queueOrders[index].orders.length,
                            shrinkWrap: true,
                            itemBuilder: (context, index2) {
                              return ListView.builder(
                                  primary: false,
                                  shrinkWrap: true,
                                  itemCount: queueOrders[index]
                                      .orders[index2]
                                      .foodlist
                                      .length,
                                  itemBuilder: (context, index3) {
                                    return Container(
                                      padding: EdgeInsets.symmetric(
                                          vertical: 8, horizontal: 12),
                                      child: Column(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        children: <Widget>[
                                          Text(
                                            queueOrders[index]
                                                    .orders[index2]
                                                    .foodlist['$index3']
                                                    .name ??
                                                " ",
//
                                            style: homePageS3,
                                          ),
                                        ],
                                      ),
                                    );
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
                  child: Text('say there is nothing'),
                ),
        ],
      ),
    );
  }
}

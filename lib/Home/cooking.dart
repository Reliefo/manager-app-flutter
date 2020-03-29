import 'package:adhara_socket_io_example/constants.dart';
import 'package:adhara_socket_io_example/data.dart';
import 'package:flutter/material.dart';

class Cooking extends StatelessWidget {
  final List<TableOrder> queueOrders;
  Cooking({@required this.queueOrders});

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
          queueOrders.length > 0
              ? Expanded(
                  child: ListView.builder(
                    primary: false,
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
                              queueOrders[index].table,
                              style: homePageS1,
                            ),
                          ),
                          Container(
                            padding: EdgeInsets.symmetric(
                                vertical: 2, horizontal: 12),
                            child: Text(
//
                              "Arrival Time : ",
                              style: homePageS3,
                            ),
                          ),
                          ListView.builder(
                            primary: false,
                            itemCount: 2,
//                                            queueOrders[index].foodlist.length,
                            shrinkWrap: true,
                            itemBuilder: (context, index2) {
                              return Container(
                                padding: EdgeInsets.symmetric(
                                    vertical: 8, horizontal: 12),
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: <Widget>[
                                    Text(
                                      'ol',
//                                                  queueOrders[index]
//                                                      .foodlist["$index2"]
//                                                      .name,
                                      style: homePageS3,
                                    ),
                                  ],
                                ),
                              );
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
              : Expanded(
                  child: Text('say there is nothing in cooking list'),
                ),

          //////////////////////////for completed ///////////////////////
          Container(
            child: Text(
              'Completed',
              style: homePageS4,
            ),
          ),
          queueOrders.length > 0
              ? Expanded(
                  child: ListView.builder(
                    primary: false,
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
//                                    queueOrders[index].table,
                              "Ordered By: Table 1",
                              style: homePageS1,
                            ),
                          ),
                          Container(
                            padding: EdgeInsets.symmetric(
                                vertical: 2, horizontal: 12),
                            child: Text(
//
                              "Arrival Time : ",
                              style: homePageS3,
                            ),
                          ),
                          ListView.builder(
                            primary: false,
                            itemCount: 2,
//                                            queueOrders[index].foodlist.length,
                            shrinkWrap: true,
                            itemBuilder: (context, index2) {
                              return Container(
                                padding: EdgeInsets.symmetric(
                                    vertical: 8, horizontal: 12),
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: <Widget>[
                                    Text(
                                      'ol',
//                                                  queueOrders[index]
//                                                      .foodlist["$index2"]
//                                                      .name,
                                      style: homePageS3,
                                    ),
                                  ],
                                ),
                              );
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
              : Expanded(
                  child: Text('say there is nothing in Completed list'),
                ),
        ],
      ),
    );
  }
}

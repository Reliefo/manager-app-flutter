import 'package:flutter/material.dart';

import 'constants.dart';
import 'data.dart';

class HomePage extends StatelessWidget {
  final queuedTableNo = '03';
  final queuedItem = 'Chicken Biryani';
  final queuedAT = '24';
  final currentTableNo = '04';
  final currentItem = 'Pakoda';
  final currentAT = '30';
  List<String> list;
  List<Order> queueOrders;
//  Container getButtonSet;

  HomePage({this.list, this.queueOrders});

  @override
  Widget build(BuildContext context) {
    print('from home');
//    print(queueOrders[0].foodlist["3"].name);

    return SafeArea(
      child: Scaffold(
        body: Container(
          child: Row(
            children: <Widget>[
//              Expanded(
//                  child: Container(
//                color: Colors.red,
//                child: Center(
//                  child: ListView(
//                    children: list.map((String _) => Text(_ ?? "")).toList(),
//                  ),
//                ),
//              )),
              Expanded(
                flex: 3,
                child: Container(
                  padding: EdgeInsets.all(8),
                  color: Colors.blueGrey,
                  child: Column(
                    children: <Widget>[
                      Container(
//                        child: getButtonSet,
                        child: Text(
                          'Assistance',
                          style: homePageS4,
                        ),
                      ),
                      Container(
                        padding:
                            EdgeInsets.symmetric(vertical: 8, horizontal: 12),
                        child: Row(
                          children: <Widget>[
                            Expanded(
                              child: Center(
                                child: Text(
                                  'Table',
                                  style: homePageS1,
                                ),
                              ),
                            ),
                            Expanded(
                              child: Center(
                                child: Text(
                                  'Type',
                                  style: homePageS1,
                                ),
                              ),
                            ),
                            Expanded(
                              child: Center(
                                child: Text(
                                  'Time',
                                  style: homePageS1,
                                ),
                              ),
                            ),
                            Expanded(
                              child: Center(
                                child: Text(
                                  'Status',
                                  style: homePageS1,
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                      Expanded(
                        child: ListView.builder(
                          itemCount: 40,
                          shrinkWrap: true,
                          itemBuilder: (context, index) {
                            return Container(
                              margin: EdgeInsets.symmetric(vertical: 12),
                              child: Row(
                                children: <Widget>[
                                  Expanded(
                                    child: Center(
                                      child: Text(
                                        '06',
                                        style: homePageS2,
                                      ),
                                    ),
                                  ),
                                  Expanded(
                                    child: Center(
                                      child: Text(
                                        'water',
                                        style: homePageS2,
                                      ),
                                    ),
                                  ),
                                  Expanded(
                                    child: Center(
                                      child: Text(
                                        '3:40',
                                        style: homePageS2,
                                      ),
                                    ),
                                  ),
                                  Expanded(
                                    child: Center(
                                      child: Text(
                                        'Pending',
                                        style: homePageS2,
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                            );
                          },
                        ),
                      ),
                    ],
                  ),
                ),
              ),
              Expanded(
                flex: 2,
                child: Container(
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
                      Expanded(
                        child: ListView.builder(
                          shrinkWrap: true,
                          itemBuilder: (context, index) {
                            if (queueOrders.length > 0) {
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
                                    itemCount:
                                        queueOrders[index].foodlist.length,
                                    shrinkWrap: true,
                                    itemBuilder: (context, index2) {
                                      return Container(
                                        padding: EdgeInsets.symmetric(
                                            vertical: 8, horizontal: 12),
                                        child: Column(
                                          crossAxisAlignment:
                                              CrossAxisAlignment.start,
                                          children: <Widget>[
                                            Text(
                                              queueOrders[index]
                                                  .foodlist["$index2"]
                                                  .name,
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
                            } else {
                              return Center(
                                child: CircularProgressIndicator(),
                              );
                            }
                          },
                          itemCount: queueOrders.length,
                        ),
                      ),
                    ],
                  ),
                ),
              ),
              Expanded(
                flex: 2,
                child: Container(
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
                      Expanded(
                        child: ListView.builder(
                          shrinkWrap: true,
                          itemBuilder: (context, index) {
                            if (queueOrders.length > 0) {
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
                                    itemCount:
                                        queueOrders[index].foodlist.length,
                                    shrinkWrap: true,
                                    itemBuilder: (context, index2) {
                                      return Container(
                                        padding: EdgeInsets.symmetric(
                                            vertical: 8, horizontal: 12),
                                        child: Column(
                                          crossAxisAlignment:
                                              CrossAxisAlignment.start,
                                          children: <Widget>[
                                            Text(
                                              queueOrders[index]
                                                  .foodlist["$index2"]
                                                  .name,
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
                            } else {
                              return Center(
                                child: CircularProgressIndicator(),
                              );
                            }
                          },
                          itemCount: queueOrders.length,
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

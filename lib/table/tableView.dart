import 'package:adhara_socket_io_example/constants.dart';
import 'package:adhara_socket_io_example/data.dart';
import 'package:flutter/material.dart';

import 'single_table.dart';

class TableView extends StatelessWidget {
  final Restaurant restaurant;
  final cookingOrders;
  final queueOrders;
  final assistanceReq;

  TableView({
    @required this.restaurant,
    @required this.cookingOrders,
    @required this.queueOrders,
    @required this.assistanceReq,
  });

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        body: Container(
          padding: EdgeInsets.all(10),
          color: Colors.blueGrey,
          child: restaurant.tables != null
              ? GridView.builder(
                  itemCount: restaurant.tables.length,
                  gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: 5,
                  ),
                  itemBuilder: (BuildContext context, index) {
                    return GestureDetector(
                      child: Card(
                        color: Colors.white,
                        child: Container(
                          color:
//                              widget.restaurant.tables[index].noOfUsers == null
//                                  ? Colors.grey
//                                  : tableCounts[index]['cooking'] > 0
//                                      ? Colors.yellow
//                                      : tableCounts[index]['queued'] > 0
//                                          ? Color(0xffFF6347)
//                                          :
                              Colors.blue,
                          padding: EdgeInsets.symmetric(vertical: 10),
                          child: Column(
                            children: <Widget>[
                              Text(
                                'Table-${restaurant.tables[index].name}',
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
                                                'Servers : ${restaurant.tables[index].staff != null ? restaurant.tables[index].staff.length : '0'}',
                                          ),
                                          TextDisplay(
                                            text:
                                                'Scanned : ${restaurant.tables[index].noOfUsers != null ? restaurant.tables[index].noOfUsers : '0'}',
                                          ),
                                          TextDisplay(
                                              text:
                                                  'Cooking : ${restaurant.tables[index].cookingCount}'),
                                          TextDisplay(
                                              text:
                                                  'Queued : ${restaurant.tables[index].queueCount}'),
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
                            table: restaurant.tables[index],
                            assistanceReq: assistanceReq,
                            cookingOrders: cookingOrders,
                            queueOrders: queueOrders,
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

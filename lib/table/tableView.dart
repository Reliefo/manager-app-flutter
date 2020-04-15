import 'package:adhara_socket_io_example/constants.dart';
import 'package:adhara_socket_io_example/data.dart';
import 'package:flutter/material.dart';

import 'single_table.dart';

class TableView extends StatelessWidget {
  final List<TableOrder> queueOrders;
  final List<TableOrder> cookingOrders;
  final List<TableOrder> completedOrders;
  final List<AssistanceRequest> assistanceReq;
  final Restaurant restaurant;

  TableView({
    @required this.queueOrders,
    @required this.cookingOrders,
    @required this.completedOrders,
    @required this.assistanceReq,
    @required this.restaurant,
  });

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        body: Container(
          color: Colors.blueGrey,
          child: Container(
            padding: EdgeInsets.all(10.0),
            child: GridView.builder(
              itemCount: restaurant.tables.length,
              gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 5,
              ),
              itemBuilder: (BuildContext context, index) {
                print(restaurant.tables[index].noOfUsers);
                return GestureDetector(
                  child: Card(
                    color: Colors.white,
                    child: Container(
                      color: restaurant.tables[index].noOfUsers == null
                          ? Color(0xffFF6347)
                          : Colors.green,
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
                                        text: 'Cooking : 01',
                                      ),
                                      TextDisplay(
                                        text: 'Queued  : 02',
                                      ),
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
//                        assistanceReq: assistanceReq,
//                        cookingOrders: cookingOrders,
//                        queueOrders: queueOrders,
                      ),
                    );
                  },
                );
              },
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

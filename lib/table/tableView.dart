import 'package:adhara_socket_io_example/constants.dart';
import 'package:adhara_socket_io_example/data.dart';
import 'package:flutter/material.dart';

import 'single_table.dart';

class TableView extends StatelessWidget {
  final List<TableOrder> queueOrders;
  final List<TableOrder> cookingOrders;
  final List<TableOrder> completedOrders;
  final List<AssistanceRequest> assistanceReq;
  final tableCount;

  TableView({
    @required this.queueOrders,
    @required this.cookingOrders,
    @required this.completedOrders,
    @required this.assistanceReq,
    @required this.tableCount,
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
              itemCount: tableCount,
              gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 5,
              ),
              itemBuilder: (BuildContext context, index) {
//                queueOrders.forEach((tableorder) {
//                  if (tableorder.table == (index + 1).toString()) {
//                    print('here we go');
//                    tableorder.orders.forEach((foodlist){
//                      foodlist.foodlist.forEach(f)
//
//                    });
//
//                  }
//                });
                return GestureDetector(
                  child: Card(
                    color: Colors.white,
                    child: Container(
                      color: Color(0xffFF6347),
                      padding: EdgeInsets.symmetric(vertical: 10),
                      child: Column(
                        children: <Widget>[
                          Text(
                            'Table-${index + 1}',
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
                                        text: 'Servers : 04',
                                      ),
                                      TextDisplay(
                                        text: 'Scanned : 02',
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
                        cookingOrders: cookingOrders,
                        assistanceReq: assistanceReq,
                        tableNo: index + 1,
                        queueOrders: queueOrders,
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

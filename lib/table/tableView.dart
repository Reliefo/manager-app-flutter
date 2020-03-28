import 'package:adhara_socket_io_example/constants.dart';
import 'package:adhara_socket_io_example/data.dart';
import 'package:flutter/material.dart';

import 'single_table.dart';

class TableView extends StatelessWidget {
  final List<AssistanceRequest> assistanceReq;
  final List<TableOrder> queueOrders;
  TableView({@required this.assistanceReq, @required this.queueOrders});
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        body: Container(
          color: Colors.blueGrey,
          child: Container(
            padding: EdgeInsets.all(10.0),
            child: GridView.builder(
              itemCount: 40,
              gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 5,
              ),
              itemBuilder: (BuildContext context, index) {
                return GestureDetector(
                  child: Card(
                    color: Colors.white,
                    child: Container(
                      decoration: BoxDecoration(
                        gradient: LinearGradient(
                          begin: Alignment.bottomLeft,
                          end: Alignment.topRight,
                          //todo: change color according to table filled or not
//                          colors: [Colors.green[200], Colors.white],
                          colors: [
                            Colors.blueGrey[100],
                            Colors.limeAccent[100]
                          ],
                        ),
                      ),
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

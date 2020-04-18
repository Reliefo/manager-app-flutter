import 'package:adhara_socket_io_example/constants.dart';
import 'package:adhara_socket_io_example/data.dart';
import 'package:flutter/material.dart';

import 'single_table.dart';

class TableView extends StatefulWidget {
  final Restaurant restaurant;

  TableView({
    @required this.restaurant,
  });

  @override
  _TableViewState createState() => _TableViewState();
}

class _TableViewState extends State<TableView> {
  Map<String, dynamic> counts = {};

  List<Map<String, dynamic>> tableCounts = [];

  getCount(index) {
    int queued = 0;
    int cooking = 0;
    int completed = 0;

    widget.restaurant.tables[index].tableOrders.forEach((tableOrder) {
      tableOrder.orders.forEach((order) {
        order.foodList.forEach((food) {
          if (food.status == "queued") {
            queued++;
          } else if (food.status == "cooking") {
            cooking++;
          } else if (food.status == "completed") {
            completed++;
          }
        });
      });
    });

    counts = {"queued": queued, "cooking": cooking, "completed": completed};
    tableCounts.add({"${widget.restaurant.tables[index].name}": counts});
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        body: Container(
          padding: EdgeInsets.all(10),
          color: Colors.blueGrey,
          child: widget.restaurant.tables != null
              ? GridView.builder(
                  itemCount: widget.restaurant.tables.length,
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
                                'Table-${widget.restaurant.tables[index].name}',
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
                                                'Servers : ${widget.restaurant.tables[index].staff != null ? widget.restaurant.tables[index].staff.length : '0'}',
                                          ),
                                          TextDisplay(
                                            text:
                                                'Scanned : ${widget.restaurant.tables[index].noOfUsers != null ? widget.restaurant.tables[index].noOfUsers : '0'}',
                                          ),
                                          TextDisplay(
                                              text:
                                                  'Cooking : ${widget.restaurant.tables[index].cookingCount}'),
                                          TextDisplay(
                                              text:
                                                  'Queued : ${widget.restaurant.tables[index].queueCount}'),
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
                            table: widget.restaurant.tables[index],
//                        assistanceReq: assistanceReq,
//                        cookingOrders: cookingOrders,
//                        queueOrders: queueOrders,
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

import 'package:flutter/material.dart';

import 'single_table.dart';

class TableView extends StatelessWidget {
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
              itemBuilder: (BuildContext context, int index) {
                return GestureDetector(
                  child: Card(
                    color: Colors.white,
                    child: Container(
                      padding: EdgeInsets.symmetric(vertical: 10),
                      child: Column(
                        children: <Widget>[
                          Text('Table-$index'),
                          Container(
                            padding: EdgeInsets.symmetric(horizontal: 10),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: <Widget>[
                                Column(
                                  children: <Widget>[
                                    Text('Status'),
                                    Text('order status'),
                                  ],
                                ),
                                Column(
                                  children: <Widget>[
                                    Text('Filled'),
                                    Text('Order Placed'),
                                  ],
                                ),
                              ],
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                  onTap: () {
                    showModalBottomSheet(
                      context: context,
                      builder: (context) => SingleTable(),
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

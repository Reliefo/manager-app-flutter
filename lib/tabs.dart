import 'package:adhara_socket_io_example/person/personView.dart';
import 'package:flutter/material.dart';

import 'data.dart';
import 'home.dart';
import 'table/tableView.dart';

class TabContainerBottom extends StatelessWidget {
  List<String> list;
  List<Order> queueOrders;
  Container getButtonSet;

  TabContainerBottom({this.list, this.getButtonSet, this.queueOrders});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: DefaultTabController(
        initialIndex: 1,
        length: 3,
        child: Scaffold(
          body: TabBarView(
            children: [
              PersonView(),
              HomePage(
                list: list,
                queueOrders: queueOrders,
              ),
              TableView(),
            ],
          ),
          bottomNavigationBar: TabBar(
            tabs: [
              Tab(
                icon: Icon(Icons.person),
                text: 'Person',
              ),
              Tab(
                icon: Icon(Icons.home),
                text: 'HOME',
              ),
              Tab(
                icon: Icon(Icons.table_chart),
                text: 'Table',
              ),
            ],
            labelColor: Colors.black,
            unselectedLabelColor: Colors.grey,
            indicatorSize: TabBarIndicatorSize.label,
            indicatorPadding: EdgeInsets.all(5.0),
            indicatorColor: Colors.blue,
          ),
        ),
      ),
    );
  }
}

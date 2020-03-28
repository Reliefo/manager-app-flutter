import 'package:adhara_socket_io_example/person/personView.dart';
import 'package:flutter/material.dart';

import 'Home/home.dart';
import 'data.dart';
import 'table/tableView.dart';

class TabContainerBottom extends StatelessWidget {
  final List<String> list;
  final List<TableOrder> queueOrders;
  final List<AssistanceRequest> assistanceReq;
  final Container getButtonSet;

  TabContainerBottom(
      {this.list,
      this.getButtonSet,
      @required this.queueOrders,
      @required this.assistanceReq});

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
                assistanceReq: assistanceReq,
                queueOrders: queueOrders,
              ),
              TableView(
                queueOrders: queueOrders,
                assistanceReq: assistanceReq,
              ),
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

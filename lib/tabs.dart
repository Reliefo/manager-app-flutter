import 'package:adhara_socket_io_example/fetchData/configureRestaurantData.dart';
import 'package:adhara_socket_io_example/person/personView.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'Home/home.dart';
import 'data.dart';
import 'table/tableView.dart';

class TabContainerBottom extends StatelessWidget {
  final List<TableOrder> queueOrders;
  final List<TableOrder> cookingOrders;
  final List<TableOrder> completedOrders;
  final List<AssistanceRequest> assistanceReq;
  final restaurant;

  TabContainerBottom({
    this.queueOrders,
    this.cookingOrders,
    this.completedOrders,
    this.assistanceReq,
    this.restaurant,
  });

  @override
  Widget build(BuildContext context) {
    final ConfigureRestaurantData rest =
        Provider.of<ConfigureRestaurantData>(context);
    return MaterialApp(
      home: DefaultTabController(
        initialIndex: 1,
        length: 3,
        child: Scaffold(
          body: TabBarView(
            physics: NeverScrollableScrollPhysics(),
            children: [
              PersonView(
                restaurant: rest.restaurant,
                assistanceReq: assistanceReq,
              ),
              HomePage(
//                queueOrders: queueOrders,
//                cookingOrders: cookingOrders,
//                completedOrders: completedOrders,
//                assistanceReq: assistanceReq,
                  ),
              TableView(
                restaurant: restaurant,
                queueOrders: queueOrders,
                cookingOrders: cookingOrders,
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

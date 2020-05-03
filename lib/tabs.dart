import 'package:adhara_socket_io_example/Drawer/drawermenu.dart';
import 'package:adhara_socket_io_example/fetchData/configureRestaurantData.dart';
import 'package:adhara_socket_io_example/fetchData/fetchAssistanceData.dart';
import 'package:adhara_socket_io_example/fetchData/fetchOrderData.dart';
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
  final sockets;

  TabContainerBottom({
    this.queueOrders,
    this.cookingOrders,
    this.completedOrders,
    this.assistanceReq,
    this.restaurant,
    this.sockets,
  });

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider<RestaurantData>.value(
          value: RestaurantData(
            restaurant: restaurant,
            sockets: sockets,
          ),
        ),
        ChangeNotifierProvider<AssistanceData>.value(
          value: AssistanceData(
            assistanceReq: assistanceReq,
          ),
        ),
        ChangeNotifierProvider<OrderData>.value(
          value: OrderData(
            restaurant: restaurant,
            queueOrders: queueOrders,
            completedOrders: completedOrders,
            cookingOrders: cookingOrders,
          ),
        ),
      ],
      child: MaterialApp(
        home: DefaultTabController(
          initialIndex: 1,
          length: 3,
          child: Scaffold(
            drawer: Drawer(
              child: DrawerMenu(
//                restaurant: restaurant,
//            updateConfigDetailsToCloud: updateConfigDetailsToCloud,
//            login: login,
//            getRest: getRest,
                  ),
            ),
            body: TabBarView(
              physics: NeverScrollableScrollPhysics(),
              children: [
                PersonView(),
                HomePage(),
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
      ),
    );
  }
}

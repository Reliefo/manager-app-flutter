import 'package:flutter/material.dart';
import 'package:manager_app/Drawer/drawermenu.dart';
import 'package:manager_app/fetchData/configureRestaurantData.dart';
import 'package:manager_app/fetchData/fetchOrderData.dart';
import 'package:manager_app/person/personView.dart';
import 'package:provider/provider.dart';

import 'Home/home.dart';
import 'data.dart';
import 'table/tableView.dart';

class TabContainerBottom extends StatelessWidget {
  final List<TableOrder> queueOrders;
  final List<TableOrder> cookingOrders;
  final List<TableOrder> completedOrders;
  final String managerName;
//  final List<AssistanceRequest> assistanceReq;
  final Restaurant restaurant;
  final sockets;
  final Map<String, dynamic> registeredUser;

  TabContainerBottom({
    this.queueOrders,
    this.cookingOrders,
    this.completedOrders,
    this.managerName,
    this.restaurant,
    this.sockets,
    this.registeredUser,
  });

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider<RestaurantData>.value(
          value: RestaurantData(
            restaurant: restaurant,
            sockets: sockets,
            registeredUser: registeredUser,
          ),
        ),
//        ChangeNotifierProvider<AssistanceData>.value(
//          value: AssistanceData(
//            assistanceReq: assistanceReq,
//          ),
//        ),
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
                managerName: managerName,
                restaurantName: restaurant.name,
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

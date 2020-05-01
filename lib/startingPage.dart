import 'package:adhara_socket_io_example/fetchData/configureRestaurantData.dart';
import 'package:adhara_socket_io_example/fetchData/fetchAssistanceData.dart';
import 'package:adhara_socket_io_example/fetchData/fetchOrderData.dart';
import 'package:adhara_socket_io_example/tabs.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class StartingPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider<ConfigureRestaurantData>.value(
          value: ConfigureRestaurantData(),
        ),
        ChangeNotifierProvider<FetchAssistanceData>.value(
          value: FetchAssistanceData(),
        ),
        ChangeNotifierProvider<FetchOrderData>.value(
          value: FetchOrderData(),
        ),
      ],
      child: MaterialApp(
        home: Scaffold(
//          drawer: Drawer(
//            child: DrawerMenu(
//              restaurant: restaurant,
////            updateConfigDetailsToCloud: updateConfigDetailsToCloud,
////            login: login,
////            getRest: getRest,
//            ),
//          ),
          body: TabContainerBottom(
//            restaurant: restaurant,
//            queueOrders: queueOrders,
//            cookingOrders: cookingOrders,
//            completedOrders: completedOrders,
//            assistanceReq: assistanceReq,
              ),
        ),
      ),
    );
  }
}

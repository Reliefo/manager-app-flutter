import 'package:adhara_socket_io_example/Home/completed.dart';
import 'package:adhara_socket_io_example/constants.dart';
import 'package:adhara_socket_io_example/fetchData/fetchAssistanceData.dart';
import 'package:adhara_socket_io_example/fetchData/fetchOrderData.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'assistance.dart';
import 'cooking.dart';
import 'queued.dart';

class HomePage extends StatelessWidget {
//  final List<TableOrder> queueOrders;
//  final List<TableOrder> cookingOrders;
//  final List<TableOrder> completedOrders;
//  final List<AssistanceRequest> assistanceReq;

//  HomePage({
////    this.queueOrders,
////    this.cookingOrders,
////    this.completedOrders,
////    this.assistanceReq,
//  });

  @override
  Widget build(BuildContext context) {
    final FetchOrderData orders = Provider.of<FetchOrderData>(context);
    final FetchAssistanceData assistance =
        Provider.of<FetchAssistanceData>(context);
    return SafeArea(
      child: Scaffold(
        body: Container(
          child: Row(
            children: <Widget>[
              Expanded(
                flex: 3,
                child: Assistance(
                  assistanceReq: assistance.assistanceReq,
                ),
              ),
              Expanded(
                flex: 2,
                child: Queued(
                  queueOrders: orders.queueOrders,
                ),
              ),
              Expanded(
                flex: 2,
                child: Container(
                  color: Colors.blueGrey,
                  child: ListView(
                    children: <Widget>[
                      Column(
                        mainAxisSize: MainAxisSize.min,
                        children: <Widget>[
                          Container(
                            color: Colors.black26,
                            width: double.maxFinite,
                            child: Center(
                              child: Text(
                                'Cooking',
                                style: homePageS4,
                              ),
                            ),
                          ),
                          Cooking(
                            cookingOrders: orders.cookingOrders,
                          ),
                          Container(
                            color: Colors.black26,
                            width: double.maxFinite,
                            child: Center(
                              child: Text(
                                'Completed',
                                style: homePageS4,
                              ),
                            ),
                          ),
                          Completed(
                            completedOrders: orders.completedOrders,
                          )
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
    );
  }
}

import 'package:adhara_socket_io_example/Home/completed.dart';
import 'package:adhara_socket_io_example/constants.dart';
import 'package:flutter/material.dart';

import '../data.dart';
import 'assistance.dart';
import 'cooking.dart';
import 'queued.dart';
//import 'dart:convert';
//import 'package:http/http.dart' as http;
//Future<dynamic> get_order() async {
//  http.Response response =
//      await http.post('http://192.168.0.9:5050/send_orders');
//  var myjson = jsonDecode(response.body);
//  TableOrder order = TableOrder.fromJson(jsonDecode(myjson['new_order']));
//  print(order.timestamp);
//  return order;
//}

class HomePage extends StatelessWidget {
  final List<TableOrder> queueOrders;
  final List<TableOrder> cookingOrders;
  final List<TableOrder> completedOrders;
  final List<AssistanceRequest> assistanceReq;

  HomePage({
    @required this.queueOrders,
    @required this.cookingOrders,
    @required this.completedOrders,
    @required this.assistanceReq,
  });

  @override
  Widget build(BuildContext context) {
//    Future<dynamic> myvar = get_order();
    return SafeArea(
      child: Scaffold(
        body: Container(
          child: Row(
            children: <Widget>[
              Expanded(
                flex: 3,
                child: Assistance(
                  assistanceReq: assistanceReq,
                ),
              ),
              Expanded(
                flex: 2,
                child: Queued(
                  queueOrders: queueOrders,
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
                            cookingOrders: cookingOrders,
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
                            completedOrders: completedOrders,
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

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
  final List<String> list;
  final List<AssistanceRequest> assistanceReq;
  final List<TableOrder> queueOrders;
//  Container getButtonSet;

  HomePage(
      {this.list, @required this.queueOrders, @required this.assistanceReq});

  @override
  Widget build(BuildContext context) {
//    Future<dynamic> myvar = get_order();
    return SafeArea(
      child: Scaffold(
        body: Container(
          child: Row(
            children: <Widget>[
//              Expanded(
//                  child: Container(
//                color: Colors.red,
//                child: Center(
//                  child: ListView(
//                    children: list.map((String _) => Text(_ ?? "")).toList(),
//                  ),
//                ),
//              )),
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
                child: Cooking(
                  queueOrders: queueOrders,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

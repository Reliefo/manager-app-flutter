import 'package:adhara_socket_io_example/Home/completed.dart';
import 'package:adhara_socket_io_example/constants.dart';
import 'package:flutter/material.dart';

import 'assistance.dart';
import 'cooking.dart';
import 'queued.dart';

class HomePage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        body: Container(
          child: Row(
            children: <Widget>[
              Expanded(
//                flex: 3,
                child: Assistance(
//                  assistanceReq: assistance.assistanceReq,
                    ),
              ),
              Expanded(
//                flex: 2,
                child: Queued(
//                  queueOrders: orders.queueOrders,
                    ),
              ),
              Expanded(
//                flex: 2,
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
//                            cookingOrders: orders.cookingOrders,
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
//                            completedOrders: orders.completedOrders,
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

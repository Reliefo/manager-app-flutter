import 'package:flutter/material.dart';
import 'package:manager_app/Home/orderItemBuilder.dart';
import 'package:manager_app/constants.dart';
import 'package:manager_app/fetchData/fetchOrderData.dart';
import 'package:provider/provider.dart';

import 'assistance.dart';
import 'queued.dart';

class HomePage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final OrderData orderData = Provider.of<OrderData>(context);
    return SafeArea(
      child: Scaffold(
        body: Container(
          child: Row(
            children: <Widget>[
              Expanded(
                child: Assistance(),
              ),
              Expanded(
                child: Queued(),
              ),
              Expanded(
//                flex: 2,
                child: Column(
                  children: <Widget>[
                    Container(
                      color: Colors.grey,
                      width: double.maxFinite,
                      child: Center(
                        child: Text(
                          'Cooking',
                          style: homePageS4,
                        ),
                      ),
                    ),
                    Expanded(
                      child: ListView(
                        shrinkWrap: true,
                        children: <Widget>[
                          Column(
                            mainAxisSize: MainAxisSize.min,
                            children: <Widget>[
                              ///////////////////////////////////////cooking/////////////////////////////////

                              orderData.cookingOrders.length > 0
                                  ? Flexible(
                                      fit: FlexFit.loose,
                                      child: OrderItemBuilder(
                                          orderList: orderData.cookingOrders),
                                    )
                                  : Flexible(
                                      fit: FlexFit.loose,
                                      child: Container(
                                        padding:
                                            EdgeInsets.symmetric(vertical: 12),
                                        child: Text('No Orders'),
                                      ),
                                    ),
                              ///////////////////////////////////////completed/////////////////////////////////
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
                              orderData.completedOrders.length > 0
                                  ? Flexible(
                                      fit: FlexFit.loose,
                                      child: OrderItemBuilder(
                                          orderList: orderData.completedOrders),
                                    )
                                  : Flexible(
                                      fit: FlexFit.loose,
                                      child: Container(
                                        padding:
                                            EdgeInsets.symmetric(vertical: 12),
                                        child: Text('No Orders'),
                                      ),
                                    ),
                            ],
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

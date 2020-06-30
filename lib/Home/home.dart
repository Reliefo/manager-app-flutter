import 'package:flutter/material.dart';
import 'package:manager_app/Home/orderItemBuilder.dart';
import 'package:manager_app/constants.dart';
import 'package:manager_app/fetchData/configureRestaurantData.dart';
import 'package:manager_app/fetchData/fetchOrderData.dart';
import 'package:provider/provider.dart';

import 'assistance.dart';
import 'queued.dart';

class HomePage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final OrderData orderData = Provider.of<OrderData>(context);
    final RestaurantData restaurantData = Provider.of<RestaurantData>(context);
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
                      color: kThemeColor,
                      width: double.maxFinite,
                      child: Center(
                        child: Text(
                          'Cooking',
                          style: kHeaderStyle,
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
                                        reverseOrder: false,
                                        orderList: orderData.cookingOrders,
                                      ),
                                    )
                                  : Flexible(
                                      fit: FlexFit.loose,
                                      child: Container(
                                        height:
                                            MediaQuery.of(context).size.height *
                                                0.3,
                                        padding:
                                            EdgeInsets.symmetric(vertical: 12),
                                        child: Center(
                                          child: Text(
                                            'No Orders',
                                            style: kHeaderStyle,
                                          ),
                                        ),
                                      ),
                                    ),
                              ///////////////////////////////////////completed/////////////////////////////////
                              Container(
                                color: kThemeColor,
                                width: double.maxFinite,
                                child: Center(
                                  child: Text(
                                    'Completed',
                                    style: kHeaderStyle,
                                  ),
                                ),
                              ),
                              orderData.completedOrders.length > 0
                                  ? Flexible(
                                      fit: FlexFit.loose,
                                      child: OrderItemBuilder(
                                        reverseOrder: true,
                                        orderList: orderData.completedOrders,
                                      ),
                                    )
                                  : Flexible(
                                      fit: FlexFit.loose,
                                      child: Container(
                                        height:
                                            MediaQuery.of(context).size.height *
                                                0.3,
                                        padding:
                                            EdgeInsets.symmetric(vertical: 12),
                                        child: Center(
                                          child: Text(
                                            'No Orders',
                                            style: kHeaderStyle,
                                          ),
                                        ),
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

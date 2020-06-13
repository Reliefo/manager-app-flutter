import 'package:flutter/material.dart';
import 'package:manager_app/Home/orderItemBuilder.dart';
import 'package:manager_app/constants.dart';
import 'package:manager_app/fetchData/fetchOrderData.dart';
import 'package:provider/provider.dart';

class Queued extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final OrderData orderData = Provider.of<OrderData>(context);
    return Container(
      margin: EdgeInsets.symmetric(horizontal: 1),
      color: Colors.grey[50],
      child: Column(
        children: <Widget>[
          Container(
            color: kThemeColor,
            width: double.maxFinite,
            child: Center(
              child: Text(
                'Queued',
                style: kHeaderStyle,
              ),
            ),
          ),

          //to check if there is orders in queue or not
          orderData.queueOrders.length > 0
              ? Flexible(
                  fit: FlexFit.loose,
                  child: SingleChildScrollView(
                    child: OrderItemBuilder(
                      reverseOrder: false,
                      orderList: orderData.queueOrders,
                    ),
                  ))

              // display when there in nothing in the queue
              : Expanded(
                  child: Container(
                    width: double.maxFinite,
                    child: Column(
                      children: <Widget>[
                        Expanded(
                          child: Padding(
                            padding: const EdgeInsets.all(20.0),
                            child: Image.asset(
                              'assets/icons/plate.png',
                            ),
                          ),
                        ),
                        Expanded(
                          child: Center(
                            child: Text(
                              'No Orders Yet',
                              style: homePageS4,
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
        ],
      ),
    );
  }
}

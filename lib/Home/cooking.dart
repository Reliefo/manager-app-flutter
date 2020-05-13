import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:manager_app/Home/orderItemBuilder.dart';
import 'package:manager_app/fetchData/fetchOrderData.dart';
import 'package:provider/provider.dart';

/////////////////////////////not in use
class Cooking extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final OrderData orderData = Provider.of<OrderData>(context);
    return orderData.cookingOrders.length > 0
        ? Flexible(
            fit: FlexFit.loose,
            child: OrderItemBuilder(orderList: orderData.cookingOrders),
          )
        : Flexible(
            fit: FlexFit.loose,
            child: Container(
              padding: EdgeInsets.symmetric(vertical: 12),
              child: Text('No Orders'),
            ),
          );
  }
}

import 'package:flutter/material.dart';
import 'package:manager_app/Home/orderItemBuilder.dart';
import 'package:manager_app/fetchData/fetchOrderData.dart';
import 'package:provider/provider.dart';

class Completed extends StatelessWidget {
/////////////////////////////not in use

  @override
  Widget build(BuildContext context) {
    final OrderData orderData = Provider.of<OrderData>(context);
    return orderData.completedOrders.length > 0
        ? Flexible(
            fit: FlexFit.loose,
            child: OrderItemBuilder(orderList: orderData.completedOrders),
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

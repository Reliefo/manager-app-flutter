import 'package:flutter/material.dart';
import 'package:manager_app/Drawer/orderHistory/salesDetails.dart';
import 'package:manager_app/fetchData/configureRestaurantData.dart';
import 'package:provider/provider.dart';

class OrderHistoryPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final RestaurantData restaurantData = Provider.of<RestaurantData>(context);

    return SalesDetails(
      salesHistory: restaurantData.restaurant.orderHistory,
    );
  }
}

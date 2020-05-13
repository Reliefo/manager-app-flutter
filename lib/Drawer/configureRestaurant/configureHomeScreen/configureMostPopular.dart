import 'package:flutter/material.dart';
import 'package:manager_app/data.dart';
import 'package:manager_app/fetchData/configureRestaurantData.dart';
import 'package:provider/provider.dart';

class MostPopular extends StatelessWidget {
//  final Restaurant restaurant;
  List<MenuFoodItem> mostPopularBar = [];
  List<MenuFoodItem> mostPopularFood = [];
//  MostPopular({
//    this.restaurant,
//  });

  getMostPopular(restaurantData) {
    if (restaurantData.restaurant.barMenu != null) {
      restaurantData.restaurant.barMenu.forEach((category) {
        category.foodList.forEach((food) {
          if (food.tags.isNotEmpty) {
            food.tags.forEach((tag) {
              if (tag == "most_popular") {
                mostPopularBar.add(food);
              }
            });
          }
        });
      });
    }
    if (restaurantData.restaurant.barMenu != null) {
      restaurantData.restaurant.foodMenu.forEach((category) {
        category.foodList.forEach((food) {
          if (food.tags.isNotEmpty) {
            food.tags.forEach((tag) {
              if (tag == "most_popular") {
                mostPopularFood.add(food);
              }
            });
          }
        });
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    final RestaurantData restaurantData = Provider.of<RestaurantData>(context);
    getMostPopular(restaurantData);
    return SafeArea(
      child: Scaffold(
        body: Container(
          child: ListView.builder(
              itemCount: mostPopularFood.length,
              itemBuilder: (context, index) {
                return Text(mostPopularFood[index].name);
              }),
        ),
      ),
    );
  }
}

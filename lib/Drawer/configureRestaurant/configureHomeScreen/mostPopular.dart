import 'package:adhara_socket_io_example/data.dart';
import 'package:flutter/material.dart';

class MostPopular extends StatelessWidget {
  final Restaurant restaurant;
  List<MenuFoodItem> mostPopularBar = [];
  List<MenuFoodItem> mostPopularFood = [];
  MostPopular({
    this.restaurant,
  });

  getMostPopular() {
    if (restaurant.barMenu != null) {
      restaurant.barMenu.forEach((category) {
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
    if (restaurant.barMenu != null) {
      restaurant.foodMenu.forEach((category) {
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
    getMostPopular();
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

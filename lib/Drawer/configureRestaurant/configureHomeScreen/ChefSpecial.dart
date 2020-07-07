import 'package:flutter/material.dart';
import 'package:manager_app/constants.dart';
import 'package:manager_app/data.dart';
import 'package:manager_app/fetchData/configureRestaurantData.dart';
import 'package:provider/provider.dart';

class ChefSpecial extends StatelessWidget {
  final List<MenuFoodItem> chefSpecialBar = [];
  final List<MenuFoodItem> chefSpecialFood = [];
//  [Most Popular, Chef's Special, Daily Special, On Offer]
  getChefSpecial(restaurantData) {
    restaurantData.restaurant.barMenu?.forEach((category) {
      category?.foodList?.forEach((food) {
        if (food.tags.isNotEmpty) {
          food.tags.forEach((tag) {
            if (tag == "Chef's Special") {
              chefSpecialBar.add(food);
            }
          });
        }
      });
    });

    restaurantData.restaurant.foodMenu?.forEach((category) {
      category?.foodList?.forEach((food) {
        if (food.tags.isNotEmpty) {
          food.tags.forEach((tag) {
            if (tag == "Chef's Special") {
              chefSpecialFood.add(food);
            }
          });
        }
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    final RestaurantData restaurantData = Provider.of<RestaurantData>(context);
    getChefSpecial(restaurantData);
    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
          title: Text("Chef's Special"),
          backgroundColor: kThemeColor,
        ),
        body: Container(
          child: restaurantData.restaurant.homeScreenTags[3] != null &&
                  restaurantData
                      .restaurant.homeScreenTags[3].foodList.isNotEmpty
              ? SingleChildScrollView(
                  child: Column(
                    children: <Widget>[
                      GridView.builder(
                          shrinkWrap: true,
                          primary: false,
                          itemCount: restaurantData
                              .restaurant.homeScreenTags[1].foodList.length,
                          gridDelegate:
                              SliverGridDelegateWithMaxCrossAxisExtent(
                            mainAxisSpacing: 4.0,
                            crossAxisSpacing: 4.0,
                            childAspectRatio: 1.5,
                            maxCrossAxisExtent: 260,
                          ),
                          itemBuilder: (BuildContext context, index) {
                            return Container(
                              margin: EdgeInsets.all(4),
                              padding: EdgeInsets.symmetric(vertical: 10),
                              decoration: BoxDecoration(
//                                color: getColour(index, restaurantData),
                                border:
                                    Border.all(width: 3.0, color: kThemeColor),
                                borderRadius: BorderRadius.all(
                                  Radius.circular(15.0),
                                ),
                              ),
                              child: Center(
                                child: Text(
                                  restaurantData.restaurant.homeScreenTags[3]
                                      .foodList[index].name,
                                  style: kTitleStyle,
                                ),
                              ),
                            );
                          }),
                      GridView.builder(
                          primary: false,
                          shrinkWrap: true,
                          itemCount: chefSpecialBar.length,
                          gridDelegate:
                              SliverGridDelegateWithMaxCrossAxisExtent(
                            mainAxisSpacing: 4.0,
                            crossAxisSpacing: 4.0,
                            childAspectRatio: 1,
                            maxCrossAxisExtent: 240,
                          ),
                          itemBuilder: (BuildContext context, index) {
                            return Container(
                              margin: EdgeInsets.all(4),
                              padding: EdgeInsets.symmetric(vertical: 10),
                              decoration: BoxDecoration(
//                                color: getColour(index, restaurantData),
                                border:
                                    Border.all(width: 3.0, color: kThemeColor),
                                borderRadius: BorderRadius.all(
                                  Radius.circular(15.0),
                                ),
                              ),
                              child: Center(
                                child: Text(
                                  chefSpecialBar[index].name,
                                  style: kTitleStyle,
                                ),
                              ),
                            );
                          }),
                    ],
                  ),
                )
              : Center(
                  child: Text(
                    "Go to Home Screen Tags and add Items to Chef's Special Items.",
                    style: kHeaderStyle,
                  ),
                ),
        ),
      ),
    );
  }
}

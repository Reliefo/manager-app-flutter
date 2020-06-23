import 'package:flutter/material.dart';
import 'package:manager_app/constants.dart';
import 'package:manager_app/data.dart';
import 'package:manager_app/fetchData/configureRestaurantData.dart';
import 'package:provider/provider.dart';

class OnOffer extends StatelessWidget {
  final List<MenuFoodItem> onOfferBar = [];
  final List<MenuFoodItem> onOfferFood = [];
//  [Most Popular, Chef's Special, Daily Special, On Offer]
  getOnOffer(restaurantData) {
    restaurantData.restaurant.barMenu?.forEach((category) {
      category?.foodList?.forEach((food) {
        if (food.tags.isNotEmpty) {
          food.tags.forEach((tag) {
            if (tag == "On Offer") {
              onOfferBar.add(food);
            }
          });
        }
      });
    });

    restaurantData.restaurant.foodMenu?.forEach((category) {
      category?.foodList?.forEach((food) {
        if (food.tags.isNotEmpty) {
          food.tags.forEach((tag) {
            if (tag == "On Offer") {
              onOfferFood.add(food);
            }
          });
        }
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    final RestaurantData restaurantData = Provider.of<RestaurantData>(context);
    getOnOffer(restaurantData);
    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
          title: Text("On Offer"),
          backgroundColor: kThemeColor,
        ),
        body: Container(
          child: onOfferFood.isNotEmpty || onOfferBar.isNotEmpty
              ? SingleChildScrollView(
                  child: Column(
                    children: <Widget>[
                      GridView.builder(
                          shrinkWrap: true,
                          primary: false,
                          itemCount: onOfferFood.length,
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
                                  onOfferFood[index].name,
                                  style: kTitleStyle,
                                ),
                              ),
                            );
                          }),
                      GridView.builder(
                          primary: false,
                          shrinkWrap: true,
                          itemCount: onOfferBar.length,
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
                                  onOfferBar[index].name,
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
                    "Go to Home Screen Tags and add Items to On Offer Items.",
                    style: kHeaderStyle,
                  ),
                ),
        ),
      ),
    );
  }
}

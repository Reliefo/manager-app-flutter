import 'package:flutter/material.dart';
import 'package:manager_app/Drawer/configureRestaurant/configureHomeScreen/configureTags/navigateBetter/addBarItemToTags.dart';
import 'package:manager_app/Drawer/configureRestaurant/configureHomeScreen/configureTags/navigateBetter/addFoodItemToTags.dart';
import 'package:manager_app/data.dart';
import 'package:manager_app/fetchData/configureRestaurantData.dart';
import 'package:provider/provider.dart';

class ConfigureHomeScreenTags extends StatefulWidget {
//  final Restaurant restaurant;
//  final updateConfigDetailsToCloud;
//
//  ConfigureHomeScreenTags({
//    @required this.restaurant,
//    this.updateConfigDetailsToCloud,
//  });

  @override
  _ConfigureHomeScreenTagsState createState() =>
      _ConfigureHomeScreenTagsState();
}

class _ConfigureHomeScreenTagsState extends State<ConfigureHomeScreenTags> {
  final tagController = TextEditingController();
  List<MenuFoodItem> barItems = [];

  List<MenuFoodItem> foodItems = [];
  int _selectedIndex;

  String selectedTag;

  _onSelected(int index, restaurantData) {
    setState(() {
      _selectedIndex = index;

      selectedTag = restaurantData.restaurant.homeScreenTags[index];
    });
  }

  getTagItems(selectedTag, restaurantData) {
    setState(() {
      barItems.clear();
      foodItems.clear();

      restaurantData.restaurant.barMenu.forEach((category) {
        category.foodList.forEach((food) {
          if (food.tags.isNotEmpty) {
            food.tags.forEach((tag) {
              if (tag == selectedTag) {
                barItems.add(food);
              }
            });
          }
        });
      });
      restaurantData.restaurant.foodMenu.forEach((category) {
        category.foodList.forEach((food) {
          if (food.tags.isNotEmpty) {
            food.tags.forEach((tag) {
              if (tag == selectedTag) {
                foodItems.add(food);
              }
            });
          }
        });
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    final RestaurantData restaurantData = Provider.of<RestaurantData>(context);
    getTagItems(selectedTag, restaurantData);
    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
          backgroundColor: Colors.grey,
          title: Text('Configure Home Screen Tags'),
        ),
        body: Container(
          child: Row(
            children: <Widget>[
              Expanded(
                child: Container(
                  color: Colors.green,
                  child: Column(
                    children: <Widget>[
                      Container(
                        padding: EdgeInsets.symmetric(vertical: 10),
                        child: ListTile(
                            title: Text('Add New Tag'),
                            trailing: Icon(Icons.add),
                            onTap: () {
                              showDialog(
                                barrierDismissible: false,
                                context: context,
                                builder: (BuildContext context) {
                                  // return object of type Dialog
                                  return AddNewTag(
                                      tagController: tagController);
                                },
                              );
                            }),
                      ),
                      Expanded(
                        child: ListView.builder(
                          shrinkWrap: true,
                          itemCount: restaurantData.restaurant.homeScreenTags !=
                                  null
                              ? restaurantData.restaurant.homeScreenTags.length
                              : 0,
                          itemBuilder: (context, index) {
                            return Container(
                              color: _selectedIndex != null &&
                                      _selectedIndex == index
                                  ? Colors.tealAccent
                                  : Colors.transparent,
                              child: ListTile(
                                title: Text(restaurantData
                                    .restaurant.homeScreenTags[index]),
                                trailing: IconButton(
                                    icon: Icon(Icons.close),
                                    onPressed: () {
                                      showDialog(
                                        barrierDismissible: false,
                                        context: context,
                                        builder: (BuildContext context) {
                                          // return object of type Dialog
                                          return AlertDialog(
                                            shape: RoundedRectangleBorder(
                                              borderRadius:
                                                  BorderRadius.circular(20),
                                            ),
                                            title: Text(
                                                "Delete ${restaurantData.restaurant.homeScreenTags[index]} tag ?"),
                                            content: Column(
                                              mainAxisSize: MainAxisSize
                                                  .min, // To make the card compact
                                              children: <Widget>[
                                                Text(
                                                  "This will delete all the food items under this tag",
                                                  textAlign: TextAlign.center,
                                                  style: TextStyle(
                                                    fontSize: 16.0,
                                                  ),
                                                ),
                                                SizedBox(height: 24.0),
                                                Row(
                                                  mainAxisAlignment:
                                                      MainAxisAlignment
                                                          .spaceAround,
                                                  children: <Widget>[
                                                    FlatButton(
                                                      child: Text(
                                                        "Back",
                                                        style: TextStyle(
                                                            color:
                                                                Colors.green),
                                                      ),
                                                      onPressed: () {
                                                        Navigator.of(context)
                                                            .pop(); // To close the dialog
                                                      },
                                                    ),
                                                    FlatButton(
                                                      child: Text(
                                                        "Delete",
                                                        style: TextStyle(
                                                            color: Colors.red),
                                                      ),
                                                      onPressed: () {
                                                        restaurantData
                                                            .sendConfiguredDataToBackend({
                                                          "remove_from":
                                                              "home_screen",
                                                          "tag_name": restaurantData
                                                                  .restaurant
                                                                  .homeScreenTags[
                                                              index]
                                                        }, "delete_home_screen_tags");

                                                        Navigator.of(context)
                                                            .pop(); // To close the dialog
                                                      },
                                                    ),
                                                  ],
                                                )
                                              ],
                                            ),
                                          );
                                        },
                                      );
                                    }),
                                onTap: () {
                                  _onSelected(index, restaurantData);
                                  getTagItems(
                                      restaurantData
                                          .restaurant.homeScreenTags[index],
                                      restaurantData);
                                },
                              ),
                            );
                          },
                        ),
                      ),
                    ],
                  ),
                ),
              ),
              Expanded(
                child: Container(
                  color: Colors.blue,
                  child: selectedTag == null
                      ? Center(
                          child: Text("Select Tag"),
                        )
                      : Column(
                          children: <Widget>[
                            Container(
                              padding: EdgeInsets.symmetric(vertical: 10),
                              child: ListTile(
                                title: Text('Add New Bar Item to $selectedTag'),
                                trailing: Icon(Icons.add),
                                onTap: () {
                                  showDialog(
                                    barrierDismissible: false,
                                    context: context,
                                    builder: (BuildContext context) {
                                      // return object of type Dialog
                                      return AddBarItemToTags(
                                        selectedTag: selectedTag,
                                      );
                                    },
                                  );
                                },
                              ),
                            ),
                            Expanded(
                              child: ListView.builder(
                                shrinkWrap: true,
                                itemCount: barItems.length,
                                itemBuilder: (context, index) {
                                  return ListTile(
                                    title: Text(barItems[index].name),
                                    trailing: IconButton(
                                      icon: Icon(Icons.cancel),
                                      onPressed: () {
                                        restaurantData
                                            .sendConfiguredDataToBackend({
                                          "food_id": barItems[index].oid,
                                          "tag_name": selectedTag,
                                        }, "remove_home_screen_tags");
                                      },
                                    ),
                                  );
                                },
                              ),
                            ),
                          ],
                        ),
                ),
              ),
              Expanded(
                child: Container(
                  color: Colors.yellow,
                  child: selectedTag == null
                      ? Center(
                          child: Text("Select Tag"),
                        )
                      : Column(
                          children: <Widget>[
                            Container(
                              padding: EdgeInsets.symmetric(vertical: 10),
                              child: ListTile(
                                title:
                                    Text('Add New Food Item to $selectedTag'),
                                trailing: Icon(Icons.add),
                                onTap: () {
                                  showDialog(
                                    barrierDismissible: false,
                                    context: context,
                                    builder: (BuildContext context) {
                                      // return object of type Dialog
                                      return AddFoodItemToTags(
                                        selectedTag: selectedTag,
//                                        restaurant: widget.restaurant,
                                      );
                                    },
                                  );
                                },
                              ),
                            ),
                            Expanded(
                              child: ListView.builder(
                                shrinkWrap: true,
                                itemCount: foodItems.length,
                                itemBuilder: (context, index) {
                                  return ListTile(
                                    title: Text(foodItems[index].name),
                                    trailing: IconButton(
                                      icon: Icon(Icons.cancel),
                                      onPressed: () {
                                        restaurantData
                                            .sendConfiguredDataToBackend({
                                          "food_id": foodItems[index].oid,
                                          "tag_name": selectedTag,
                                        }, "remove_home_screen_tags");
                                      },
                                    ),
                                  );
                                },
                              ),
                            ),
                          ],
                        ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class AddNewTag extends StatelessWidget {
  const AddNewTag({
    Key key,
    @required this.tagController,
  }) : super(key: key);

  final TextEditingController tagController;

  @override
  Widget build(BuildContext context) {
    final RestaurantData restaurantData = Provider.of<RestaurantData>(context);
    return AlertDialog(
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(20),
      ),
      content: Column(
        mainAxisSize: MainAxisSize.min, // To make the card compact
        children: <Widget>[
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: <Widget>[
              Text(
                "Enter Tag:  ",
                textAlign: TextAlign.center,
                style: TextStyle(
                  fontSize: 16.0,
                ),
              ),
              SizedBox(width: 20),
              Container(
                width: 200,
                child: TextField(
                  controller: tagController,
                  autofocus: true,
                ),
              ),
            ],
          ),
          SizedBox(height: 24.0),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: <Widget>[
              FlatButton(
                child: Text(
                  "Cancel",
                  style: TextStyle(color: Colors.red),
                ),
                onPressed: () {
                  Navigator.of(context).pop(); // To close the dialog
                },
              ),
              FlatButton(
                child: Text(
                  "Done",
                  style: TextStyle(color: Colors.green),
                ),
                onPressed: () {
                  restaurantData.sendConfiguredDataToBackend(
                      {"add_to": "home_screen", "tag_name": tagController.text},
                      "add_home_screen_tags");
                  tagController.clear();
                  Navigator.of(context).pop(); // To close the dialog
                },
              ),
            ],
          )
        ],
      ),
    );
  }
}

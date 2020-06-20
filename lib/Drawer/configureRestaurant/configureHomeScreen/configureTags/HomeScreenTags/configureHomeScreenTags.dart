import 'package:flutter/material.dart';
import 'package:manager_app/Drawer/configureRestaurant/configureHomeScreen/configureTags/addNewTag.dart';
import 'package:manager_app/Drawer/configureRestaurant/configureHomeScreen/configureTags/navigateBetter/addBarItemToTags.dart';
import 'package:manager_app/Drawer/configureRestaurant/configureHomeScreen/configureTags/navigateBetter/addFoodItemToTags.dart';
import 'package:manager_app/constants.dart';
import 'package:manager_app/data.dart';
import 'package:manager_app/fetchData/configureRestaurantData.dart';
import 'package:provider/provider.dart';

class ConfigureHomeScreenTags extends StatefulWidget {
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

  String radioItem = 'foodMenu';

  List<MenuFoodItem> selectedTagItems = [];

  getTagItems(selectedTag, restaurantData) {
    print("get tags called");
    setState(() {
//      barItems.clear();
//      foodItems.clear();
      selectedTagItems.clear();
      if (restaurantData.restaurant.barMenu != null &&
          restaurantData.restaurant.barMenu.isNotEmpty) {
        restaurantData.restaurant.barMenu.forEach((category) {
          category.foodList.forEach((food) {
            if (food.tags != null) {
              if (food.tags.isNotEmpty) {
                food.tags.forEach((tag) {
                  if (tag == selectedTag) {
                    selectedTagItems.add(food);
                  }
                });
              }
            }
          });
        });
      }
      if (restaurantData.restaurant.foodMenu != null &&
          restaurantData.restaurant.foodMenu.isNotEmpty) {
        restaurantData.restaurant.foodMenu.forEach((category) {
          category.foodList.forEach((food) {
            if (food.tags != null) {
              if (food.tags.isNotEmpty) {
                food.tags.forEach((tag) {
                  if (tag == selectedTag) {
                    selectedTagItems.add(food);
                  }
                });
              }
            }
          });
        });
      }
    });
  }

  _onSelected(int index, restaurantData) {
    setState(() {
      _selectedIndex = index;

      selectedTag = restaurantData.restaurant.homeScreenTags[index];
    });
  }

  @override
  Widget build(BuildContext context) {
    final RestaurantData restaurantData = Provider.of<RestaurantData>(context);
    getTagItems(selectedTag, restaurantData);
    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
          backgroundColor: kThemeColor,
          title: Text('Configure Home Screen Tags'),
        ),
        body: Container(
          child: Row(
            children: <Widget>[
              Expanded(
                child: Container(
                  color: Colors.white,
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
                                      addTo: "home_screen",
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
                                  ? Colors.black12
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
                  color: Colors.white,
                  child: Column(
                    children: <Widget>[
                      Container(
                        padding: EdgeInsets.symmetric(vertical: 10),
                        child: ListTile(
                          title: selectedTag != null
                              ? Text('Items in $selectedTag')
                              : Text('Select Tag to Show Items !'),
                        ),
                      ),
                      Expanded(
                        child: ListView.builder(
                          shrinkWrap: true,
                          itemCount: selectedTagItems.length,
                          itemBuilder: (context, index) {
                            return ListTile(
                              title: Text(selectedTagItems[index].name),
                              trailing: IconButton(
                                icon: Icon(Icons.cancel),
                                onPressed: () {
                                  restaurantData.sendConfiguredDataToBackend({
                                    "food_id": selectedTagItems[index].oid,
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
              VerticalDivider(
                thickness: 3,
                indent: 12,
              ),
              Expanded(
                child: Container(
                  color: Colors.white,
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: <Widget>[
                      Container(
                        padding: EdgeInsets.symmetric(vertical: 10),
                        child: ListTile(
                          title: selectedTag != null
                              ? Text('Add New Item to $selectedTag')
                              : Text('Select Tag to Add Items'),
                        ),
                      ),
                      Expanded(
                        child: selectedTag != null
                            ? SingleChildScrollView(
                                child: Column(
                                  children: <Widget>[
                                    Row(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: <Widget>[
                                        Expanded(
                                          child: RadioListTile(
                                            groupValue: radioItem,
                                            title: Text('Food Menu'),
                                            value: 'foodMenu',
                                            onChanged: (val) {
                                              setState(() {
                                                radioItem = val;
                                              });
                                            },
                                          ),
                                        ),
                                        Expanded(
                                          child: RadioListTile(
                                            groupValue: radioItem,
                                            title: Text('Bar Menu'),
                                            value: 'barMenu',
                                            onChanged: (val) {
                                              setState(() {
                                                radioItem = val;
                                              });
                                            },
                                          ),
                                        ),
                                      ],
                                    ),
                                    radioItem == "barMenu"
                                        ? AddBarItemToTags(
//                                            getTagItems: getTagItems,
                                            selectedTag: selectedTag)
                                        : AddFoodItemToTags(
                                            getTagItems: getTagItems,
                                            selectedTag: selectedTag),
                                  ],
                                ),
                              )
                            : Center(
                                child: Text("select tag"),
                              ),
                      ),
                    ],
                  ),
                ),
              ),

//              Expanded(
//                child: Container(
//                  color: Colors.blue,
//                  child: selectedTag == null
//                      ? Center(
//                          child: Text("Select Tag"),
//                        )
//                      : Column(
//                          children: <Widget>[
//                            Container(
//                              padding: EdgeInsets.symmetric(vertical: 10),
//                              child: ListTile(
//                                title: Text('Add New Bar Item to $selectedTag'),
//                                trailing: Icon(Icons.add),
//                                onTap: () {
//                                  showDialog(
//                                    barrierDismissible: false,
//                                    context: context,
//                                    builder: (BuildContext context) {
//                                      // return object of type Dialog
//                                      return AddBarItemToTags(
//                                        selectedTag: selectedTag,
//                                      );
//                                    },
//                                  );
//                                },
//                              ),
//                            ),
//                            Expanded(
//                              child: ListView.builder(
//                                shrinkWrap: true,
//                                itemCount: barItems.length,
//                                itemBuilder: (context, index) {
//                                  return ListTile(
//                                    title: Text(barItems[index].name),
//                                    trailing: IconButton(
//                                      icon: Icon(Icons.cancel),
//                                      onPressed: () {
//                                        restaurantData
//                                            .sendConfiguredDataToBackend({
//                                          "food_id": barItems[index].oid,
//                                          "tag_name": selectedTag,
//                                        }, "remove_home_screen_tags");
//                                      },
//                                    ),
//                                  );
//                                },
//                              ),
//                            ),
//                          ],
//                        ),
//                ),
//              ),
//              Expanded(
//                child: Container(
//                  color: Colors.yellow,
//                  child: selectedTag == null
//                      ? Center(
//                          child: Text("Select Tag"),
//                        )
//                      : Column(
//                          children: <Widget>[
//                            Container(
//                              padding: EdgeInsets.symmetric(vertical: 10),
//                              child: ListTile(
//                                title:
//                                    Text('Add New Food Item to $selectedTag'),
//                                trailing: Icon(Icons.add),
//                                onTap: () {
//                                  showDialog(
//                                    barrierDismissible: false,
//                                    context: context,
//                                    builder: (BuildContext context) {
//                                      // return object of type Dialog
//                                      return AddFoodItemToTags(
//                                        selectedTag: selectedTag,
////                                        restaurant: widget.restaurant,
//                                      );
//                                    },
//                                  );
//                                },
//                              ),
//                            ),
//                            Expanded(
//                              child: ListView.builder(
//                                shrinkWrap: true,
//                                itemCount: foodItems.length,
//                                itemBuilder: (context, index) {
//                                  return ListTile(
//                                    title: Text(foodItems[index].name),
//                                    trailing: IconButton(
//                                      icon: Icon(Icons.cancel),
//                                      onPressed: () {
//                                        restaurantData
//                                            .sendConfiguredDataToBackend({
//                                          "food_id": foodItems[index].oid,
//                                          "tag_name": selectedTag,
//                                        }, "remove_home_screen_tags");
//                                      },
//                                    ),
//                                  );
//                                },
//                              ),
//                            ),
//                          ],
//                        ),
//                ),
//              ),
            ],
          ),
        ),
      ),
    );
  }
}

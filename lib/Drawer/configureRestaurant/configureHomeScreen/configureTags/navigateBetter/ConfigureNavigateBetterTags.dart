import 'package:adhara_socket_io_example/Drawer/configureRestaurant/configureHomeScreen/configureTags/navigateBetter/addBarItemToTags.dart';
import 'package:adhara_socket_io_example/Drawer/configureRestaurant/configureHomeScreen/configureTags/navigateBetter/addFoodItemToTags.dart';
import 'package:adhara_socket_io_example/data.dart';
import 'package:adhara_socket_io_example/fetchData/configureRestaurantData.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class ConfigureNavigateBetterTags extends StatefulWidget {
//  final Restaurant restaurant;
//  final updateConfigDetailsToCloud;
//
//  ConfigureNavigateBetterTags({
//    @required this.restaurant,
//    this.updateConfigDetailsToCloud,
//  });

  @override
  _ConfigureNavigateBetterTagsState createState() =>
      _ConfigureNavigateBetterTagsState();
}

class _ConfigureNavigateBetterTagsState
    extends State<ConfigureNavigateBetterTags> {
  final tagController = TextEditingController();
//  List<MenuFoodItem> barItems = [];
//
//  List<MenuFoodItem> foodItems = [];
  String radioItem = 'foodMenu';

  List<MenuFoodItem> selectedTagItems = [];
  int _selectedIndex;

  String selectedTag;

  _onSelected(int index, restaurantData) {
    setState(() {
      _selectedIndex = index;

      selectedTag = restaurantData.restaurant.navigateBetterTags[index];
    });
  }

  getTagItems(selectedTag, restaurantData) {
    setState(() {
//      barItems.clear();
//      foodItems.clear();
      selectedTagItems.clear();
      restaurantData.restaurant.barMenu.forEach((category) {
        category.foodList.forEach((food) {
          if (food.tags.isNotEmpty) {
            food.tags.forEach((tag) {
              if (tag == selectedTag) {
                selectedTagItems.add(food);
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
                selectedTagItems.add(food);
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
          title: Text('Configure Navigate Better'),
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
                          itemCount:
                              restaurantData.restaurant.navigateBetterTags !=
                                      null
                                  ? restaurantData
                                      .restaurant.navigateBetterTags.length
                                  : 0,
                          itemBuilder: (context, index) {
                            return Container(
                              color: _selectedIndex != null &&
                                      _selectedIndex == index
                                  ? Colors.tealAccent
                                  : Colors.transparent,
                              child: ListTile(
                                title: Text(restaurantData
                                    .restaurant.navigateBetterTags[index]),
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
                                                "Delete ${restaurantData.restaurant.navigateBetterTags[index]} tag ?"),
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
                                                              "navigate_better",
                                                          "tag_name": restaurantData
                                                                  .restaurant
                                                                  .navigateBetterTags[
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
                                          .restaurant.navigateBetterTags[index],
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
              Expanded(
                child: Container(
                  color: Colors.yellow,
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: <Widget>[
                      Container(
                        padding: EdgeInsets.symmetric(vertical: 10),
                        child: ListTile(
                          title: selectedTag != null
                              ? Text('Add New Item to $selectedTag')
                              : Text('Select Tag to Add Items'),
                          onTap: () {
                            showDialog(
                              barrierDismissible: false,
                              context: context,
                              builder: (BuildContext context) {
                                // return object of type Dialog
                                return AddFoodItemToTags(
                                  selectedTag: selectedTag,
//                                  restaurant: widget.restaurant,
                                );
                              },
                            );
                          },
                        ),
                      ),
                      Expanded(
                        child: Column(
                          children: <Widget>[
                            Row(
                              crossAxisAlignment: CrossAxisAlignment.start,
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
                            selectedTag != null
                                ? FlatButton(
                                    child: Text("add Item"),
                                    onPressed: () {
                                      showDialog(
                                        barrierDismissible: false,
                                        context: context,
                                        builder: (BuildContext context) {
                                          // return object of type Dialog
                                          return radioItem == "barMenu"
                                              ? AddBarItemToTags(
//                                                      restaurant:
//                                                          widget.restaurant,
                                                  selectedTag: selectedTag)
                                              : AddFoodItemToTags(
//                                                  restaurant: widget.restaurant,
                                                  selectedTag: selectedTag);
                                        },
                                      );
                                    })
                                : Text(""),
                          ],
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
                  restaurantData.sendConfiguredDataToBackend({
                    "add_to": "navigate_better",
                    "tag_name": tagController.text
                  }, "add_home_screen_tags");

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

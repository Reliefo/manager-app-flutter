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
  ////////////for reorder list
  List<MenuFoodItem> newItemList = [];
  List<String> idList = [];
  Function sendConfiguredDataToBackend;
  bool reorder = false;
//////////////////////////////////////////
  final tagController = TextEditingController();
  List<MenuFoodItem> barItems = [];

  List<MenuFoodItem> foodItems = [];
  int _selectedIndex;

  Tags selectedTag;

  String radioItem = 'foodMenu';

  List<MenuFoodItem> selectedTagItems = [];

  getTagItems(selectedTag, restaurantData) {
//    print("get tags called");
    setState(() {
      selectedTagItems.clear();

      restaurantData.restaurant.barMenu?.forEach((category) {
        category?.foodList?.forEach((food) {
          if (food.tags != null) {
            if (food.tags.isNotEmpty) {
              food.tags.forEach((tag) {
                if (tag == selectedTag) {
                  setState(() {
                    selectedTagItems.add(food);
                  });
                }
              });
            }
          }
        });
      });

      restaurantData.restaurant.foodMenu?.forEach((category) {
        category?.foodList?.forEach((food) {
          if (food.tags != null) {
            if (food.tags.isNotEmpty) {
              food.tags.forEach((tag) {
                if (tag == selectedTag) {
                  setState(() {
                    selectedTagItems.add(food);
                  });
                }
              });
            }
          }
        });
      });
    });
  }

  _onSelected(int index, restaurantData) {
    setState(() {
      _selectedIndex = index;

      selectedTag = restaurantData.restaurant.homeScreenTags[index];
    });
  }

  setInitialSelected(restaurantData) {
    if (restaurantData.restaurant.homeScreenTags != null &&
        restaurantData.restaurant.homeScreenTags.isNotEmpty) {
      if (_selectedIndex == null) {
        setState(() {
          _selectedIndex = 0;
          selectedTag = restaurantData.restaurant.homeScreenTags[0];
        });
      }
    }
  }

  Widget ReorderLayout(Tags selectedTag, restaurantData) {
    if (newItemList.isEmpty) {
      newItemList = List.from(selectedTag.foodList);
    }

    void _onReorder(int oldIndex, int newIndex) {
      setState(
        () {
          if (newIndex > oldIndex) {
            newIndex -= 1;
          }
          final MenuFoodItem changedItem = newItemList.removeAt(oldIndex);
          newItemList.insert(newIndex, changedItem);
        },
      );
    }

    Widget itemView(index, item) {
      return ListTile(
        contentPadding: EdgeInsets.all(12),
        key: Key(item.oid),
        leading: Icon(Icons.drag_handle),
        title: Text(index.toString() + " .  " + item.name, style: kTitleStyle),
      );
    }

    Future<bool> _onBackPressed() {
      return showDialog(
              context: context,
              builder: (context) {
                return AlertDialog(
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(20),
                  ),
                  title: new Text('Changes not saved'),
                  content: Column(
                    mainAxisSize: MainAxisSize.min,
                    children: <Widget>[
                      Text('Do you want to Save the changes.?'),
                      SizedBox(height: 24),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceAround,
                        children: <Widget>[
                          FlatButton(
                            child: Text(
                              "Don't Save",
                              style: TextStyle(
                                  fontFamily: "Poppins", color: Colors.red),
                            ),
                            onPressed: () {
                              Navigator.of(context).pop(false);

                              setState(() {
                                reorder = false;
                                newItemList.clear();
                              }); // To close the dialog
                            },
                          ),
                          FlatButton(
                            child: Text(
                              "Save Changes",
                              style: TextStyle(
                                  fontFamily: "Poppins", color: Colors.green),
                            ),
                            onPressed: () {
                              newItemList.forEach((element) {
                                idList.add(element.oid);
                              });

                              Map<String, dynamic> localData = {
                                "home_screen_lists_id": selectedTag.oid,
                                "food_id_list": idList
                              };

                              restaurantData.sendConfiguredDataToBackend(
                                  localData, "reorder_home_screen_tags");
                              Navigator.of(context).pop(false);
                              setState(() {
                                reorder = false;
                                newItemList.clear();
                                idList.clear();
                              });
                            },
                          ),
                        ],
                      )
                    ],
                  ),
                );
              }) ??
          false;
    }

    return WillPopScope(
      onWillPop: _onBackPressed,
      child: Scaffold(
        body: Container(
          child: ReorderableListView(
            children: newItemList.map((item) {
              var index = newItemList.indexOf(item);
              return itemView(index + 1, item);
            }).toList(),
            onReorder: _onReorder,
          ),
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final RestaurantData restaurantData = Provider.of<RestaurantData>(context);
//    getTagItems(selectedTag, restaurantData);
    setInitialSelected(restaurantData);
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
                            title: Text(
                              'Add New Tag',
                              style: kHeaderStyleSmall,
                            ),
                            trailing: Icon(
                              Icons.add,
                              color: Colors.black,
                              size: 30,
                            ),
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
                      Divider(
                        thickness: 2,
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
                                title: Text(
                                    restaurantData
                                        .restaurant.homeScreenTags[index].name,
                                    style: kTitleStyle),
                                trailing: IconButton(
                                    icon: Icon(
                                      Icons.close,
                                      color: Colors.red,
                                    ),
                                    onPressed: () {
                                      showDialog(
                                        barrierDismissible: false,
                                        context: context,
                                        builder: (BuildContext context) {
                                          return AlertDialog(
                                            shape: RoundedRectangleBorder(
                                              borderRadius:
                                                  BorderRadius.circular(20),
                                            ),
                                            title: Text(
                                                "Delete ${restaurantData.restaurant.homeScreenTags[index].name} tag ?"),
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
                                                          "home_screen_lists_id":
                                                              restaurantData
                                                                  .restaurant
                                                                  .homeScreenTags[
                                                                      index]
                                                                  .oid
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
//              VerticalDivider(
//                thickness: 2,
//                indent: 12,
//              ),
              selectedTag != null
                  ? Expanded(
                      flex: 2,
                      child: Row(
                        children: <Widget>[
                          reorder == false
                              ? Expanded(
                                  child: Container(
                                    color: Colors.white,
                                    child: Column(
                                      children: <Widget>[
                                        Container(
                                          padding: EdgeInsets.symmetric(
                                              vertical: 10),
                                          child: ListTile(
                                            title: Row(
                                              children: <Widget>[
                                                Expanded(
                                                  child: Text(
                                                    'Items in ${selectedTag.name}',
                                                    style: kHeaderStyleSmall,
                                                  ),
                                                ),
                                                FlatButton(
                                                  child: Text('Reorder'),
                                                  onPressed: () {
                                                    setState(() {
                                                      reorder = true;
                                                    });
                                                  },
                                                ),
                                              ],
                                            ),
                                          ),
                                        ),
                                        Expanded(
                                          child: ListView.builder(
                                            shrinkWrap: true,
                                            itemCount:
                                                selectedTag.foodList.length,
                                            itemBuilder: (context, index) {
                                              return ListTile(
                                                title: Text(
                                                  selectedTag
                                                      .foodList[index].name,
                                                  style: kTitleStyle,
                                                ),
                                                trailing: IconButton(
                                                  icon: Icon(Icons.cancel),
                                                  onPressed: () {
                                                    restaurantData
                                                        .sendConfiguredDataToBackend({
                                                      "food_id": selectedTag
                                                          .foodList[index].oid,
                                                      "home_screen_lists_id":
                                                          selectedTag.oid,
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
                                )
                              : Expanded(
                                  child: ReorderLayout(
                                      selectedTag, restaurantData),
                                ),
                          VerticalDivider(
                            thickness: 2,
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
                                      title: Text(
                                        'Add New Item to ${selectedTag.name}',
                                        style: kHeaderStyleSmall,
                                      ),
                                    ),
                                  ),
                                  Expanded(
                                    child: SingleChildScrollView(
                                      child: Column(
                                        children: <Widget>[
                                          Row(
                                            crossAxisAlignment:
                                                CrossAxisAlignment.start,
                                            children: <Widget>[
                                              Expanded(
                                                child: RadioListTile(
                                                  groupValue: radioItem,
                                                  title: Text('Food Menu',
                                                      style: kTitleStyle),
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
                                                  title: Text('Bar Menu',
                                                      style: kTitleStyle),
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
                                                  getTagItems: getTagItems,
                                                  selectedTagId:
                                                      selectedTag.oid,
                                                )
                                              : AddFoodItemToTags(
                                                  getTagItems: getTagItems,
                                                  selectedTagId:
                                                      selectedTag.oid,
                                                ),
                                        ],
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ),
                        ],
                      ),
                    )
                  : Expanded(
                      flex: 2,
                      child: Center(
                        child: Text(
                          "Select Tag from the list to view and edit.!",
                          style: kHeaderStyleSmall,
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

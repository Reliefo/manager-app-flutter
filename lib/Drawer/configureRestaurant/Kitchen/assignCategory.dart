import 'package:flutter/material.dart';
import 'package:manager_app/constants.dart';
import 'package:manager_app/data.dart';
import 'package:manager_app/fetchData/configureRestaurantData.dart';
import 'package:provider/provider.dart';

class AssignCategory extends StatefulWidget {
  final Kitchen kitchen;
  AssignCategory({
    this.kitchen,
  });
  @override
  _AssignCategoryState createState() => _AssignCategoryState();
}

class _AssignCategoryState extends State<AssignCategory> {
  List<Category> availableCategories = [];

  Map<String, bool> availableCategoriesValues = {};

  getAvailableCategories(restaurantData) {
    availableCategories.clear();
    availableCategoriesValues.clear();

    restaurantData.restaurant.foodMenu?.forEach((category) {
      availableCategories.add(category);
      availableCategoriesValues["${category.oid}"] = false;
    });

    restaurantData.restaurant.barMenu?.forEach((category) {
      availableCategories.add(category);
      availableCategoriesValues["${category.oid}"] = false;
    });

    restaurantData.restaurant.kitchens?.forEach((kitchen) {
      kitchen.categoriesList?.forEach((category) {
        setState(() {
          availableCategories
              .removeWhere((selected) => selected.oid == category.oid);

          availableCategoriesValues.remove(category.oid);
        });
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    final RestaurantData restaurantData = Provider.of<RestaurantData>(context);
    getAvailableCategories(restaurantData);

    return Container(
      color: Colors.white,
      margin: EdgeInsets.only(right: 12, top: 12),
      child: Column(
        children: <Widget>[
          Container(
            padding: EdgeInsets.symmetric(vertical: 10),
            child: ListTile(
              title: Text(
                'Assign New Category to kitchen',
                style: kHeaderStyleSmall,
              ),
              trailing: Icon(Icons.add),
              onTap: () {
                showDialog(
                  barrierDismissible: false,
                  context: context,
                  builder: (BuildContext context) {
                    // return object of type Dialog
                    return CategoryPopUp(
                      kitchenId: widget.kitchen.oid,
                      availableCategories: availableCategories,
                      availableCategoriesValues: availableCategoriesValues,
                    );
                  },
                );
              },
            ),
          ),
          Expanded(
            child: widget.kitchen.categoriesList != null
                ? ListView.builder(
                    shrinkWrap: true,
                    itemCount: widget.kitchen.categoriesList.length,
                    itemBuilder: (context, index) {
                      return ListTile(
                        title: Text(
                          widget.kitchen.categoriesList[index].name,
                          style: kTitleStyle,
                        ),
                        trailing: IconButton(
                          icon: Icon(Icons.cancel),
                          onPressed: () {
                            restaurantData.sendConfiguredDataToBackend(
                              {
                                "kitchen_id": widget.kitchen.oid,
                                "category_id":
                                    widget.kitchen.categoriesList[index].oid
                              },
                              "decategory_kitchen",
                            );
                          },
                        ),
                      );
                    },
                  )
                : Center(
                    child: Text(
                      "No Category Assigned.!",
                      style: kHeaderStyleSmall,
                    ),
                  ),
          )
        ],
      ),
    );
  }
}

class CategoryPopUp extends StatefulWidget {
  const CategoryPopUp({
    Key key,
    @required this.availableCategories,
    @required this.availableCategoriesValues,
    @required this.kitchenId,
  }) : super(key: key);

  final List<Category> availableCategories;
  final Map<String, bool> availableCategoriesValues;
  final String kitchenId;

  @override
  _CategoryPopUpState createState() => _CategoryPopUpState();
}

class _CategoryPopUpState extends State<CategoryPopUp> {
  List<String> selected = [];

  selectedCategory() {
    widget.availableCategoriesValues.forEach((category, boo) {
      if (boo == true) {
        selected.add(category);
      }
    });
    print(selected);
  }

  @override
  Widget build(BuildContext context) {
    final RestaurantData restaurantData = Provider.of<RestaurantData>(context);
    return AlertDialog(
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(20),
      ),
      title: Text(
        "Select Category",
        style: kHeaderStyleSmall,
      ),
      content: Column(
        mainAxisSize: MainAxisSize.min, // To make the card compact
        children: <Widget>[
          Container(
            width: 350,
            height: 350,
            child: ListView.builder(
                shrinkWrap: true,
                itemCount: widget.availableCategories.length,
                itemBuilder: (context, index) {
                  return CheckboxListTile(
                      title: Text(
                        widget.availableCategories[index].name,
                        textAlign: TextAlign.left,
                        style: kTitleStyle,
                      ),
                      value: widget.availableCategoriesValues[
                          "${widget.availableCategories[index].oid}"],
                      onChanged: (bool val) {
                        setState(() {
                          widget.availableCategoriesValues[
                              "${widget.availableCategories[index].oid}"] = val;
                        });
                      });
                }),
          ),
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
                  selectedCategory();
                  if (selected.isNotEmpty) {
                    restaurantData.sendConfiguredDataToBackend(
                      {"kitchen_id": widget.kitchenId, "categories": selected},
                      "category_kitchen",
                    );
                  }

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

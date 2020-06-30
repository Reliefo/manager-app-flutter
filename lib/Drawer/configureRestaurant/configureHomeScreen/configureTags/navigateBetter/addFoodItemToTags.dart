import 'package:flutter/material.dart';
import 'package:manager_app/data.dart';
import 'package:manager_app/fetchData/configureRestaurantData.dart';
import 'package:provider/provider.dart';

class AddFoodItemToTags extends StatefulWidget {
  const AddFoodItemToTags({
    Key key,
    @required this.selectedTagId,
    this.getTagItems,
  }) : super(key: key);

  final String selectedTagId;
  final Function getTagItems;

  @override
  _AddFoodItemToTagsState createState() => _AddFoodItemToTagsState();
}

class _AddFoodItemToTagsState extends State<AddFoodItemToTags> {
  Category _selectedFoodCategory;
  MenuFoodItem _selectedFoodItem;
  List<MenuFoodItem> displayItems = [];

  getItems(restaurantData, {MenuFoodItem previouslySelected}) {
    List<MenuFoodItem> toDelete = [];

    displayItems.clear();

    if (previouslySelected != null) toDelete.add(previouslySelected);

    displayItems = List.from(_selectedFoodCategory.foodList);

    restaurantData.restaurant.homeScreenTags?.forEach((tag) {
      if (tag.oid == widget.selectedTagId) {
        tag.foodList?.forEach((food) {
          toDelete.add(food);
        });
      }
    });

    restaurantData.restaurant.navigateBetterTags?.forEach((tag) {
      if (tag.oid == widget.selectedTagId) {
        tag.foodList?.forEach((food) {
          toDelete.add(food);
        });
      }
    });

    toDelete?.forEach((food) {
      displayItems?.removeWhere((element) => element == food);
    });
  }

  @override
  Widget build(BuildContext context) {
    final RestaurantData restaurantData = Provider.of<RestaurantData>(context);

    return Column(
      mainAxisSize: MainAxisSize.min,
      children: <Widget>[
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16.0),
          child: DropdownButton(
            value: _selectedFoodCategory,
            items: restaurantData.restaurant.foodMenu != null
                ? restaurantData.restaurant.foodMenu.map((category) {
                    return DropdownMenuItem(
                      value: category,
                      child: Text(category.name),
                    );
                  }).toList()
                : [],
            hint: Text('Select Food Category'),
            isExpanded: true,
            onChanged: (selected) {
              setState(() {
                //print(selected);

                _selectedFoodCategory = selected;
                _selectedFoodItem = null;
              });
              getItems(restaurantData);
            },
          ),
        ),
        SizedBox(height: 20.0),
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16.0),
          child: DropdownButton(
            value: _selectedFoodItem,
            items: displayItems != null
                ? displayItems.map((item) {
                    return DropdownMenuItem(
                      value: item,
                      child: Text(item.name),
                    );
                  }).toList()
                : [],
            hint: Text('Select Food Item'),
            isExpanded: true,
            onChanged: (selected) {
              setState(() {
                //print(selected);
                _selectedFoodItem = selected;
              });
              getItems(restaurantData);
            },
          ),
        ),
        SizedBox(height: 24.0),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: <Widget>[
            FlatButton(
              child: Text(
                "Add Item",
                style: TextStyle(color: Colors.green),
              ),
              onPressed: () {
                restaurantData.sendConfiguredDataToBackend({
                  "food_id": _selectedFoodItem.oid,
                  "home_screen_lists_id": widget.selectedTagId,
                }, "attach_home_screen_tags");

                widget.getTagItems(widget.selectedTagId, restaurantData);

                setState(() {
//                  _selectedFoodCategory = null;
                  getItems(restaurantData,
                      previouslySelected: _selectedFoodItem);
                  _selectedFoodItem = null;
                });
              },
            ),
          ],
        )
      ],
    );
  }
}

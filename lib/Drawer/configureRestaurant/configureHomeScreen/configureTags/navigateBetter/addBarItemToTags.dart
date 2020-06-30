import 'package:flutter/material.dart';
import 'package:manager_app/data.dart';
import 'package:manager_app/fetchData/configureRestaurantData.dart';
import 'package:provider/provider.dart';

class AddBarItemToTags extends StatefulWidget {
  const AddBarItemToTags({
    Key key,
    @required this.selectedTagId,
    this.getTagItems,
  }) : super(key: key);

  final String selectedTagId;
  final Function getTagItems;

  @override
  _AddBarItemToTagsState createState() => _AddBarItemToTagsState();
}

class _AddBarItemToTagsState extends State<AddBarItemToTags> {
  Category _selectedBarCategory;
  MenuFoodItem _selectedBarItem;
  List<MenuFoodItem> displayItems = [];

  getItems(restaurantData, {MenuFoodItem previouslySelected}) {
    List<MenuFoodItem> toDelete = [];

    displayItems.clear();
    if (previouslySelected != null) toDelete.add(previouslySelected);
    displayItems = List.from(_selectedBarCategory.foodList);
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
    toDelete.forEach((food) {
      displayItems.removeWhere((element) => element == food);
    });
  }

  @override
  Widget build(BuildContext context) {
    print("add bar item");
    print(_selectedBarCategory);
    final RestaurantData restaurantData = Provider.of<RestaurantData>(context);
    return Column(
      mainAxisSize: MainAxisSize.min, // To make the card compact
      children: <Widget>[
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16.0),
          child: DropdownButton(
            value: _selectedBarCategory,
            items: restaurantData.restaurant.barMenu != null
                ? restaurantData.restaurant.barMenu.map((category) {
                    return DropdownMenuItem(
                      value: category,
                      child: Text(category.name),
                    );
                  }).toList()
                : [],
            hint: Text('Select Bar Category'),
            isExpanded: true,
            onChanged: (selected) {
              setState(() {
//                print(selected);
                _selectedBarCategory = selected;
                _selectedBarItem = null;
              });
              getItems(restaurantData);
            },
          ),
        ),
        SizedBox(height: 20.0),
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16.0),
          child: DropdownButton(
            value: _selectedBarItem,
            items: displayItems != null
                ? displayItems.map((item) {
                    return DropdownMenuItem(
                      value: item,
                      child: Text(item.name),
                    );
                  }).toList()
                : [],
            hint: Text('Select Bar Item'),
            isExpanded: true,
            onChanged: (selected) {
              setState(() {
//                print(selected);
                _selectedBarItem = selected;
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
                  "food_id": _selectedBarItem.oid,
                  "home_screen_lists_id": widget.selectedTagId,
                }, "attach_home_screen_tags");
                widget.getTagItems(widget.selectedTagId, restaurantData);
                setState(() {
//                  _selectedBarCategory = null;
                  getItems(restaurantData,
                      previouslySelected: _selectedBarItem);
                  _selectedBarItem = null;
                });
              },
            ),
          ],
        )
      ],
    );
  }
}

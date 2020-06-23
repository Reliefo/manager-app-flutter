import 'package:flutter/material.dart';
import 'package:manager_app/data.dart';
import 'package:manager_app/fetchData/configureRestaurantData.dart';
import 'package:provider/provider.dart';

class AddFoodItemToTags extends StatefulWidget {
  const AddFoodItemToTags({
    Key key,
    @required this.selectedTag,
    this.getTagItems,
  }) : super(key: key);

  final String selectedTag;
  final Function getTagItems;

  @override
  _AddFoodItemToTagsState createState() => _AddFoodItemToTagsState();
}

class _AddFoodItemToTagsState extends State<AddFoodItemToTags> {
  Category _selectedFoodCategory;

  MenuFoodItem _selectedFoodItem;

  List<MenuFoodItem> displayItems = [];

  getItems() {
    //print("get items");
    List<MenuFoodItem> toDelete = [];

    displayItems.clear();

    _selectedFoodCategory?.foodList?.forEach((foodItem) {
      //print("get items 1");

      displayItems.add(foodItem);
      foodItem.tags?.forEach((tag) {
        //print("get items 2");

        if (tag == widget.selectedTag) {
          toDelete.add(foodItem);
        }
      });
    });

    toDelete?.forEach((food) {
      //print("get items 3");

      displayItems?.removeWhere((element) => element == food);
      //print("get items 4");
    });
    //print("get items ....");
  }

  @override
  Widget build(BuildContext context) {
    final RestaurantData restaurantData = Provider.of<RestaurantData>(context);
    return Column(
      mainAxisSize: MainAxisSize.min, // To make the card compact
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
              });
              getItems();
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
              getItems();
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
                  "tag_name": widget.selectedTag,
                }, "attach_home_screen_tags");

                widget.getTagItems(widget.selectedTag, restaurantData);

                setState(() {
                  _selectedFoodCategory = null;
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

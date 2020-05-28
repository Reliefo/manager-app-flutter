import 'package:flutter/material.dart';
import 'package:manager_app/data.dart';
import 'package:manager_app/fetchData/configureRestaurantData.dart';
import 'package:provider/provider.dart';

class AddFoodItemToTags extends StatefulWidget {
  const AddFoodItemToTags({
    Key key,
//    @required this.restaurant,
    @required this.selectedTag,
  }) : super(key: key);

//  final Restaurant restaurant;
  final String selectedTag;

  @override
  _AddFoodItemToTagsState createState() => _AddFoodItemToTagsState();
}

class _AddFoodItemToTagsState extends State<AddFoodItemToTags> {
  Category _selectedFoodCategory;

  MenuFoodItem _selectedFoodItem;

  List<MenuFoodItem> displayItems = [];

  getItems() {
    List<MenuFoodItem> toDelete = [];

    displayItems.clear();

    _selectedFoodCategory.foodList.forEach((foodItem) {
      displayItems.add(foodItem);
      foodItem.tags.forEach((tag) {
        if (tag == widget.selectedTag) {
          toDelete.add(foodItem);
        }
      });
    });

    toDelete.forEach((food) {
      displayItems.removeWhere((element) => element == food);
    });
  }

  @override
  Widget build(BuildContext context) {
    final RestaurantData restaurantData = Provider.of<RestaurantData>(context);
    return Column(
      mainAxisSize: MainAxisSize.min, // To make the card compact
      children: <Widget>[
//        Text(
//          "Add item to: ${widget.selectedTag}",
//          textAlign: TextAlign.center,
//          style: TextStyle(
//            fontSize: 16.0,
//          ),
//        ),
        DropdownButton(
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
              print(selected);

              _selectedFoodCategory = selected;
            });
            getItems();
          },
        ),
        SizedBox(height: 20.0),
        DropdownButton(
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
              print(selected);
              _selectedFoodItem = selected;
            });
          },
        ),
        SizedBox(height: 24.0),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: <Widget>[
//              FlatButton(
//                child: Text(
//                  "Cancel",
//                  style: TextStyle(color: Colors.red),
//                ),
//                onPressed: () {
//                  Navigator.of(context).pop(); // To close the dialog
//                },
//              ),
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

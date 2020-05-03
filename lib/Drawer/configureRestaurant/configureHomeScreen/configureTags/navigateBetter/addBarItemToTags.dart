import 'package:adhara_socket_io_example/data.dart';
import 'package:adhara_socket_io_example/fetchData/configureRestaurantData.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class AddBarItemToTags extends StatefulWidget {
  const AddBarItemToTags({
    Key key,
    @required this.selectedTag,
  }) : super(key: key);

  final String selectedTag;

  @override
  _AddBarItemToTagsState createState() => _AddBarItemToTagsState();
}

class _AddBarItemToTagsState extends State<AddBarItemToTags> {
  Category _selectedBarCategory;

  MenuFoodItem _selectedBarItem;

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
          Text(
            "Add item to: ${widget.selectedTag}",
            textAlign: TextAlign.center,
            style: TextStyle(
              fontSize: 16.0,
            ),
          ),
          DropdownButton(
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
                print(selected);

                _selectedBarCategory = selected;
                _selectedBarItem = _selectedBarCategory.foodList[0];
              });
            },
          ),
          SizedBox(height: 20.0),
          DropdownButton(
            value: _selectedBarItem,
            items: _selectedBarCategory != null
                ? _selectedBarCategory.foodList.map((item) {
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
                print(selected);
                _selectedBarItem = selected;
              });
            },
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
                  "Add Item",
                  style: TextStyle(color: Colors.green),
                ),
                onPressed: () {
                  restaurantData.sendConfiguredDataToBackend({
                    "food_id": _selectedBarItem.oid,
                    "tag_to_attach": widget.selectedTag,
                  }, "attach_home_screen_tags");

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

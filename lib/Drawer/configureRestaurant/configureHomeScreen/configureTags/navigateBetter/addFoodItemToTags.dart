import 'package:adhara_socket_io_example/data.dart';
import 'package:flutter/material.dart';

class AddFoodItemToTags extends StatefulWidget {
  const AddFoodItemToTags({
    Key key,
    @required this.restaurant,
    @required this.selectedTag,
  }) : super(key: key);

  final Restaurant restaurant;
  final String selectedTag;

  @override
  _AddFoodItemToTagsState createState() => _AddFoodItemToTagsState();
}

class _AddFoodItemToTagsState extends State<AddFoodItemToTags> {
  Category _selectedFoodCategory;

  MenuFoodItem _selectedFoodItem;

  setDropDownInitVal() {
    _selectedFoodCategory = widget.restaurant.foodMenu[0];
    _selectedFoodItem = _selectedFoodCategory.foodList[0];
  }

  @override
  void initState() {
    setDropDownInitVal();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
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
            value: _selectedFoodCategory,
            items: widget.restaurant.foodMenu != null
                ? widget.restaurant.foodMenu.map((category) {
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
                _selectedFoodItem = _selectedFoodCategory.foodList[0];
              });
            },
          ),
          SizedBox(height: 20.0),
          DropdownButton(
            value: _selectedFoodItem,
            items: _selectedFoodCategory != null
                ? _selectedFoodCategory.foodList.map((item) {
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

import 'package:flutter/material.dart';

class AddNewTag extends StatelessWidget {
  const AddNewTag({
    Key key,
    @required this.tagController,
    @required this.addTo,
    @required this.restaurantData,
  }) : super(key: key);

  final TextEditingController tagController;
  final String addTo;
  final restaurantData;

  @override
  Widget build(BuildContext context) {
//    final RestaurantData restaurantData = Provider.of<RestaurantData>(context);
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
                  keyboardType: TextInputType.text,
                  textCapitalization: TextCapitalization.sentences,
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
                  restaurantData.sendConfiguredDataToBackend(
                    {"add_to": addTo, "tag_name": tagController.text},
                    "add_home_screen_tags",
                  );
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

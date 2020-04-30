import 'package:adhara_socket_io_example/Drawer/configureRestaurant/addFoodItem/editItem.dart';
import 'package:adhara_socket_io_example/data.dart';
import 'package:flutter/material.dart';

class ViewItem extends StatelessWidget {
  final MenuFoodItem foodItem;
  final menuType;
  final updateConfigDetailsToCloud;
  ViewItem({
    this.foodItem,
    this.updateConfigDetailsToCloud,
    this.menuType,
  });
  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(20),
      ),
      content: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisSize: MainAxisSize.min,
        children: <Widget>[
          Text(
            "Item Name : ${foodItem.name}",
            textAlign: TextAlign.center,
            style: TextStyle(
              fontSize: 16.0,
            ),
          ),
          SizedBox(height: 20),

          Flexible(
            child: Text(
              "Description : ${foodItem.description}",
              textAlign: TextAlign.center,
              style: TextStyle(
                fontSize: 16.0,
              ),
            ),
          ),
          SizedBox(height: 20),
///////////////////////////////////////////////////////////////////// for options///////////////////////////

          foodItem.foodOption != null
              ? Center(
                  child: Container(
                    height: 100,
                    width: 300,
                    child: ListView.builder(
                        primary: false,
                        shrinkWrap: true,
                        itemCount: foodItem.foodOption.options != null
                            ? foodItem.foodOption.options.length
                            : 0,
                        itemBuilder: (context, index2) {
                          return Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: <Widget>[
                              Expanded(
                                child: Row(
                                  children: <Widget>[
                                    Text(
                                      "Option :  ${foodItem.foodOption.options[index2]["option_name"]} ",
                                      textAlign: TextAlign.center,
                                      style: TextStyle(
                                        fontSize: 16.0,
                                      ),
                                    ),
                                    SizedBox(width: 20),
                                    Text(
                                      "Price :  ${foodItem.foodOption.options[index2]["option_price"]} ",
                                      textAlign: TextAlign.center,
                                      style: TextStyle(
                                        fontSize: 16.0,
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                              SizedBox(width: 20),
                            ],
                          );
                        }),
                  ),
                )
              : Text(""),
///////////////////////////////////////////////////////////////for Choices////////////////////////////
          foodItem.foodOption != null
              ? Container(
                  height: 100,
                  width: 300,
                  child: ListView.builder(
                      primary: false,
                      shrinkWrap: true,
                      itemCount: foodItem.foodOption.choices != null
                          ? foodItem.foodOption.choices.length
                          : 0,
                      itemBuilder: (context, index2) {
                        return Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: <Widget>[
                            Expanded(
                              child: Row(
                                children: <Widget>[
                                  Text(
                                    "choice :${foodItem.foodOption.choices[index2]} ",
                                    textAlign: TextAlign.center,
                                    style: TextStyle(
                                      fontSize: 16.0,
                                    ),
                                  ),
                                ],
                              ),
                            ),
                            SizedBox(width: 20),
                          ],
                        );
                      }),
                )
              : Text(""),

          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: <Widget>[
              Text(
                "Price : ${foodItem.price}",
                textAlign: TextAlign.center,
                style: TextStyle(
                  fontSize: 16.0,
                ),
              ),
              SizedBox(width: 20),
            ],
          ),
          SizedBox(height: 24.0),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: <Widget>[
              FlatButton(
                onPressed: () {
                  Navigator.of(context).pop(); // To close the dialog
                },
                child: Text(
                  "Back",
                  style: TextStyle(color: Colors.red),
                ),
              ),
              FlatButton(
                child: Text(
                  "Edit",
                  style: TextStyle(color: Colors.green),
                ),
                onPressed: () {
                  Navigator.of(context).pop();
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => EditItem(
                        foodItem: foodItem,
                        updateConfigDetailsToCloud: updateConfigDetailsToCloud,
                        menuType: menuType,
                      ),
                    ),
                  );
                  // To close the dialog
                },
              ),
            ],
          )
        ],
      ),
    );
  }
}

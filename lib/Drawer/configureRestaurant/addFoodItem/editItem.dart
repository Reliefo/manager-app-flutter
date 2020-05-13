import 'package:flutter/material.dart';
import 'package:manager_app/data.dart';
import 'package:manager_app/fetchData/configureRestaurantData.dart';
import 'package:provider/provider.dart';

class EditItem extends StatefulWidget {
  final MenuFoodItem foodItem;

  final menuType;

  EditItem({
    this.foodItem,
    this.menuType,
  });
  @override
  _EditItemState createState() => _EditItemState();
}

class _EditItemState extends State<EditItem> {
  List<String> editChoices = [];
  List<Map<String, dynamic>> editOptions = [];
  final _itemNameEditController = TextEditingController();
  final _descriptionEditController = TextEditingController();
  final _priceEditController = TextEditingController();
  final _foodOptionEditController = TextEditingController();
  final _foodOptionPriceEditController = TextEditingController();
  final _foodChoiceEditController = TextEditingController();

  sendEditFields(restaurantData) {
    restaurantData.sendConfiguredDataToBackend({
      "food_id": widget.foodItem.oid,
      "category_type": widget.menuType,
      "food_dict": {
        "name": _itemNameEditController.text,
        "description": _descriptionEditController.text,
        "price": _priceEditController.text,
        "food_options": {
          "options": editOptions,
          "choices": editChoices,
        }
      },
    }, "edit_food_item");
  }

  addEditChoiceOption() {
    if (widget.foodItem.foodOption != null) {
      if (widget.foodItem.foodOption.options != null) {
        widget.foodItem.foodOption.options.forEach((option) {
          editOptions.add(option);
        });
      }
      if (widget.foodItem.foodOption.choices != null) {
        widget.foodItem.foodOption.choices.forEach((choice) {
          editChoices.add(choice);
        });
      }
    }
  }

  @override
  void initState() {
    addEditChoiceOption();
    // TODO: implement initState
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final RestaurantData restaurantData = Provider.of<RestaurantData>(context);

    _itemNameEditController.text = widget.foodItem.name;

    _descriptionEditController.text = widget.foodItem.description;

    _priceEditController.text = widget.foodItem.price;
    return SafeArea(
      child: Scaffold(
        body: SingleChildScrollView(
          child: Column(
            mainAxisSize: MainAxisSize.max,
            children: <Widget>[
              Row(
                children: <Widget>[
                  Text(
                    "Item Name : ",
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      fontSize: 16.0,
                    ),
                  ),
                  SizedBox(width: 20),
                  Container(
                    width: 200,
                    child: TextField(
                      controller: _itemNameEditController,
                      autofocus: true,
                    ),
                  ),
                ],
              ),
              SizedBox(height: 16.0),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: <Widget>[
                  Text(
                    "Description : ",
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      fontSize: 16.0,
                    ),
                  ),
                  SizedBox(width: 20),
                  Expanded(
                    child: TextField(
                      controller: _descriptionEditController,
                    ),
                  ),
                ],
              ),
              SizedBox(height: 16.0),

/////////////////////////////////////////////////////////////////// for options///////////////////////////
              widget.foodItem.foodOption != null
                  ? ListView.builder(
                      primary: false,
                      shrinkWrap: true,
                      itemCount: editOptions.length,
//                          ? widget.foodItem.foodOption.options.length
//                          : 0,
                      itemBuilder: (context, index) {
                        return Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: <Widget>[
                            Expanded(
                              child: Row(
                                children: <Widget>[
                                  Text(
                                    "option :${editOptions[index]["option_name"]} ",
                                    textAlign: TextAlign.center,
                                    style: TextStyle(
                                      fontSize: 16.0,
                                    ),
                                  ),
                                  SizedBox(width: 20),
                                  Text(
                                    "price :${editOptions[index]["option_price"]} ",
                                    textAlign: TextAlign.center,
                                    style: TextStyle(
                                      fontSize: 16.0,
                                    ),
                                  ),
                                  SizedBox(width: 20),
                                  IconButton(
                                    icon: Icon(Icons.edit),
                                    onPressed: () {
//

                                      _foodOptionEditController.text =
                                          editOptions[index]["option_name"];

                                      _foodOptionPriceEditController.text =
                                          editOptions[index]["option_price"];
                                      showDialog(
                                          barrierDismissible: false,
                                          context: context,
                                          builder: (BuildContext context) {
// return object of type Dialog
                                            return AlertDialog(
                                              shape: RoundedRectangleBorder(
                                                borderRadius:
                                                    BorderRadius.circular(20),
                                              ),
                                              content: Container(
                                                child: Column(
                                                  mainAxisSize:
                                                      MainAxisSize.min,
                                                  children: <Widget>[
                                                    Container(
                                                      width: 200,
                                                      child: TextField(
                                                        controller:
                                                            _foodOptionEditController,
                                                        autofocus: true,
                                                      ),
                                                    ),
                                                    Container(
                                                      width: 200,
                                                      child: TextField(
                                                        controller:
                                                            _foodOptionPriceEditController,
                                                      ),
                                                    ),
                                                    SizedBox(height: 24.0),
                                                    Row(
                                                      mainAxisAlignment:
                                                          MainAxisAlignment
                                                              .spaceAround,
                                                      children: <Widget>[
                                                        FlatButton(
                                                          onPressed: () {
                                                            Navigator.of(
                                                                    context)
                                                                .pop(); // To close the dialog
                                                          },
                                                          child: Text(
                                                            "Cancel",
                                                            style: TextStyle(
                                                                color:
                                                                    Colors.red),
                                                          ),
                                                        ),
                                                        FlatButton(
                                                          onPressed: () {
                                                            print(
                                                                "before done");
                                                            print(widget
                                                                .foodItem
                                                                .foodOption
                                                                .options);
                                                            setState(() {
                                                              editOptions[index]
                                                                      [
                                                                      "option_name"] =
                                                                  _foodOptionEditController
                                                                      .text;

                                                              editOptions[index]
                                                                      [
                                                                      "option_price"] =
                                                                  _foodOptionPriceEditController
                                                                      .text;
                                                            });
                                                            print("after done");
                                                            print(editOptions);

                                                            Navigator.of(
                                                                    context)
                                                                .pop(); // To close the dialog
                                                          },
                                                          child: Text(
                                                            "Done",
                                                            style: TextStyle(
                                                                color: Colors
                                                                    .green),
                                                          ),
                                                        ),
                                                      ],
                                                    )
                                                  ],
                                                ),
                                              ),
                                            );
                                          });
                                    },
                                  ),
                                ],
                              ),
                            ),
                            SizedBox(width: 20),
                          ],
                        );
                      })
                  : Text(""),
              SizedBox(height: 16.0),
/////////////////////////////////////////////////////////////for Choices////////////////////////////
              widget.foodItem.foodOption != null
                  ? ListView.builder(
                      primary: false,
                      shrinkWrap: true,
                      itemCount: editChoices.length,
//                  != null
//                          ? widget.foodItem.foodOption.choices.length
//                          : 0,
                      itemBuilder: (context, index2) {
                        return Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: <Widget>[
                            Expanded(
                              child: Row(
                                children: <Widget>[
                                  Text(
                                    "choice :${editChoices[index2]} ",
                                    textAlign: TextAlign.center,
                                    style: TextStyle(
                                      fontSize: 16.0,
                                    ),
                                  ),
                                  IconButton(
                                    icon: Icon(Icons.edit),
                                    onPressed: () {
                                      _foodChoiceEditController.text =
                                          editChoices[index2];

                                      showDialog(
                                          barrierDismissible: false,
                                          context: context,
                                          builder: (BuildContext context) {
                                            return AlertDialog(
                                              shape: RoundedRectangleBorder(
                                                borderRadius:
                                                    BorderRadius.circular(20),
                                              ),
                                              content: Container(
                                                child: Column(
                                                  mainAxisSize:
                                                      MainAxisSize.min,
                                                  children: <Widget>[
                                                    Container(
                                                      width: 200,
                                                      child: TextField(
                                                        controller:
                                                            _foodChoiceEditController,
                                                        autofocus: true,
                                                      ),
                                                    ),
                                                    SizedBox(height: 24.0),
                                                    Row(
                                                      mainAxisAlignment:
                                                          MainAxisAlignment
                                                              .spaceAround,
                                                      children: <Widget>[
                                                        FlatButton(
                                                          onPressed: () {
                                                            Navigator.of(
                                                                    context)
                                                                .pop(); // To close the dialog
                                                          },
                                                          child: Text(
                                                            "Cancel",
                                                            style: TextStyle(
                                                                color:
                                                                    Colors.red),
                                                          ),
                                                        ),
                                                        FlatButton(
                                                          onPressed: () {
                                                            setState(() {
                                                              editChoices[
                                                                      index2] =
                                                                  _foodChoiceEditController
                                                                      .text;
                                                            });

                                                            Navigator.of(
                                                                    context)
                                                                .pop(); // To close the dialog
                                                          },
                                                          child: Text(
                                                            "Done",
                                                            style: TextStyle(
                                                                color: Colors
                                                                    .green),
                                                          ),
                                                        ),
                                                      ],
                                                    )
                                                  ],
                                                ),
                                              ),
                                            );
                                          });
                                    },
                                  ),
                                ],
                              ),
                            ),
                            SizedBox(width: 20),
                          ],
                        );
                      })
                  : Text(""),
              SizedBox(height: 16.0),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: <Widget>[
                  Text(
                    "Price : ",
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      fontSize: 16.0,
                    ),
                  ),
                  SizedBox(width: 20),
                  Expanded(
                    child: TextField(
                      controller: _priceEditController,
                    ),
                  ),
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
                      "Cancel",
                      style: TextStyle(color: Colors.red),
                    ),
                  ),
                  FlatButton(
                    child: Text(
                      "Done",
                      style: TextStyle(color: Colors.green),
                    ),
                    onPressed: () {
                      //todo: send edited fields
                      sendEditFields(restaurantData);

                      Navigator.of(context).pop(); // To close the dialog
                    },
                  ),
                ],
              )
            ],
          ),
        ),
      ),
    );
  }
}

import 'package:flutter/material.dart';
import 'package:manager_app/Drawer/configureRestaurant/addFoodItem/addItem/choices.dart';
import 'package:manager_app/data.dart';
import 'package:manager_app/fetchData/configureRestaurantData.dart';
import 'package:provider/provider.dart';

class EditItem extends StatefulWidget {
  final MenuFoodItem foodItem;

  final menuType;

  EditItem({
    @required this.foodItem,
    @required this.menuType,
  });
  @override
  _EditItemState createState() => _EditItemState();
}

class _EditItemState extends State<EditItem> {
  List<String> editChoices = [];
  List<Map<String, dynamic>> editOptions = [];
  final itemNameEditController = TextEditingController();
  final descriptionEditController = TextEditingController();
  final priceEditController = TextEditingController();
  final foodOptionEditController = TextEditingController();
  final foodOptionPriceEditController = TextEditingController();
  final foodChoiceEditController = TextEditingController();

  sendEditFields(restaurantData) {
    restaurantData.sendConfiguredDataToBackend({
      "food_id": widget.foodItem.oid,
      "category_type": widget.menuType,
      "food_dict": {
        "name": itemNameEditController.text,
        "description": descriptionEditController.text,
        "price": priceEditController.text,
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

    itemNameEditController.text = widget.foodItem.name;

    descriptionEditController.text = widget.foodItem.description;

    priceEditController.text = widget.foodItem.price;
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
                      controller: itemNameEditController,
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
                      controller: descriptionEditController,
                    ),
                  ),
                ],
              ),
              SizedBox(height: 16.0),

/////////////////////////////////////////////////////////////////// for options///////////////////////////
              FlatButton(
                child: Text(
                  "+ New Option",
                  style: TextStyle(color: Colors.green),
                ),
                onPressed: () {},
              ),
              widget.foodItem.foodOption != null
                  ? ListView.builder(
                      primary: false,
                      shrinkWrap: true,
                      itemCount: editOptions.length,
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
                                      foodOptionEditController.text =
                                          editOptions[index]["option_name"];

                                      foodOptionPriceEditController.text =
                                          editOptions[index]["option_price"];
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
                                                            foodOptionEditController,
                                                        autofocus: true,
                                                      ),
                                                    ),
                                                    Container(
                                                      width: 200,
                                                      child: TextField(
                                                        controller:
                                                            foodOptionPriceEditController,
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
                                                                  foodOptionEditController
                                                                      .text;

                                                              editOptions[index]
                                                                      [
                                                                      "option_price"] =
                                                                  foodOptionPriceEditController
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
                                  SizedBox(width: 20),
                                  IconButton(
                                    icon: Icon(Icons.cancel),
                                    onPressed: () {
                                      //todo : remove choice

                                      showDialog(
                                          barrierDismissible: false,
                                          context: context,
                                          builder: (BuildContext context) {
                                            return AlertDialog(
                                              shape: RoundedRectangleBorder(
                                                borderRadius:
                                                    BorderRadius.circular(20),
                                              ),
                                              title: Text("Delete Option"),
                                              content: Container(
                                                child: Column(
                                                  mainAxisSize:
                                                      MainAxisSize.min,
                                                  children: <Widget>[
                                                    Container(
                                                      child: Text(
                                                          "Want to delete this option from food ?"),
                                                    ),
                                                    SizedBox(height: 24.0),
                                                    Row(
                                                      mainAxisAlignment:
                                                          MainAxisAlignment
                                                              .spaceAround,
                                                      children: <Widget>[
                                                        FlatButton(
                                                          child: Text(
                                                            "Delete",
                                                            style: TextStyle(
                                                                color:
                                                                    Colors.red),
                                                          ),
                                                          onPressed: () {
                                                            setState(() {
                                                              editOptions
                                                                  .removeAt(
                                                                      index);
                                                            });
                                                            Navigator.of(
                                                                    context)
                                                                .pop(); // To close the dialog
                                                          },
                                                        ),
                                                        FlatButton(
                                                          child: Text(
                                                            "Back",
                                                            style: TextStyle(
                                                              color:
                                                                  Colors.green,
                                                            ),
                                                          ),
                                                          onPressed: () {
                                                            Navigator.of(
                                                                    context)
                                                                .pop(); // To close the dialog
                                                          },
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
              FlatButton(
                child: Text(
                  "+ New Choice",
                  style: TextStyle(color: Colors.green),
                ),
                onPressed: () {},
              ),
              Choices(
                foodChoiceController: foodChoiceEditController,
                priceController: priceEditController,
                choices: editChoices,
              ),
              widget.foodItem.foodOption != null
                  ? ListView.builder(
                      primary: false,
                      shrinkWrap: true,
                      itemCount: editChoices.length,
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
                                  SizedBox(width: 20),
                                  IconButton(
                                    icon: Icon(Icons.edit),
                                    onPressed: () {
                                      foodChoiceEditController.text =
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
                                                            foodChoiceEditController,
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
                                                                  foodChoiceEditController
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
                                  SizedBox(width: 20),
                                  IconButton(
                                    icon: Icon(Icons.cancel),
                                    onPressed: () {
                                      //todo : remove choice

                                      showDialog(
                                          barrierDismissible: false,
                                          context: context,
                                          builder: (BuildContext context) {
                                            return AlertDialog(
                                              shape: RoundedRectangleBorder(
                                                borderRadius:
                                                    BorderRadius.circular(20),
                                              ),
                                              title: Text("Delete choice"),
                                              content: Container(
                                                child: Column(
                                                  mainAxisSize:
                                                      MainAxisSize.min,
                                                  children: <Widget>[
                                                    Container(
                                                      child: Text(
                                                          "Want to delete this choice from food ?"),
                                                    ),
                                                    SizedBox(height: 24.0),
                                                    Row(
                                                      mainAxisAlignment:
                                                          MainAxisAlignment
                                                              .spaceAround,
                                                      children: <Widget>[
                                                        FlatButton(
                                                          child: Text(
                                                            "Delete",
                                                            style: TextStyle(
                                                                color:
                                                                    Colors.red),
                                                          ),
                                                          onPressed: () {
                                                            setState(() {
                                                              editChoices
                                                                  .removeAt(
                                                                      index2);
                                                            });
                                                            Navigator.of(
                                                                    context)
                                                                .pop(); // To close the dialog
                                                          },
                                                        ),
                                                        FlatButton(
                                                          child: Text(
                                                            "Back",
                                                            style: TextStyle(
                                                              color:
                                                                  Colors.green,
                                                            ),
                                                          ),
                                                          onPressed: () {
                                                            Navigator.of(
                                                                    context)
                                                                .pop(); // To close the dialog
                                                          },
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
                      controller: priceEditController,
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

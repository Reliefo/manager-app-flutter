import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:manager_app/constants.dart';
import 'package:manager_app/data.dart';
import 'package:manager_app/fetchData/configureRestaurantData.dart';
import 'package:provider/provider.dart';

class ViewItem extends StatefulWidget {
  final menuType;
  final MenuFoodItem foodItem;
  ViewItem({
    this.menuType,
    this.foodItem,
  });

  @override
  _ViewItemState createState() => _ViewItemState();
}

class _ViewItemState extends State<ViewItem> {
  List<String> editChoices = [];
  List<Map<String, dynamic>> editOptions = [];
  final itemNameEditController = TextEditingController();
  final descriptionEditController = TextEditingController();
  final priceEditController = TextEditingController();
  final foodOptionEditController = TextEditingController();
  final foodOptionPriceEditController = TextEditingController();
  final foodChoiceEditController = TextEditingController();

  addEditChoiceOption() {
    print("addEditChoiceOption called");
    editChoices.clear();
    editOptions.clear();
    print("lists cleared");
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
    addEditChoiceOption();

    print("view item");
//    print(widget.foodItem.foodOption.options);
//    print(widget.foodItem.foodOption.choices);
//    print(editOptions);
//    print(editChoices);

    final RestaurantData restaurantData = Provider.of<RestaurantData>(context);
    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
          title: Text(widget.foodItem.name),
          backgroundColor: kThemeColor,
        ),
        body: Container(
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              Expanded(
                child: Container(
                  margin: EdgeInsets.symmetric(horizontal: 24, vertical: 12),
                  child: SingleChildScrollView(
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.start,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: <Widget>[
                        Container(
                          width: MediaQuery.of(context).size.width * 0.3,
                          height: MediaQuery.of(context).size.height * 0.3,
                          color: Colors.blue,
                        ),
                        Container(
                          padding: EdgeInsets.symmetric(
                              horizontal: 12, vertical: 12),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: <Widget>[
                              Row(
                                children: <Widget>[
                                  Text(
                                    "Item Name : ",
                                    textAlign: TextAlign.left,
                                    style: kHeaderStyleSmall,
                                  ),
                                  SizedBox(width: 24),
                                  IconButton(
                                    icon: Icon(Icons.edit),
                                    onPressed: () {
                                      editItemName(restaurantData);
                                    },
                                  ),
                                ],
                              ),
                              SizedBox(height: 12),
                              Container(
                                child: Text(
                                  widget.foodItem.name,
                                  textAlign: TextAlign.left,
                                  style: TextStyle(
                                    fontSize: 16.0,
                                    fontFamily: 'Poppins',
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),
                        Container(
                          padding: EdgeInsets.symmetric(
                              horizontal: 12, vertical: 12),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: <Widget>[
                              Row(
                                children: <Widget>[
                                  Text(
                                    "Description : ",
                                    textAlign: TextAlign.left,
                                    style: kHeaderStyleSmall,
                                  ),
                                  SizedBox(width: 24),
                                  IconButton(
                                    icon: Icon(Icons.edit),
                                    onPressed: () {
                                      editItemDescription(restaurantData);
                                    },
                                  ),
                                ],
                              ),
                              SizedBox(height: 12),
                              Text(
                                widget.foodItem.description,
                                textAlign: TextAlign.left,
                                style: TextStyle(
                                  fontSize: 16.0,
                                  fontFamily: 'Poppins',
                                ),
                              ),
                            ],
                          ),
                        ),
                        Container(
                          padding: EdgeInsets.symmetric(
                              horizontal: 12, vertical: 12),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: <Widget>[
                              Row(
                                children: <Widget>[
                                  Text(
                                    "Price : ",
                                    textAlign: TextAlign.left,
                                    style: kHeaderStyleSmall,
                                  ),
                                  SizedBox(width: 24),
                                  widget.foodItem.foodOption.options.isEmpty
                                      ? IconButton(
                                          icon: Icon(Icons.edit),
                                          onPressed: () {
                                            editItemPrice(restaurantData);
                                          },
                                        )
                                      : Container(),
                                ],
                              ),
                              SizedBox(height: 12),
                              Text(
                                widget.foodItem.price,
                                textAlign: TextAlign.left,
                                style: TextStyle(
                                  fontSize: 16.0,
                                  fontFamily: 'Poppins',
                                ),
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
              VerticalDivider(),
              Expanded(
                child: SingleChildScrollView(
                  child: Container(
                    margin: EdgeInsets.symmetric(horizontal: 24),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: <Widget>[
                        ///////////////////////////////////////////////////////////////////// for options///////////////////////////
                        Container(
                          padding: EdgeInsets.symmetric(
                              horizontal: 16, vertical: 12),
                          child: Row(
                            children: <Widget>[
                              Text(
                                "Options",
                                style: kHeaderStyle,
                              ),
                              SizedBox(
                                width: 20,
                              ),
                              IconButton(
                                icon: Icon(Icons.add),
                                onPressed: () {
                                  addNewFoodOptions(restaurantData);
                                },
                              ),
                            ],
                          ),
                        ),
                        widget.foodItem.foodOption != null
                            ? ListView.builder(
                                primary: false,
                                shrinkWrap: true,
                                itemCount: widget.foodItem.foodOption.options !=
                                        null
                                    ? widget.foodItem.foodOption.options.length
                                    : 0,
                                itemBuilder: (context, index2) {
                                  return ListTile(
                                    title: Text(
                                      widget.foodItem.foodOption.options[index2]
                                          ["option_name"],
                                      textAlign: TextAlign.left,
                                      style: TextStyle(
                                        fontFamily: 'Poppins',
                                        fontSize: 16.0,
                                      ),
                                    ),
                                    subtitle: Text(
                                      "Price :  ${widget.foodItem.foodOption.options[index2]["option_price"]} ",
                                      textAlign: TextAlign.left,
                                      style: TextStyle(
                                        fontSize: 16.0,
                                        fontFamily: 'Poppins',
                                      ),
                                    ),
                                    trailing: Row(
                                      mainAxisSize: MainAxisSize.min,
                                      children: <Widget>[
                                        IconButton(
                                          icon: Icon(Icons.edit),
                                          onPressed: () {
                                            editFoodItemOptions(
                                                restaurantData, index2);
                                          },
                                        ),
                                        IconButton(
                                          icon: Icon(Icons.cancel),
                                          onPressed: () {
                                            setState(() {
                                              editOptions.removeAt(index2);
                                            });

                                            restaurantData
                                                .sendConfiguredDataToBackend({
                                              "food_id": widget.foodItem.oid,
                                              "category_type": widget.menuType,
                                              "editing_fields": {
                                                "food_options": {
                                                  "options": editOptions,
                                                  "choices": editChoices
                                                }
                                              }
                                            }, "edit_food_item");
                                          },
                                        ),
                                      ],
                                    ),
                                  );
                                })
                            : Container(height: 0, width: 0),

                        ///////////////////////////////////////////////////////////////for Choices////////////////////////////
                        Container(
                          padding: EdgeInsets.symmetric(
                              horizontal: 16, vertical: 12),
                          child: Row(
                            children: <Widget>[
                              Text(
                                "Choices",
                                style: kHeaderStyle,
                              ),
                              SizedBox(
                                width: 20,
                              ),
                              IconButton(
                                icon: Icon(Icons.add),
                                onPressed: () {
                                  addNewFoodChoices(restaurantData);
                                },
                              ),
                            ],
                          ),
                        ),

                        widget.foodItem.foodOption != null
                            ? ListView.builder(
                                primary: false,
                                shrinkWrap: true,
                                itemCount: widget.foodItem.foodOption.choices !=
                                        null
                                    ? widget.foodItem.foodOption.choices.length
                                    : 0,
                                itemBuilder: (context, index2) {
                                  return ListTile(
                                    title: Text(
                                      "choice :${widget.foodItem.foodOption.choices[index2]} ",
                                      textAlign: TextAlign.left,
                                      style: TextStyle(
                                        fontSize: 16.0,
                                        fontFamily: 'Poppins',
                                      ),
                                    ),
                                    trailing: Row(
                                      mainAxisSize: MainAxisSize.min,
                                      children: <Widget>[
                                        IconButton(
                                          icon: Icon(Icons.edit),
                                          onPressed: () {
                                            editFoodItemChoices(
                                                restaurantData, index2);
                                          },
                                        ),
                                        IconButton(
                                          icon: Icon(Icons.cancel),
                                          onPressed: () {
                                            setState(() {
                                              editChoices.removeAt(index2);
                                            });

                                            restaurantData
                                                .sendConfiguredDataToBackend({
                                              "food_id": widget.foodItem.oid,
                                              "category_type": widget.menuType,
                                              "editing_fields": {
                                                "food_options": {
                                                  "options": editOptions,
                                                  "choices": editChoices
                                                }
                                              }
                                            }, "edit_food_item");
                                          },
                                        ),
                                      ],
                                    ),
                                  );
                                })
                            : Text(""),
                      ],
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget editItemName(restaurantData) {
    itemNameEditController.text = widget.foodItem.name;

    showDialog(
      barrierDismissible: false,
      context: context,
      builder: (BuildContext context) {
        // return object of type Dialog
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
                    "Item Name : ",
                    textAlign: TextAlign.center,
                    style: kTitleStyle,
                  ),
                  SizedBox(width: 20),
                  Container(
                    width: 200,
                    child: TextField(
                      controller: itemNameEditController,
                      textCapitalization: TextCapitalization.words,
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
                      style:
                          TextStyle(fontFamily: "Poppins", color: Colors.red),
                    ),
                    onPressed: () {
                      Navigator.of(context).pop(); // To close the dialog
                    },
                  ),
                  FlatButton(
                    child: Text(
                      "Done",
                      style:
                          TextStyle(fontFamily: "Poppins", color: Colors.green),
                    ),
                    onPressed: () {
                      if (itemNameEditController.text.isNotEmpty) {
                        restaurantData.sendConfiguredDataToBackend({
                          "food_id": widget.foodItem.oid,
                          "category_type": widget.menuType,
                          "editing_fields": {
                            "name": itemNameEditController.text,
                          },
                        }, "edit_food_item");
                      }
                      Navigator.of(context).pop(); // To close the dialog
                    },
                  ),
                ],
              )
            ],
          ),
        );
      },
    );
  }

  Widget editItemDescription(restaurantData) {
    descriptionEditController.text = widget.foodItem.description;

    showDialog(
      barrierDismissible: false,
      context: context,
      builder: (BuildContext context) {
        // return object of type Dialog
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
                    "Description : ",
                    textAlign: TextAlign.center,
                    style: kTitleStyle,
                  ),
                  SizedBox(width: 20),
                  Container(
                    width: 200,
                    child: TextField(
                      controller: descriptionEditController,
                      textCapitalization: TextCapitalization.words,
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
                      style:
                          TextStyle(fontFamily: "Poppins", color: Colors.red),
                    ),
                    onPressed: () {
                      Navigator.of(context).pop(); // To close the dialog
                    },
                  ),
                  FlatButton(
                    child: Text(
                      "Done",
                      style:
                          TextStyle(fontFamily: "Poppins", color: Colors.green),
                    ),
                    onPressed: () {
                      if (descriptionEditController.text.isNotEmpty) {
                        restaurantData.sendConfiguredDataToBackend({
                          "food_id": widget.foodItem.oid,
                          "category_type": widget.menuType,
                          "editing_fields": {
                            "description": descriptionEditController.text,
                          },
                        }, "edit_food_item");
                      }
                      Navigator.of(context).pop(); // To close the dialog
                    },
                  ),
                ],
              )
            ],
          ),
        );
      },
    );
  }

  Widget editItemPrice(restaurantData) {
    priceEditController.text = widget.foodItem.price;

    showDialog(
      barrierDismissible: false,
      context: context,
      builder: (BuildContext context) {
        // return object of type Dialog
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
                    "Price : ",
                    textAlign: TextAlign.center,
                    style: kTitleStyle,
                  ),
                  SizedBox(width: 20),
                  Container(
                    width: 200,
                    child: TextField(
                      controller: priceEditController,
                      textCapitalization: TextCapitalization.words,
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
                      style:
                          TextStyle(fontFamily: "Poppins", color: Colors.red),
                    ),
                    onPressed: () {
                      Navigator.of(context).pop(); // To close the dialog
                    },
                  ),
                  FlatButton(
                    child: Text(
                      "Done",
                      style:
                          TextStyle(fontFamily: "Poppins", color: Colors.green),
                    ),
                    onPressed: () {
                      if (priceEditController.text.isNotEmpty) {
                        restaurantData.sendConfiguredDataToBackend({
                          "food_id": widget.foodItem.oid,
                          "category_type": widget.menuType,
                          "editing_fields": {
                            "price": priceEditController.text,
                          },
                        }, "edit_food_item");
                      }
                      Navigator.of(context).pop(); // To close the dialog
                    },
                  ),
                ],
              )
            ],
          ),
        );
      },
    );
  }

  Widget editFoodItemOptions(restaurantData, index) {
    foodOptionEditController.text = editOptions[index]["option_name"];

    foodOptionPriceEditController.text = editOptions[index]["option_price"];
    showDialog(
        barrierDismissible: false,
        context: context,
        builder: (BuildContext context) {
          return AlertDialog(
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(20),
            ),
            content: Container(
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: <Widget>[
                  Container(
                    width: 200,
                    child: TextField(
                      controller: foodOptionEditController,
                      autofocus: true,
                    ),
                  ),
                  Container(
                    width: 200,
                    child: TextField(
                      controller: foodOptionPriceEditController,
                    ),
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
                        onPressed: () {
                          setState(() {
                            editOptions[index]["option_name"] =
                                foodOptionEditController.text;

                            editOptions[index]["option_price"] =
                                foodOptionPriceEditController.text;
                          });

                          if (foodOptionEditController.text.isNotEmpty &&
                              foodOptionPriceEditController.text.isNotEmpty) {
                            restaurantData.sendConfiguredDataToBackend({
                              "food_id": widget.foodItem.oid,
                              "category_type": widget.menuType,
                              "editing_fields": {
                                "food_options": {
                                  "options": editOptions,
                                  "choices": editChoices
                                }
                              }
                            }, "edit_food_item");

                            foodOptionEditController.clear();
                            foodOptionPriceEditController.clear();

//                            editOptions.clear();
//                            editChoices.clear();
                          }

                          Navigator.of(context).pop(); // To close the dialog
                        },
                        child: Text(
                          "Done",
                          style: TextStyle(color: Colors.green),
                        ),
                      ),
                    ],
                  )
                ],
              ),
            ),
          );
        });
  }

  Widget addNewFoodOptions(restaurantData) {
    showDialog(
        barrierDismissible: false,
        context: context,
        builder: (BuildContext context) {
          return AlertDialog(
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(20),
            ),
            content: Container(
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: <Widget>[
                  Container(
                    width: 200,
                    child: TextField(
                      controller: foodOptionEditController,
                      autofocus: true,
                    ),
                  ),
                  Container(
                    width: 200,
                    child: TextField(
                      controller: foodOptionPriceEditController,
                    ),
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
                        onPressed: () {
                          setState(() {
                            editOptions.add({
                              "option_name": foodOptionEditController.text,
                              "option_price": foodOptionPriceEditController.text
                            });
                          });

                          if (foodOptionEditController.text.isNotEmpty &&
                              foodOptionPriceEditController.text.isNotEmpty) {
                            restaurantData.sendConfiguredDataToBackend({
                              "food_id": widget.foodItem.oid,
                              "category_type": widget.menuType,
                              "editing_fields": {
                                "food_options": {
                                  "options": editOptions,
                                  "choices": editChoices
                                }
                              }
                            }, "edit_food_item");
//                            editOptions.clear();
//                            editChoices.clear();
                          }

                          foodOptionEditController.clear();
                          foodOptionPriceEditController.clear();

                          Navigator.of(context).pop(); // To close the dialog
                        },
                        child: Text(
                          "Done",
                          style: TextStyle(color: Colors.green),
                        ),
                      ),
                    ],
                  )
                ],
              ),
            ),
          );
        });
  }

  Widget editFoodItemChoices(restaurantData, index) {
    foodChoiceEditController.text = editChoices[index];
    showDialog(
        barrierDismissible: false,
        context: context,
        builder: (BuildContext context) {
          return AlertDialog(
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(20),
            ),
            content: Container(
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: <Widget>[
                  Container(
                    width: 200,
                    child: TextField(
                      controller: foodChoiceEditController,
                      autofocus: true,
                    ),
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
                        onPressed: () {
                          setState(() {
                            editChoices[index] = foodChoiceEditController.text;
                          });

                          if (foodChoiceEditController.text.isNotEmpty) {
                            restaurantData.sendConfiguredDataToBackend({
                              "food_id": widget.foodItem.oid,
                              "category_type": widget.menuType,
                              "editing_fields": {
                                "food_options": {
                                  "options": editOptions,
                                  "choices": editChoices
                                }
                              }
                            }, "edit_food_item");

                            foodChoiceEditController.clear();

//                            editChoices.clear();
//                            editOptions.clear();
                          }

                          Navigator.of(context).pop(); // To close the dialog
                        },
                        child: Text(
                          "Done",
                          style: TextStyle(color: Colors.green),
                        ),
                      ),
                    ],
                  )
                ],
              ),
            ),
          );
        });
  }

  Widget addNewFoodChoices(restaurantData) {
    showDialog(
        barrierDismissible: false,
        context: context,
        builder: (BuildContext context) {
          return AlertDialog(
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(20),
            ),
            content: Container(
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: <Widget>[
                  Container(
                    width: 200,
                    child: TextField(
                      controller: foodChoiceEditController,
                      autofocus: true,
                    ),
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
                        onPressed: () {
                          setState(() {
                            editChoices.add(foodChoiceEditController.text);
                          });

                          if (foodChoiceEditController.text.isNotEmpty) {
                            restaurantData.sendConfiguredDataToBackend({
                              "food_id": widget.foodItem.oid,
                              "category_type": widget.menuType,
                              "editing_fields": {
                                "food_options": {
                                  "options": editOptions,
                                  "choices": editChoices
                                }
                              }
                            }, "edit_food_item");

                            foodChoiceEditController.clear();
//                            editChoices.clear();
//                            editOptions.clear();
                          }

                          Navigator.of(context).pop(); // To close the dialog
                        },
                        child: Text(
                          "Done",
                          style: TextStyle(color: Colors.green),
                        ),
                      ),
                    ],
                  )
                ],
              ),
            ),
          );
        });
  }
}

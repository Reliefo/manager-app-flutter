import 'package:custom_switch/custom_switch.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter/widgets.dart';
import 'package:manager_app/constants.dart';
import 'package:manager_app/data.dart';
import 'package:manager_app/fetchData/configureRestaurantData.dart';
import 'package:provider/provider.dart';

import 'addOnPopup.dart';
import 'newCustomization.dart';

class ViewItem extends StatefulWidget {
  final menuType;
  final MenuFoodItem foodItem;
  final bool showCustomization;

  ViewItem({
    @required this.showCustomization,
    @required this.menuType,
    @required this.foodItem,
  });

  @override
  _ViewItemState createState() => _ViewItemState();
}

class EditCustomizationPreferences extends StatefulWidget {
  final Customization customization;
  final Function sendDataToBackend;
  final RestaurantData restaurantData;

  EditCustomizationPreferences({
    @required this.sendDataToBackend,
    @required this.customization,
    @required this.restaurantData,
  });
  @override
  _EditCustomizationPreferencesState createState() =>
      _EditCustomizationPreferencesState();
}


class _ViewItemState extends State<ViewItem> {
  bool switchStatus = true;
  bool showPriceEditButton = true;
  int radioItemVal;

  List<Customization> editCustomizations = [];
  List<Customization> newCustomizations = [];
  List<Map<String, dynamic>> dataToBackend = [];
  List<MenuFoodItem> availableAddOns = [];
  Map<String, bool> availableAddOnsValues = {};
  final itemNameEditController = TextEditingController();
  final descriptionEditController = TextEditingController();
  final priceEditController = TextEditingController();
  final foodOptionEditController = TextEditingController();
  final foodOptionPriceEditController = TextEditingController();
  final foodChoiceEditController = TextEditingController();

  addEditChoiceOption(restaurantData) {
    editCustomizations.clear();

    if (widget.foodItem.customizations != null) {
      widget.foodItem.customizations.forEach((customization) {
        editCustomizations.add(customization);
        if(customization.customizationType == "options"){
            setState(() {
              showPriceEditButton = false;
            });
        }
        //add_ons, choices, options
        //choices is options without price
        //options is options with price
      });
    }

    if (newCustomizations.isNotEmpty) {
      print("adding new customizations");
      editCustomizations.addAll(newCustomizations);

      sendDataToBackend(restaurantData);
      newCustomizations.clear();
      print("added new customizations");
    }
  }

  sendAdonsData(restaurantData) {
    //todo: replace with send data to backend

    customizationToMap();

    restaurantData.sendConfiguredDataToBackend({
      "food_id": widget.foodItem.oid,
      "category_type": widget.menuType,
      "editing_fields": {"customization": dataToBackend}
    }, "edit_food_item");
    newCustomizations.clear();
  }

  getAvailableAddOns(restaurantData) {
    availableAddOns.clear();
    availableAddOnsValues.clear();
    restaurantData.restaurant.addOnsMenu?.forEach((addOn) {
      availableAddOns.add(addOn);
      availableAddOnsValues["${addOn.oid}"] = false;
    });
    editCustomizations?.forEach((customization) {
      if (customization.customizationType == "add_ons") {
        customization.addOns.forEach((addOn) {
          setState(() {
            availableAddOns.removeWhere((element) => addOn.oid == element.oid);
            availableAddOnsValues.remove(addOn.oid);
          });
        });
      }
    });
  }

  customizationToMap() {
    dataToBackend.clear();

    editCustomizations.forEach((cust) {
      dataToBackend.add(cust.toJson());
    });
  }

  sendDataToBackend(restaurantData) {
    customizationToMap();

    restaurantData.sendConfiguredDataToBackend({
      "food_id": widget.foodItem.oid,
      "category_type": widget.menuType,
      "editing_fields": {"customization": dataToBackend}
    }, "edit_food_item");
  }

  updateVisibilityToBackend(restaurantData) {
    restaurantData.sendConfiguredDataToBackend({
      "category_type": widget.menuType,
      "food_id": widget.foodItem.oid,
      "visibility": switchStatus,
    }, "visibility_food_item");
  }

  String findLowestPriceAndSetPriceField(restaurantData){
    double min = double.maxFinite;
    double total = 0;
    editCustomizations?.forEach((customization) {
      customization.options.forEach((option){
        option.forEach((k,v) {
          if(k == "option_price"){
            if(v < min) min = v;
          }
        });
        total = total + min;
      });
    });
    newCustomizations?.forEach((customization) {
      customization.options.forEach((option){
        option.forEach((k,v) {
          if(k == "option_price"){
            double temp = double.parse(v);
            if(temp < min) min = temp;
          }
        });
        total = total + min;
      });
    });
    String minimum = total.toInt().toString() + '+';
    return minimum;
  }

  Widget editPriceButton(restaurantData) {
    if(showPriceEditButton == true){
      return IconButton(
        icon: Icon(Icons.edit),
        onPressed: () {
          editItemPrice(restaurantData);
        },
      );
    }
    else{
      return Container(width: 0, height: 0);
    }
  }

  Widget getLayout(restaurantData, Customization customization) {
    if (customization.customizationType == "options") {
      return uiForOptions(restaurantData, customization.options, customization);
    }

    if (customization.customizationType == "choices") {
      return uiForChoices(restaurantData, customization.choices, customization);
    }
    if (customization.customizationType == "add_ons") {
      return uiForAddOns(
          restaurantData, customization.addOns, customization.name);
    }
  }

  Widget uiForOptions(restaurantData, options, customization) {
    return options != null
        ? Column(
            children: <Widget>[
              Container(
                padding: EdgeInsets.symmetric(horizontal: 16, vertical: 12),
                child: Row(
                  children: <Widget>[
                    Text(
                      customization.name,
                      style: kHeaderStyle,
                    ),
                    SizedBox(
                      width: 20,
                    ),
                    IconButton(
                      icon: Icon(Icons.add),
                      onPressed: () {
                        addNewFoodOptions(restaurantData, options);
                      },
                    ),
                    IconButton(
                      icon: Icon(
                        Icons.settings,
                        color: Colors.blue,
                      ),
                      onPressed: () {
                        showDialog(
                            barrierDismissible: false,
                            context: context,
                            builder: (BuildContext context) {
                              return EditCustomizationPreferences(
                                restaurantData: restaurantData,
                                sendDataToBackend: sendDataToBackend,
                                customization: customization,
                              );
                            });
                      },
                    ),
                    IconButton(
                      icon: Icon(Icons.remove),
                      onPressed: () {
                        var toRemove;
                        editCustomizations.forEach((custm) {
                          if (custm.options == options) {
                            setState(() {
                              toRemove = custm;
                            });
                          }
                        });
                        editCustomizations.remove(toRemove);

                        customizationToMap();
                        restaurantData.sendConfiguredDataToBackend({
                          "food_id": widget.foodItem.oid,
                          "category_type": widget.menuType,
                          "editing_fields": {"customization": dataToBackend}
                        }, "edit_food_item");
                        refreshPriceEditButton();
                      },
                    ),
                  ],
                ),
              ),
              ListView.builder(
                  primary: false,
                  shrinkWrap: true,
                  itemCount: options.length,
                  itemBuilder: (context, index) {
                    return ListTile(
                      title: Text(
                        options[index]["option_name"],
                        textAlign: TextAlign.left,
                        style: TextStyle(
                          fontFamily: 'Poppins',
                          fontSize: 16.0,
                        ),
                      ),
                      subtitle: Text(
                        "Price :  ${options[index]["option_price"]} ",
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
                                  restaurantData, options[index]);
                            },
                          ),
                          IconButton(
                            icon: Icon(Icons.cancel),
                            onPressed: () {
                              setState(() {
                                options.removeAt(index);
                              });

                              customizationToMap();

                              restaurantData.sendConfiguredDataToBackend({
                                "food_id": widget.foodItem.oid,
                                "category_type": widget.menuType,
                                "editing_fields": {
                                  "customization": dataToBackend
                                }
                              }, "edit_food_item");
                            },
                          ),
                        ],
                      ),
                    );
                  }),
            ],
          )
        : Container(height: 0, width: 0);
  }

  Widget uiForChoices(restaurantData, choices, customization) {
    return choices != null
        ? Column(
            children: <Widget>[
              Container(
                padding: EdgeInsets.symmetric(horizontal: 16, vertical: 12),
                child: Row(
                  children: <Widget>[
                    Text(
                      customization.name,
                      style: kHeaderStyle,
                    ),
                    SizedBox(
                      width: 20,
                    ),
                    IconButton(
                      icon: Icon(Icons.add),
                      onPressed: () {
                        addNewFoodChoices(restaurantData, choices);
                      },
                    ),
                    IconButton(
                      icon: Icon(
                        Icons.settings,
                        color: Colors.blue,
                      ),
                      onPressed: () {
                        showDialog(
                            barrierDismissible: false,
                            context: context,
                            builder: (BuildContext context) {
                              return EditCustomizationPreferences(
                                restaurantData: restaurantData,
                                sendDataToBackend: sendDataToBackend,
                                customization: customization,
                              );
                            });
                      },
                    ),
                    IconButton(
                      icon: Icon(Icons.remove),
                      onPressed: () {
                        var toRemove;
                        editCustomizations.forEach((custm) {
                          if (custm.choices == choices) {
                            setState(() {
                              toRemove = custm;
                            });
                          }
                        });
                        editCustomizations.remove(toRemove);

                        customizationToMap();
                        restaurantData.sendConfiguredDataToBackend({
                          "food_id": widget.foodItem.oid,
                          "category_type": widget.menuType,
                          "editing_fields": {"customization": dataToBackend}
                        }, "edit_food_item");
                      },
                    ),
                  ],
                ),
              ),
              ListView.builder(
                  primary: false,
                  shrinkWrap: true,
                  itemCount: choices.length,
                  itemBuilder: (context, index2) {
                    return ListTile(
                      title: Text(
                        choices[index2],
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
                                  restaurantData, choices, index2);
                            },
                          ),
                          IconButton(
                            icon: Icon(Icons.cancel),
                            onPressed: () {
                              setState(() {
                                choices.removeAt(index2);
                              });

                              customizationToMap();

                              restaurantData.sendConfiguredDataToBackend({
                                "food_id": widget.foodItem.oid,
                                "category_type": widget.menuType,
                                "editing_fields": {
                                  "customization": dataToBackend
                                }
                              }, "edit_food_item");
                            },
                          ),
                        ],
                      ),
                    );
                  }),
            ],
          )
        : Container(height: 0, width: 0);
  }

  Widget uiForAddOns(restaurantData, addOns, name) {
    return Column(
      children: <Widget>[
        Container(
          padding: EdgeInsets.symmetric(horizontal: 16, vertical: 12),
          child: Row(
            children: <Widget>[
              Text(
                name,
                style: kHeaderStyle,
              ),
              SizedBox(
                width: 20,
              ),
              IconButton(
                icon: Icon(Icons.add),
                onPressed: () {
                  showDialog(
                    barrierDismissible: false,
                    context: context,
                    builder: (BuildContext context) {
                      // return object of type Dialog
                      return AddOnPopup(
                        restaurantData: restaurantData,
                        sendAdonsData: sendAdonsData,
                        addOns: addOns,
                        availableAddOns: availableAddOns,
                        availableAddOnsValues: availableAddOnsValues,
                      );
                    },
                  );
                },
              ),
              IconButton(
                icon: Icon(Icons.remove),
                onPressed: () {
                  var toRemove;
                  editCustomizations.forEach((custm) {
                    if (custm.addOns == addOns) {
                      setState(() {
                        toRemove = custm;
                      });
                    }
                  });
                  editCustomizations.remove(toRemove);
                  //refreshPriceEditButton();

                  customizationToMap();
                  restaurantData.sendConfiguredDataToBackend({
                    "food_id": widget.foodItem.oid,
                    "category_type": widget.menuType,
                    "editing_fields": {"customization": dataToBackend}
                  }, "edit_food_item");
                },
              ),
            ],
          ),
        ),
        addOns != null
            ? ListView.builder(
                primary: false,
                shrinkWrap: true,
                itemCount: addOns.length,
                itemBuilder: (context, index) {
                  return ListTile(
                    title: Text(
                      addOns[index].name,
                      textAlign: TextAlign.left,
                      style: TextStyle(
                        fontFamily: 'Poppins',
                        fontSize: 16.0,
                      ),
                    ),
                    subtitle: Text(
                      "Price :  ${addOns[index].price} ",
                      textAlign: TextAlign.left,
                      style: TextStyle(
                        fontSize: 16.0,
                        fontFamily: 'Poppins',
                      ),
                    ),
                    trailing: IconButton(
                      icon: Icon(Icons.cancel),
                      onPressed: () {
                        setState(() {
                          addOns.removeAt(index);
                        });
                        customizationToMap();
                        restaurantData.sendConfiguredDataToBackend({
                          "food_id": widget.foodItem.oid,
                          "category_type": widget.menuType,
                          "editing_fields": {"customization": dataToBackend}
                        }, "edit_food_item");
                      },
                    ),
                  );
                })
            : Container(height: 0, width: 0),
      ],
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
                      keyboardType:
                      TextInputType.numberWithOptions(decimal: true),
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

  Widget editFoodItemOptions(restaurantData, option) {
    foodOptionEditController.text = option["option_name"];

    foodOptionPriceEditController.text = option["option_price"].toString();
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
                  Row(
                    children: <Widget>[
                      Text("Name : "),
                      SizedBox(width: 8),
                      Container(
                        width: 200,
                        child: TextField(
                          controller: foodOptionEditController,
                          autofocus: true,
                          keyboardType: TextInputType.text,
                          textCapitalization: TextCapitalization.sentences,
                        ),
                      ),
                    ],
                  ),
                  Row(
                    children: <Widget>[
                      Text("Price : "),
                      SizedBox(width: 8),
                      Container(
                        width: 200,
                        child: TextField(
                          controller: foodOptionPriceEditController,
                          keyboardType:
                          TextInputType.numberWithOptions(decimal: true),
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
                          setState(() {
                            option["option_name"] =
                                foodOptionEditController.text;

                            option["option_price"] = double.parse(
                                foodOptionPriceEditController.text);
                          });

                          customizationToMap();

                          if (foodOptionEditController.text.isNotEmpty &&
                              foodOptionPriceEditController.text.isNotEmpty) {
                            restaurantData.sendConfiguredDataToBackend({
                              "food_id": widget.foodItem.oid,
                              "category_type": widget.menuType,
                              "editing_fields": {"customization": dataToBackend}
                            }, "edit_food_item");

                            foodOptionEditController.clear();
                            foodOptionPriceEditController.clear();
                          }

                          Navigator.of(context).pop(); // To close the dialog
                        },
                      ),
                    ],
                  )
                ],
              ),
            ),
          );
        });
  }

  Widget addNewFoodOptions(restaurantData, options) {
    foodOptionEditController.clear();
    foodOptionPriceEditController.clear();
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
                  Row(
                    children: <Widget>[
                      Text("Name : "),
                      SizedBox(width: 8),
                      Container(
                        width: 200,
                        child: TextField(
                          controller: foodOptionEditController,
                          autofocus: true,
                          keyboardType: TextInputType.text,
                          textCapitalization: TextCapitalization.sentences,
                        ),
                      ),
                    ],
                  ),
                  Row(
                    children: <Widget>[
                      Text("Price : "),
                      SizedBox(width: 8),
                      Container(
                        width: 200,
                        child: TextField(
                          controller: foodOptionPriceEditController,
                          keyboardType:
                          TextInputType.numberWithOptions(decimal: true),
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
                        onPressed: () {
                          setState(() {
                            options.add({
                              "option_name": foodOptionEditController.text,
                              "option_price": double.parse(
                                  foodOptionPriceEditController.text),
                            });
                          });

                          customizationToMap();

                          if (foodOptionEditController.text.isNotEmpty &&
                              foodOptionPriceEditController.text.isNotEmpty) {
                            restaurantData.sendConfiguredDataToBackend({
                              "food_id": widget.foodItem.oid,
                              "category_type": widget.menuType,
                              "editing_fields": {"customization": dataToBackend}
                            }, "edit_food_item");
                            newCustomizations.clear();
                            widget.foodItem.price = findLowestPriceAndSetPriceField(restaurantData);
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

  Widget editFoodItemChoices(restaurantData, choice, index2) {
    foodChoiceEditController.text = choice[index2];
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
                  Row(
                    children: <Widget>[
                      Text("Name : "),
                      SizedBox(width: 8),
                      Container(
                        width: 200,
                        child: TextField(
                          controller: foodChoiceEditController,
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
                          setState(() {
                            choice[index2] = foodChoiceEditController.text;
                          });

                          //print("kkk");

                          customizationToMap();

                          //print(dataToBackend);

                          if (foodChoiceEditController.text.isNotEmpty) {
                            restaurantData.sendConfiguredDataToBackend({
                              "food_id": widget.foodItem.oid,
                              "category_type": widget.menuType,
                              "editing_fields": {"customization": dataToBackend}
                            }, "edit_food_item");

                            foodChoiceEditController.clear();
                            widget.foodItem.price = findLowestPriceAndSetPriceField(restaurantData);
                          }

                          Navigator.of(context).pop(); // To close the dialog
                        },
                      ),
                    ],
                  )
                ],
              ),
            ),
          );
        });
  }

  Widget addNewFoodChoices(restaurantData, choices) {
    foodChoiceEditController.clear();
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
                  Row(
                    children: <Widget>[
                      Text("Name : "),
                      SizedBox(width: 8),
                      Container(
                        width: 200,
                        child: TextField(
                          controller: foodChoiceEditController,
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
                            choices.add(foodChoiceEditController.text);
                          });
                          customizationToMap();
                          if (foodChoiceEditController.text.isNotEmpty) {
                            restaurantData.sendConfiguredDataToBackend({
                              "food_id": widget.foodItem.oid,
                              "category_type": widget.menuType,
                              "editing_fields": {"customization": dataToBackend}
                            }, "edit_food_item");
                            newCustomizations.clear();
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

  Widget confirmExit(){
    showDialog(
        barrierDismissible: false,
        context: context,
        builder: (BuildContext context) {
          return AlertDialog(
            content: Text("Price is not set for this item, do you want to go back to the menu page?"),
            actions: <Widget>[
              FlatButton(
                child: Text("Cancel"),
                onPressed: () {
                  Navigator.of(context).pop();
                },
              ),

              FlatButton(
                child: Text("Yes"),
                onPressed: () {
                  //Put your code here which you want to execute on No button click.
                  Navigator.of(context).pop();
                  Navigator.of(context).pop();
                },
              ),
            ],
          );
        });
  }

  void refreshPriceEditButton() {
    bool flag = true;
    editCustomizations?.forEach((customization) {
      if(customization.customizationType == "options"){
        flag = false;
      }
      //add_ons, choices, options
      //choices is options without price
      //options is options with price
    });
    setState(() {
      showPriceEditButton = flag;
    });
  }


//  @override
//  void initState() {
//    addEditChoiceOption();
//    // TODO: implement initState
//    super.initState();
//  }

  @override
  Widget build(BuildContext context) {
    //print(context);
    final RestaurantData restaurantData = Provider.of<RestaurantData>(context);

    addEditChoiceOption(restaurantData);
    getAvailableAddOns(restaurantData);

    return new WillPopScope(
      onWillPop: () async {
          // You can do some work here.
          // Returning true allows the pop to happen, returning false prevents it.
          if(widget.foodItem.price == null) {
            confirmExit();
            return false;
          }
          else{
            return true;
          }
        },
      child: SafeArea(
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
                          Row(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: <Widget>[
                              Container(
                                width: MediaQuery.of(context).size.width * 0.3,
                                height: MediaQuery.of(context).size.height * 0.3,
                                color: Colors.blue,
                              ),
                              Expanded(
                                child: Column(
                                  children: <Widget>[
                                    switchStatus == true
                                        ? Text(
                                            "This Item is visible in Menu",
                                            textAlign: TextAlign.center,
                                            style: kHeaderStyleSmall,
                                          )
                                        : Text(
                                            "This Item is Not visible in Menu",
                                            textAlign: TextAlign.center,
                                            style: kHeaderStyleSmall,
                                          ),
                                    SizedBox(height: 12.0),
                                    CustomSwitch(
                                      activeColor: Colors.green,
                                      value: widget.foodItem.visibility,
                                      onChanged: (value) {
                                        setState(() {
                                          switchStatus = value;
                                        });
                                        updateVisibilityToBackend(restaurantData);
                                      },
                                    ),
                                  ],
                                ),
                              ),
                            ],
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
                                  widget.foodItem.description ?? "",
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
                                    editPriceButton(restaurantData),
                                  ],
                                ),
                                SizedBox(height: 12),
                                Text(
                                  widget.foodItem.price ?? "",
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
                widget.showCustomization == true
                    ? Expanded(
                        child: SingleChildScrollView(
                          child: Column(
                            children: <Widget>[
                              RaisedButton(
                                child: Text("Add new customization list + "),
                                onPressed: () {
                                  showDialog(
                                    barrierDismissible: false,
                                    context: context,
                                    builder: (BuildContext context) {
                                      // return object of type Dialog
                                      return NewCustomization(
                                        restaurantData: restaurantData,
                                        newCustomizations: newCustomizations,
                                        addEditChoiceOption: addEditChoiceOption,
                                      );
                                    },
                                  );
                                },
                              ),
                              editCustomizations != null
                                  ? ListView.builder(
                                      primary: false,
                                      shrinkWrap: true,
                                      itemCount: editCustomizations.length,
                                      itemBuilder: (context, index) {
                                        return Column(
                                          children: <Widget>[
                                            getLayout(
                                              restaurantData,
                                              editCustomizations[index],
                                            ),
                                          ],
                                        );
                                      })
                                  : Container(
                                      child: Text("no customization"),
                                    ),
                            ],
                          ),
                        ),
                      )
                    : Expanded(
                        child: Container(child: Text("*")),
                      ),
              ],
            ),
          ),
        ),
      ),
    );
  }

}

class _EditCustomizationPreferencesState extends State<EditCustomizationPreferences> {
  final customizationNameEditController = TextEditingController();
  final thatNumberEditController = TextEditingController();
  int radioItemVal;
  @override
  Widget build(BuildContext context) {
//    RestaurantData restaurantData = Provider.of<RestaurantData>(context);

    customizationNameEditController.text = widget.customization.name;
    thatNumberEditController.text = widget.customization.thatNumber.toString();
    if (radioItemVal == null) {
      radioItemVal = widget.customization.lessMore;
    }

    return AlertDialog(
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(20),
      ),
      title: Text(
        "Edit Preferences",
        style: kHeaderStyleSmall,
      ),
      content: SingleChildScrollView(
        child: Container(
          width: 350,
          child: Column(
            mainAxisSize: MainAxisSize.min, // To make the card compact
            children: <Widget>[
              Row(
                children: <Widget>[
                  Text("Name : "),
                  Expanded(
                    child: TextField(
                      controller: customizationNameEditController,
                      keyboardType: TextInputType.text,
                      textCapitalization: TextCapitalization.sentences,
                    ),
                  ),
                ],
              ),
              Column(
                mainAxisSize: MainAxisSize.min,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  Padding(
                    padding: const EdgeInsets.symmetric(
                        horizontal: 16.0, vertical: 8),
                    child: Text("User can select :"),
                  ),
                  RadioListTile(
                    groupValue: radioItemVal,
                    title: Text(
                      'Less Than',
                      style: kTitleStyle,
                    ),
                    value: -1,
                    onChanged: (val) {
                      setState(() {
                        radioItemVal = val;
                      });
                    },
                  ),
                  RadioListTile(
                    groupValue: radioItemVal,
                    title: Text(
                      'Exactly',
                      style: kTitleStyle,
                    ),
                    value: 0,
                    onChanged: (val) {
                      setState(() {
                        radioItemVal = val;
                      });
                    },
                  ),
                  RadioListTile(
                    groupValue: radioItemVal,
                    title: Text(
                      'More Than',
                      style: kTitleStyle,
                    ),
                    value: 1,
                    onChanged: (val) {
                      setState(() {
                        radioItemVal = val;
                      });
                    },
                  ),
                ],
              ),
              Row(
                children: <Widget>[
                  Text("Quantity : "),
                  Expanded(
                    child: TextField(
                      controller: thatNumberEditController,
                      keyboardType:
                          TextInputType.numberWithOptions(decimal: true),
                    ),
                  ),
                ],
              ),
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
                      widget.customization.name =
                          customizationNameEditController.text;
                      widget.customization.lessMore = radioItemVal;
                      widget.customization.thatNumber =
                          int.parse(thatNumberEditController.text);
                      widget.sendDataToBackend(widget.restaurantData);
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

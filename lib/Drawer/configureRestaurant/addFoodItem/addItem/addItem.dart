import 'package:flutter/material.dart';
import 'package:manager_app/Drawer/configureRestaurant/addFoodItem/addItem/choices.dart';
import 'package:manager_app/Drawer/configureRestaurant/addFoodItem/addItem/options.dart';
import 'package:manager_app/Drawer/configureRestaurant/addFoodItem/viewItem.dart';
import 'package:manager_app/data.dart';
import 'package:manager_app/fetchData/configureRestaurantData.dart';
import 'package:provider/provider.dart';

class AddItem extends StatefulWidget {
  final Category category;

  final menuType;
  AddItem({
    this.category,
    this.menuType,
  });
  @override
  _AddFoodItemState createState() => _AddFoodItemState();
}

class _AddFoodItemState extends State<AddItem> {
  Map<String, dynamic> foodTemp = {};
  List<String> choices = [];
  List<Map<String, dynamic>> options = [];
  List<String> editChoices = [];
  Map<String, String> editOptions;
  bool optionsCheckBoxValue = false;
  bool choicesCheckBoxValue = false;
  final itemNameController = TextEditingController();
  final descriptionController = TextEditingController();
  final priceController = TextEditingController();
  final foodOptionController = TextEditingController();
  final foodChoiceController = TextEditingController();

  final FocusNode itemNameFocus = FocusNode();
  final FocusNode descriptionFocus = FocusNode();
  final FocusNode priceFocus = FocusNode();
  final FocusNode foodOptionFocus = FocusNode();
  final FocusNode foodChoiceFocus = FocusNode();

//  final _itemNameEditController = TextEditingController();
//  final _descriptionEditController = TextEditingController();
//  final _priceEditController = TextEditingController();
//  final _foodOptionEditController = TextEditingController();
//  final _foodOptionPriceEditController = TextEditingController();
//  final _foodChoiceEditController = TextEditingController();

  _fieldFocusChange(
      BuildContext context, FocusNode currentFocus, FocusNode nextFocus) {
    currentFocus.unfocus();
    FocusScope.of(context).requestFocus(nextFocus);
  }

  confirmItem(restaurantData) {
    setState(() {
      foodTemp = {
        "category_id": widget.category.oid,
        "category_type": widget.menuType,
        "food_dict": {
          "name": itemNameController.text,
          "description": descriptionController.text,
          "price": priceController.text,
          "food_options": {"options": options, "choices": choices}
        },
      };
    });

    restaurantData.sendConfiguredDataToBackend(foodTemp, "add_food_item");

    itemNameController.clear();
    descriptionController.clear();
    priceController.clear();
    foodOptionController.clear();
    foodChoiceController.clear();
    foodTemp.clear();
    options.clear();
    choices.clear();
  }

  @override
  Widget build(BuildContext context) {
    final RestaurantData restaurantData = Provider.of<RestaurantData>(context);

//    print("choices : $choices");
    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
          backgroundColor: Colors.grey,
          title: Text(widget.category.name ?? " "),
        ),
        body: Container(
          padding: EdgeInsets.symmetric(vertical: 12, horizontal: 18),
          color: Color(0xffE0EAF0),
          child: Card(
            color: Color(0xffE5EDF1),
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(20.0),
            ),
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                Expanded(
                  child: SingleChildScrollView(
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: <Widget>[
                        Row(
                          mainAxisSize: MainAxisSize.min,
                          children: <Widget>[
                            Expanded(
                              flex: 2,
                              child: Container(
                                padding: EdgeInsets.all(12),
                                child: TextFormField(
                                  controller: itemNameController,
                                  textInputAction: TextInputAction.next,
                                  focusNode: itemNameFocus,
                                  onFieldSubmitted: (term) {
                                    _fieldFocusChange(context, itemNameFocus,
                                        descriptionFocus);
                                  },
                                  decoration: InputDecoration(
                                    labelText: "Item Name",
                                    fillColor: Colors.white,
                                    border: OutlineInputBorder(
                                      borderRadius: BorderRadius.circular(12.0),
                                    ),
                                    //fillColor: Colors.green
                                  ),
                                  keyboardType: TextInputType.text,
                                  validator: (value) {
                                    if (value.isEmpty) {
                                      return 'Please enter item';
                                    }
                                    return null;
                                  },
                                ),
                              ),
                            ),
                            Expanded(
                              child: Container(
                                child: Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: <Widget>[
                                    Column(
                                      children: <Widget>[
                                        Checkbox(
                                          value: optionsCheckBoxValue,
                                          onChanged: (bool value) {
                                            setState(() {
                                              optionsCheckBoxValue = value;
                                            });
                                          },
                                        ),
                                        Text('have options'),
                                      ],
                                    ),
                                    Column(
                                      children: <Widget>[
                                        Checkbox(
                                          value: choicesCheckBoxValue,
                                          onChanged: (bool value) {
                                            setState(() {
                                              choicesCheckBoxValue = value;
                                            });
                                          },
                                        ),
                                        Text('have choice'),
                                      ],
                                    ),
                                  ],
                                ),
                              ),
                            ),
                          ],
                        ),
                        Row(
                          children: <Widget>[
                            Expanded(
                              child: Container(
                                padding: EdgeInsets.all(12),
                                child: TextFormField(
                                  controller: descriptionController,
                                  textInputAction: TextInputAction.next,
                                  focusNode: descriptionFocus,
                                  onFieldSubmitted: (term) {
                                    if (optionsCheckBoxValue == true) {
                                      _fieldFocusChange(context,
                                          descriptionFocus, foodOptionFocus);
                                    }
                                    _fieldFocusChange(
                                        context, descriptionFocus, priceFocus);
                                  },
                                  decoration: InputDecoration(
                                    labelText: "Description",
                                    fillColor: Colors.white,
                                    border: OutlineInputBorder(
                                      borderRadius: BorderRadius.circular(12.0),
                                    ),
                                    //fillColor: Colors.green
                                  ),
                                  keyboardType: TextInputType.text,
                                  validator: (value) {
                                    if (value.isEmpty) {
                                      return 'Please enter Description';
                                    }
                                    return null;
                                  },
                                ),
                              ),
                            ),
                          ],
                        ),
                        optionsCheckBoxValue && choicesCheckBoxValue == true

                            ///// when both are true////////
                            ? Column(
                                children: <Widget>[
                                  Choices(
                                    foodChoiceController: foodChoiceController,
                                    priceController: priceController,
                                    foodChoiceFocus: foodChoiceFocus,
                                    choices: choices,
                                  ),
                                  Options(
                                    priceController: priceController,
                                    foodOptionController: foodOptionController,
                                    foodOptionFocus: foodOptionFocus,
                                    options: options,
                                  ),
                                ],
                              )
                            : optionsCheckBoxValue ||
                                    choicesCheckBoxValue == true
                                ? optionsCheckBoxValue == true
                                    ?
                                    //////////for options///////////////////
                                    Options(
                                        priceController: priceController,
                                        foodOptionController:
                                            foodOptionController,
                                        foodOptionFocus: foodOptionFocus,
                                        options: options,
                                      )

                                    //////for Choices/////////////////////////
                                    : Row(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        children: <Widget>[
                                          Expanded(
                                            flex: 2,
                                            child: Container(
                                              padding: EdgeInsets.all(12),
                                              child: TextFormField(
                                                controller: priceController,
                                                focusNode: priceFocus,
                                                decoration: InputDecoration(
                                                  labelText: "Price",
                                                  fillColor: Colors.white,
                                                  border: OutlineInputBorder(
                                                    borderRadius:
                                                        BorderRadius.circular(
                                                            12.0),
                                                  ),
                                                  //fillColor: Colors.green
                                                ),
                                                keyboardType:
                                                    TextInputType.text,
                                                validator: (value) {
                                                  if (value.isEmpty) {
                                                    return 'Please enter Price';
                                                  }
                                                  return null;
                                                },
                                              ),
                                            ),
                                          ),
                                          Expanded(
                                            flex: 3,
                                            child: Choices(
                                              foodChoiceController:
                                                  foodChoiceController,
                                              priceController: priceController,
                                              foodChoiceFocus: foodChoiceFocus,
                                              choices: choices,
                                            ),
                                          ),
                                        ],
                                      )

                                //////////////////////////////// if no options and choices///////////////////////////
                                : Row(
                                    children: <Widget>[
                                      Expanded(
                                        child: Container(
                                          padding: EdgeInsets.all(12),
                                          child: TextFormField(
                                            controller: priceController,
                                            focusNode: priceFocus,
                                            decoration: InputDecoration(
                                              labelText: "Price",
                                              fillColor: Colors.white,
                                              border: OutlineInputBorder(
                                                borderRadius:
                                                    BorderRadius.circular(12.0),
                                              ),
                                              //fillColor: Colors.green
                                            ),
                                            keyboardType: TextInputType.text,
                                            validator: (value) {
                                              if (value.isEmpty) {
                                                return 'Please enter Price';
                                              }
                                              return null;
                                            },
                                          ),
                                        ),
                                      ),
                                    ],
                                  ),
                        FlatButton(
                          child: Text('confirm item'),
                          onPressed: () {
                            confirmItem(restaurantData);
                          },
                        ),

                        ////////////////////// to display food item present in the menu///////////////////
                      ],
                    ),
                  ),
                ),
                VerticalDivider(
                  thickness: 2,
                  indent: 12,
                  endIndent: 12,
                ),
                Expanded(
                  child: widget.category.foodList != null
                      ? ListView.builder(
                          shrinkWrap: true,
                          itemCount: widget.category.foodList.length,
                          itemBuilder: (context, index) {
                            return FlatButton(
                              child: ListTile(
                                title:
                                    Text(widget.category.foodList[index].name),
                                subtitle: Text(widget
                                    .category.foodList[index].description),
                                trailing: Row(
                                  mainAxisSize: MainAxisSize.min,
                                  children: <Widget>[
                                    IconButton(
                                      icon: Icon(Icons.cancel),
                                      onPressed: () {
                                        restaurantData
                                            .sendConfiguredDataToBackend({
                                          "category_type": widget.menuType,
                                          "food_id": widget
                                              .category.foodList[index].oid
                                        }, "delete_food_item");
                                      },
                                    ),
                                  ],
                                ),
                              ),
                              onPressed: () {
                                //////////////////////////////// view item ///////////////
                                showDialog(
//                                    barrierDismissible: false,
                                    context: context,
                                    builder: (BuildContext context) {
                                      return ViewItem(
                                        menuType: widget.menuType,
                                        foodItem:
                                            widget.category.foodList[index],
                                      );
                                    });
                              },
                            );
                          },
                        )
                      : Text('no items'),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
//
//class Options extends StatefulWidget {
//  final foodOptionController;
//  final priceController;
//  final List<Map<String, dynamic>> options;
//  final FocusNode foodOptionFocus;
//
//  Options({
//    @required this.foodOptionController,
//    @required this.priceController,
//    @required this.options,
//    @required this.foodOptionFocus,
//  });
//
//  @override
//  _OptionsState createState() => _OptionsState();
//}
//
//class _OptionsState extends State<Options> {
//  @override
//  Widget build(BuildContext context) {
//    return Column(
//      children: <Widget>[
//        Row(children: <Widget>[
//          Expanded(
//            flex: 2,
//            child: Container(
//              padding: EdgeInsets.all(12),
//              child: TextFormField(
//                controller: widget.foodOptionController,
//                focusNode: widget.foodOptionFocus,
//                decoration: InputDecoration(
//                  labelText: "option",
//                  fillColor: Colors.white,
//                  border: OutlineInputBorder(
//                    borderRadius: BorderRadius.circular(12.0),
//                  ),
//                ),
//                keyboardType: TextInputType.text,
//                validator: (value) {
//                  if (value.isEmpty) {
//                    return 'Please enter option';
//                  }
//                  return null;
//                },
//              ),
//            ),
//          ),
//          Expanded(
//            flex: 2,
//            child: Container(
//              padding: EdgeInsets.all(12),
//              child: TextFormField(
//                controller: widget.priceController,
//                decoration: InputDecoration(
//                  labelText: "price",
//                  fillColor: Colors.white,
//                  border: OutlineInputBorder(
//                    borderRadius: BorderRadius.circular(12.0),
//                  ),
//                  //fillColor: Colors.green
//                ),
//                keyboardType: TextInputType.text,
//                validator: (value) {
//                  if (value.isEmpty) {
//                    return 'Please enter price';
//                  }
//                  return null;
//                },
//              ),
//            ),
//          ),
//          Expanded(
//            child: FlatButton(
//                child: Text('add option'),
//                onPressed: () {
//                  setState(() {
//                    widget.options.add({
//                      "option_name": widget.foodOptionController.text,
//                      "option_price": widget.priceController.text
//                    });
//                  });
//
//                  widget.foodOptionController.clear();
//                  widget.priceController.clear();
//                }),
//          )
//        ]),
//        Container(
//          child: ListView.builder(
//            shrinkWrap: true,
//            primary: false,
//            itemCount: widget.options.length,
//            itemBuilder: (context, index) {
//              return ListTile(
//                title: Text(widget.options[index]["option_name"]),
//                subtitle:
//                    Text("Price : ${widget.options[index]["option_price"]}"),
//                trailing: IconButton(
//                  icon: Icon(
//                    Icons.cancel,
//                  ),
//                  onPressed: () {
//                    setState(() {
//                      widget.options.removeAt(index);
//                    });
//                  },
//                ),
//              );
//            },
//          ),
//        )
//      ],
//    );
//  }
//}
//
//class Choices extends StatefulWidget {
//  final foodChoiceController;
//  final priceController;
//  final FocusNode foodChoiceFocus;
//  final List<String> choices;
//  Choices({
//    @required this.foodChoiceController,
//    @required this.priceController,
//    @required this.foodChoiceFocus,
//    @required this.choices,
//  });
//
//  @override
//  _ChoicesState createState() => _ChoicesState();
//}
//
//class _ChoicesState extends State<Choices> {
//  @override
//  Widget build(BuildContext context) {
//    return Column(
//      mainAxisSize: MainAxisSize.min,
//      mainAxisAlignment: MainAxisAlignment.start,
//      children: <Widget>[
//        Row(
//          mainAxisAlignment: MainAxisAlignment.spaceBetween,
//          children: <Widget>[
//            Expanded(
//              child: Container(
//                padding: EdgeInsets.all(12),
//                child: TextFormField(
//                  controller: widget.foodChoiceController,
//                  focusNode: widget.foodChoiceFocus,
//                  decoration: InputDecoration(
//                    labelText: "choice",
//                    fillColor: Colors.white,
//                    border: OutlineInputBorder(
//                      borderRadius: BorderRadius.circular(12.0),
//                    ),
//                    //fillColor: Colors.green
//                  ),
//                  keyboardType: TextInputType.text,
//                  validator: (value) {
//                    if (value.isEmpty) {
//                      return 'Please enter option';
//                    }
//                    return null;
//                  },
//                ),
//              ),
//            ),
//            FlatButton(
//              child: Text('add choice'),
//              onPressed: () {
//                setState(() {
//                  widget.choices.add(widget.foodChoiceController.text);
//                });
//                widget.foodChoiceController.clear();
//              },
//            ),
//          ],
//        ),
//        Container(
//          child: ListView.builder(
//            shrinkWrap: true,
//            primary: false,
//            itemCount: widget.choices.length,
//            itemBuilder: (context, index) {
//              return ListTile(
//                title: Text(widget.choices[index]),
//                trailing: IconButton(
//                  icon: Icon(
//                    Icons.cancel,
//                  ),
//                  onPressed: () {
//                    setState(() {
//                      widget.choices.removeAt(index);
//                    });
//                  },
//                ),
//              );
//            },
//          ),
//        ),
//      ],
//    );
//  }
//}

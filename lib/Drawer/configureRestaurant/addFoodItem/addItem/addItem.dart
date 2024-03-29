//import 'package:flutter/material.dart';
//import 'package:manager_app/Drawer/configureRestaurant/addFoodItem/ViewItem/viewItem.dart';
//import 'package:manager_app/Drawer/configureRestaurant/addFoodItem/addItem/addOns.dart';
//import 'package:manager_app/Drawer/configureRestaurant/addFoodItem/addItem/choices.dart';
//import 'package:manager_app/Drawer/configureRestaurant/addFoodItem/addItem/options.dart';
//import 'package:manager_app/constants.dart';
//import 'package:manager_app/data.dart';
//import 'package:manager_app/fetchData/configureRestaurantData.dart';
//import 'package:provider/provider.dart';
//
//class AddItem extends StatefulWidget {
//  final Category category;
//
//  final menuType;
//  AddItem({
//    this.category,
//    this.menuType,
//  });
//  @override
//  _AddFoodItemState createState() => _AddFoodItemState();
//}
//
//class _AddFoodItemState extends State<AddItem> {
//  Map<String, dynamic> foodTemp = {};
//  List<String> choices = [];
//  List<Map<String, dynamic>> options = [];
//  List<Map<String, dynamic>> addOns = [];
//  List<String> editChoices = [];
//  Map<String, String> editOptions;
//  bool optionsCheckBoxValue = false;
//  bool choicesCheckBoxValue = false;
//  bool addOnCheckBoxValue = false;
//  final itemNameController = TextEditingController();
//  final descriptionController = TextEditingController();
//  final priceController = TextEditingController();
//  final addOnsPriceController = TextEditingController();
//  final foodOptionController = TextEditingController();
//  final addOnsController = TextEditingController();
//  final foodChoiceController = TextEditingController();
//
//  final FocusNode itemNameFocus = FocusNode();
//  final FocusNode descriptionFocus = FocusNode();
//  final FocusNode priceFocus = FocusNode();
//  final FocusNode foodOptionFocus = FocusNode();
//  final FocusNode addOnsFocus = FocusNode();
//  final FocusNode foodChoiceFocus = FocusNode();
//
//  _fieldFocusChange(
//      BuildContext context, FocusNode currentFocus, FocusNode nextFocus) {
//    currentFocus.unfocus();
//    FocusScope.of(context).requestFocus(nextFocus);
//  }
//
//  confirmItem(restaurantData) {
//    setState(() {
//      foodTemp = {
//        "category_id": widget.category.oid,
//        "category_type": widget.menuType,
//        "food_dict": {
//          "name": itemNameController.text,
//          "description": descriptionController.text,
//          "price": priceController.text,
//          "food_options": {
//            "options": options,
//            "choices": choices,
////            "add_ons": addOns,
//          }
//        },
//      };
//    });
//
//    restaurantData.sendConfiguredDataToBackend(foodTemp, "add_food_item");
//
//    itemNameController.clear();
//    descriptionController.clear();
//    priceController.clear();
//    foodOptionController.clear();
//    foodChoiceController.clear();
//    foodTemp.clear();
//    options.clear();
//    choices.clear();
//    addOns.clear();
//  }
//
//  Widget _addItemLayout() {
//    if (optionsCheckBoxValue ||
//        addOnCheckBoxValue ||
//        choicesCheckBoxValue == true) {
//      if (optionsCheckBoxValue == true &&
//          addOnCheckBoxValue == true &&
//          choicesCheckBoxValue == true) {
//        // all options, choice and add-ons
////todo: replace options with add-on
//        return Column(
//          children: <Widget>[
//            Choices(
//              foodChoiceController: foodChoiceController,
//              priceController: priceController,
//              foodChoiceFocus: foodChoiceFocus,
//              choices: choices,
//            ),
//            Options(
//              priceController: priceController,
//              foodOptionController: foodOptionController,
//              foodOptionFocus: foodOptionFocus,
//              options: options,
//            ),
//            AddOns(
//              addOnsPriceController: addOnsPriceController,
//              addOnsController: addOnsController,
//              addOnsFocus: addOnsFocus,
//              addOns: addOns,
//            ),
//          ],
//        );
//      }
//      if (optionsCheckBoxValue == true &&
//          addOnCheckBoxValue == true &&
//          choicesCheckBoxValue == false) {
//        print("coming here 1");
//        return Column(
//          children: <Widget>[
//            Options(
//              priceController: priceController,
//              foodOptionController: foodOptionController,
//              foodOptionFocus: foodOptionFocus,
//              options: options,
//            ),
//            AddOns(
//              addOnsPriceController: addOnsPriceController,
//              addOnsController: addOnsController,
//              addOnsFocus: addOnsFocus,
//              addOns: addOns,
//            ),
//          ],
//        );
//      }
//      if (choicesCheckBoxValue == true &&
//          (optionsCheckBoxValue == true || addOnCheckBoxValue == true)) {
//        if (choicesCheckBoxValue == true &&
//            optionsCheckBoxValue == true &&
//            addOnCheckBoxValue == false) {
//          // both choice and option
//
//          return Column(
//            children: <Widget>[
//              Choices(
//                foodChoiceController: foodChoiceController,
//                priceController: priceController,
//                foodChoiceFocus: foodChoiceFocus,
//                choices: choices,
//              ),
//              Options(
//                priceController: priceController,
//                foodOptionController: foodOptionController,
//                foodOptionFocus: foodOptionFocus,
//                options: options,
//              ),
//            ],
//          );
//        }
//
//        if (choicesCheckBoxValue == true &&
//            addOnCheckBoxValue == true &&
//            optionsCheckBoxValue == false) {
//          // both choice and add-ons
////todo: replace options with add-on
//          return Column(
//            children: <Widget>[
//              Choices(
//                foodChoiceController: foodChoiceController,
//                priceController: priceController,
//                foodChoiceFocus: foodChoiceFocus,
//                choices: choices,
//              ),
//              AddOns(
//                addOnsPriceController: addOnsPriceController,
//                addOnsController: addOnsController,
//                addOnsFocus: addOnsFocus,
//                addOns: addOns,
//              ),
//            ],
//          );
//        }
//      } else if (choicesCheckBoxValue == true &&
//          optionsCheckBoxValue == false &&
//          addOnCheckBoxValue == false) {
//        //only choices
//        return Row(
//          crossAxisAlignment: CrossAxisAlignment.start,
//          children: <Widget>[
//            Expanded(
//              flex: 2,
//              child: Container(
//                padding: EdgeInsets.all(12),
//                child: TextFormField(
//                  controller: priceController,
//                  focusNode: priceFocus,
//                  decoration: InputDecoration(
//                    labelText: "Price",
//                    fillColor: Colors.white,
//                    border: OutlineInputBorder(
//                      borderRadius: BorderRadius.circular(12.0),
//                    ),
//                    //fillColor: Colors.green
//                  ),
//                  keyboardType: TextInputType.text,
//                  validator: (value) {
//                    if (value.isEmpty) {
//                      return 'Please enter Price';
//                    }
//                    return null;
//                  },
//                ),
//              ),
//            ),
//            Expanded(
//              flex: 3,
//              child: Choices(
//                foodChoiceController: foodChoiceController,
//                priceController: priceController,
//                foodChoiceFocus: foodChoiceFocus,
//                choices: choices,
//              ),
//            ),
//          ],
//        );
//      }
//      if (optionsCheckBoxValue == true && choicesCheckBoxValue == false) {
//        //options without choice
//        return Options(
//          priceController: priceController,
//          foodOptionController: foodOptionController,
//          foodOptionFocus: foodOptionFocus,
//          options: options,
//        );
//      }
//      if (addOnCheckBoxValue == true && choicesCheckBoxValue == false) {
//        //add-ons without choice
////todo: replace options with add-on
//        return AddOns(
//          addOnsPriceController: addOnsPriceController,
//          addOnsController: addOnsController,
//          addOnsFocus: addOnsFocus,
//          addOns: addOns,
//        );
//      }
//    } else {
//      //only food item without choices, options, and add-ons
//      return Row(
//        children: <Widget>[
//          Expanded(
//            child: Container(
//              padding: EdgeInsets.all(12),
//              child: TextFormField(
//                controller: priceController,
//                focusNode: priceFocus,
//                decoration: InputDecoration(
//                  labelText: "Price",
//                  fillColor: Colors.white,
//                  border: OutlineInputBorder(
//                    borderRadius: BorderRadius.circular(12.0),
//                  ),
//                  //fillColor: Colors.green
//                ),
//                keyboardType: TextInputType.text,
//                validator: (value) {
//                  if (value.isEmpty) {
//                    return 'Please enter Price';
//                  }
//                  return null;
//                },
//              ),
//            ),
//          ),
//        ],
//      );
//    }
//  }
//
//  @override
//  Widget build(BuildContext context) {
//    final RestaurantData restaurantData = Provider.of<RestaurantData>(context);
//
////    print("choices : $choices");
//    return SafeArea(
//      child: Scaffold(
//        appBar: AppBar(
//          backgroundColor: kThemeColor,
//          title: Text(widget.category.name ?? " "),
//        ),
//        body: Container(
//          padding: EdgeInsets.symmetric(vertical: 12, horizontal: 18),
//          color: Color(0xffE0EAF0),
//          child: Card(
//            color: Color(0xffE5EDF1),
//            shape: RoundedRectangleBorder(
//              borderRadius: BorderRadius.circular(20.0),
//            ),
//            child: Row(
//              crossAxisAlignment: CrossAxisAlignment.start,
//              children: <Widget>[
//                Expanded(
//                  child: SingleChildScrollView(
//                    child: Column(
//                      mainAxisAlignment: MainAxisAlignment.start,
//                      children: <Widget>[
//                        Row(
//                          mainAxisSize: MainAxisSize.min,
//                          children: <Widget>[
//                            Expanded(
//                              flex: 2,
//                              child: Container(
//                                padding: EdgeInsets.all(12),
//                                child: TextFormField(
//                                  controller: itemNameController,
//                                  textInputAction: TextInputAction.next,
//                                  focusNode: itemNameFocus,
//                                  onFieldSubmitted: (term) {
//                                    _fieldFocusChange(context, itemNameFocus,
//                                        descriptionFocus);
//                                  },
//                                  decoration: InputDecoration(
//                                    labelText: "Item Name",
//                                    fillColor: Colors.white,
//                                    border: OutlineInputBorder(
//                                      borderRadius: BorderRadius.circular(12.0),
//                                    ),
//                                    //fillColor: Colors.green
//                                  ),
//                                  keyboardType: TextInputType.text,
//                                  validator: (value) {
//                                    if (value.isEmpty) {
//                                      return 'Please enter item';
//                                    }
//                                    return null;
//                                  },
//                                ),
//                              ),
//                            ),
//                            Expanded(
//                              child: Container(
//                                child: Row(
//                                  mainAxisAlignment:
//                                      MainAxisAlignment.spaceEvenly,
//                                  children: <Widget>[
//                                    Column(
//                                      children: <Widget>[
//                                        Checkbox(
//                                          value: optionsCheckBoxValue,
//                                          onChanged: (bool value) {
//                                            setState(() {
//                                              optionsCheckBoxValue = value;
//                                            });
//                                          },
//                                        ),
//                                        Text('options'),
//                                      ],
//                                    ),
//                                    Column(
//                                      children: <Widget>[
//                                        Checkbox(
//                                          value: choicesCheckBoxValue,
//                                          onChanged: (bool value) {
//                                            setState(() {
//                                              choicesCheckBoxValue = value;
//                                            });
//                                          },
//                                        ),
//                                        Text('choice'),
//                                      ],
//                                    ),
////                                    Column(
////                                      children: <Widget>[
////                                        Checkbox(
////                                          value: addOnCheckBoxValue,
////                                          onChanged: (bool value) {
////                                            setState(() {
////                                              addOnCheckBoxValue = value;
////                                            });
////                                          },
////                                        ),
////                                        Text('add-on'),
////                                      ],
////                                    ),
//                                  ],
//                                ),
//                              ),
//                            ),
//                          ],
//                        ),
//                        Row(
//                          children: <Widget>[
//                            Expanded(
//                              child: Container(
//                                padding: EdgeInsets.all(12),
//                                child: TextFormField(
//                                  controller: descriptionController,
//                                  textInputAction: TextInputAction.next,
//                                  focusNode: descriptionFocus,
//                                  onFieldSubmitted: (term) {
//                                    if (optionsCheckBoxValue == true) {
//                                      _fieldFocusChange(context,
//                                          descriptionFocus, foodOptionFocus);
//                                    }
//                                    _fieldFocusChange(
//                                        context, descriptionFocus, priceFocus);
//                                  },
//                                  decoration: InputDecoration(
//                                    labelText: "Description",
//                                    fillColor: Colors.white,
//                                    border: OutlineInputBorder(
//                                      borderRadius: BorderRadius.circular(12.0),
//                                    ),
//                                    //fillColor: Colors.green
//                                  ),
//                                  keyboardType: TextInputType.text,
//                                  validator: (value) {
//                                    if (value.isEmpty) {
//                                      return 'Please enter Description';
//                                    }
//                                    return null;
//                                  },
//                                ),
//                              ),
//                            ),
//                          ],
//                        ),
//
//                        _addItemLayout(),
//
//                        FlatButton(
//                          child: Text('confirm item'),
//                          onPressed: () {
//                            confirmItem(restaurantData);
//                          },
//                        ),
//
//                        ////////////////////// to display food item present in the menu///////////////////
//                      ],
//                    ),
//                  ),
//                ),
//                VerticalDivider(
//                  thickness: 2,
//                  indent: 12,
//                  endIndent: 12,
//                ),
//                Expanded(
//                  child: widget.category.foodList != null
//                      ? ListView.builder(
//                          shrinkWrap: true,
//                          itemCount: widget.category.foodList.length,
//                          itemBuilder: (context, index) {
//                            return FlatButton(
//                              child: ListTile(
//                                title: Text(
//                                  widget.category.foodList[index].name,
//                                  style: kTitleStyle,
//                                ),
//                                subtitle: Text(
//                                  widget.category.foodList[index].description,
//                                  style: kSubTitleStyle,
//                                ),
//                                trailing: Row(
//                                  mainAxisSize: MainAxisSize.min,
//                                  children: <Widget>[
//                                    Container(
//                                      decoration: BoxDecoration(
//                                        shape: BoxShape.circle,
//                                        color: widget.category.foodList[index]
//                                                    .visibility ==
//                                                true
//                                            ? Colors.green
//                                            : Colors.red,
//                                      ),
//                                      height: 16,
//                                      width: 16,
//                                    ),
//                                    IconButton(
//                                      icon: Icon(Icons.cancel),
//                                      onPressed: () {
//                                        restaurantData
//                                            .sendConfiguredDataToBackend({
//                                          "category_type": widget.menuType,
//                                          "food_id": widget
//                                              .category.foodList[index].oid
//                                        }, "delete_food_item");
//                                      },
//                                    ),
//                                  ],
//                                ),
//                              ),
//                              onPressed: () {
//                                //////////////////////////////// view item ///////////////
//                                Navigator.push(
//                                  context,
//                                  MaterialPageRoute(
//                                    builder: (context) => ViewItem(
//                                      menuType: widget.menuType,
//                                      foodItem: widget.category.foodList[index],
//                                    ),
//                                  ),
//                                );
//                              },
//                            );
//                          },
//                        )
//                      : Text('no items'),
//                ),
//              ],
//            ),
//          ),
//        ),
//      ),
//    );
//  }
//}

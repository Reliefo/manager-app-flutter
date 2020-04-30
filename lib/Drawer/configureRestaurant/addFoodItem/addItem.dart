import 'package:adhara_socket_io_example/Drawer/configureRestaurant/addFoodItem/viewItem.dart';
import 'package:adhara_socket_io_example/data.dart';
import 'package:flutter/material.dart';

class AddItem extends StatefulWidget {
  final Category category;
  final updateConfigDetailsToCloud;
  final menuType;
  AddItem({
    this.category,
    this.updateConfigDetailsToCloud,
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

  confirmItem() {
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

    widget.updateConfigDetailsToCloud(foodTemp, "add_food_item");

    itemNameController.clear();
    descriptionController.clear();
    priceController.clear();
    foodOptionController.clear();
    foodChoiceController.clear();
    foodTemp.clear();
    options.clear();
    choices.clear();
  }

//  sendEditFields(index) {
//    if (true) {
//      widget.updateConfigDetailsToCloud({
//        "food_id": widget.category.foodList[index].oid,
//        "category_type": widget.menuType,
//        "food_dict": {
//          "name": _itemNameEditController.text,
//          "description": _descriptionEditController.text,
//          "food_options": {"options": editOptions, "choices": editChoices}
//        },
//      }, "edit_food_item");
//    } else if (editOptions.isNotEmpty && editChoices.isEmpty) {
//      widget.updateConfigDetailsToCloud({
//        "food_id": widget.category.foodList[index].oid,
//        "category_type": widget.menuType,
//        "food_dict": {
//          "name": _itemNameEditController.text,
//          "description": _descriptionEditController.text,
//          "food_options": {"options": editOptions}
//        },
//      }, "edit_food_item");
//    } else if (editChoices.isNotEmpty && editOptions.isEmpty) {
//      widget.updateConfigDetailsToCloud({
//        "food_id": widget.category.foodList[index].oid,
//        "category_type": widget.menuType,
//        "food_dict": {
//          "name": _itemNameEditController.text,
//          "description": _descriptionEditController.text,
//          "price": _priceEditController.text,
//          "food_options": {"choices": editChoices}
//        },
//      }, "edit_food_item");
//    } else {
//      widget.updateConfigDetailsToCloud({
//        "food_id": widget.category.foodList[index].oid,
//        "category_type": widget.menuType,
//        "food_dict": {
//          "name": _itemNameEditController.text,
//          "description": _descriptionEditController.text,
//          "price": _priceEditController.text,
//        },
//      }, "edit_food_item");
//    }
//  }

  @override
  Widget build(BuildContext context) {
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
            child: Column(
              children: <Widget>[
                Row(
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
                            _fieldFocusChange(
                                context, itemNameFocus, descriptionFocus);
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
                      flex: 2,
                      child: Container(
                        padding: EdgeInsets.all(12),
                        child: TextFormField(
                          controller: descriptionController,
                          textInputAction: TextInputAction.next,
                          focusNode: descriptionFocus,
                          onFieldSubmitted: (term) {
                            if (optionsCheckBoxValue == true) {
                              _fieldFocusChange(
                                  context, descriptionFocus, foodOptionFocus);
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
                    Expanded(
                      child: Container(
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
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
                optionsCheckBoxValue && choicesCheckBoxValue == true

                    ///// when both are true////////
                    ? Column(
                        children: <Widget>[
                          Options(
                            priceController: priceController,
                            foodOptionController: foodOptionController,
                            foodOptionFocus: foodOptionFocus,
                            options: options,
                          ),
                          Choices(
                            foodChoiceController: foodChoiceController,
                            priceController: priceController,
                            foodChoiceFocus: foodChoiceFocus,
                            choices: choices,
                          ),
                        ],
                      )
                    : optionsCheckBoxValue || choicesCheckBoxValue == true
                        ? optionsCheckBoxValue == true
                            ?
                            //////////for options///////////////////
                            Options(
                                priceController: priceController,
                                foodOptionController: foodOptionController,
                                foodOptionFocus: foodOptionFocus,
                                options: options,
                              )

                            //////for Choices/////////////////////////
                            : Row(
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
                  onPressed: confirmItem,
                ),

                ////////////////////// to display food item present in the menu///////////////////

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
//                                    IconButton(
//                                      icon: Icon(Icons.edit),
//                                      onPressed: () {
//                                        //todo: navigate to edit page
//
//                                        Navigator.push(
//                                          context,
//                                          MaterialPageRoute(
//                                            builder: (context) => EditItem(
//                                              foodItem: widget
//                                                  .category.foodList[index],
//                                            ),
//                                          ),
//                                        );
//                                      },
//                                    ),
                                    IconButton(
                                      icon: Icon(Icons.cancel),
                                      onPressed: () {
                                        widget.updateConfigDetailsToCloud({
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
                                        updateConfigDetailsToCloud:
                                            widget.updateConfigDetailsToCloud,
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
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}

class Options extends StatelessWidget {
  final foodOptionController;
  final priceController;
  final FocusNode foodOptionFocus;
  final List<Map<String, dynamic>> options;
  Options({
    @required this.foodOptionController,
    @required this.priceController,
    @required this.foodOptionFocus,
    @required this.options,
  });
  @override
  Widget build(BuildContext context) {
    return Row(children: <Widget>[
      Expanded(
        flex: 2,
        child: Container(
          padding: EdgeInsets.all(12),
          child: TextFormField(
            controller: foodOptionController,
            focusNode: foodOptionFocus,
            decoration: InputDecoration(
              labelText: "option",
              fillColor: Colors.white,
              border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(12.0),
              ),
            ),
            keyboardType: TextInputType.text,
            validator: (value) {
              if (value.isEmpty) {
                return 'Please enter option';
              }
              return null;
            },
          ),
        ),
      ),
      Expanded(
        flex: 2,
        child: Container(
          padding: EdgeInsets.all(12),
          child: TextFormField(
            controller: priceController,
            decoration: InputDecoration(
              labelText: "price ex: 120/230",
              fillColor: Colors.white,
              border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(12.0),
              ),
              //fillColor: Colors.green
            ),
            keyboardType: TextInputType.text,
            validator: (value) {
              if (value.isEmpty) {
                return 'Please enter price';
              }
              return null;
            },
          ),
        ),
      ),
      Expanded(
        child: FlatButton(
            child: Text('add option'),
            onPressed: () {
              options.add({
                "option_name": foodOptionController.text,
                "option_price": priceController.text
              });

              foodOptionController.clear();
              priceController.clear();
            }),
      )
    ]);
  }
}

class Choices extends StatelessWidget {
  final foodChoiceController;
  final priceController;
  final FocusNode foodChoiceFocus;
  final List<String> choices;
  Choices({
    @required this.foodChoiceController,
    @required this.priceController,
    @required this.foodChoiceFocus,
    @required this.choices,
  });
  @override
  Widget build(BuildContext context) {
    return Row(
      children: <Widget>[
//        Expanded(
//          flex: 2,
//          child: Container(
//            padding: EdgeInsets.all(12),
//            child: TextFormField(
//              controller: priceController,
//              decoration: InputDecoration(
//                labelText: "price",
//                fillColor: Colors.white,
//                border: OutlineInputBorder(
//                  borderRadius: BorderRadius.circular(12.0),
//                ),
//                //fillColor: Colors.green
//              ),
//              keyboardType: TextInputType.text,
//              validator: (value) {
//                if (value.isEmpty) {
//                  return 'Please enter price';
//                }
//                return null;
//              },
//            ),
//          ),
//        ),
        Expanded(
          flex: 2,
          child: Container(
            padding: EdgeInsets.all(12),
            child: TextFormField(
              controller: foodChoiceController,
              focusNode: foodChoiceFocus,
              decoration: InputDecoration(
                labelText: "choice",
                fillColor: Colors.white,
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(12.0),
                ),
                //fillColor: Colors.green
              ),
              keyboardType: TextInputType.text,
              validator: (value) {
                if (value.isEmpty) {
                  return 'Please enter option';
                }
                return null;
              },
            ),
          ),
        ),
        Expanded(
          child: FlatButton(
              child: Text('add choice'),
              onPressed: () {
                choices.add(foodChoiceController.text);
                foodChoiceController.clear();
              }),
        )
      ],
    );
  }
}

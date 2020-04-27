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

  final _itemNameEditController = TextEditingController();
  final _descriptionEditController = TextEditingController();
  final _priceEditController = TextEditingController();
  final _foodOptionEditController = TextEditingController();
  final _foodChoiceEditController = TextEditingController();

  _fieldFocusChange(
      BuildContext context, FocusNode currentFocus, FocusNode nextFocus) {
    currentFocus.unfocus();
    FocusScope.of(context).requestFocus(nextFocus);
  }

  Map<String, dynamic> foodTemp = {};
  List<String> choices = [];
  Map<String, String> options = {};
  @override
  Widget build(BuildContext context) {
    print("add item");
    print(options);
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
                  onPressed: () {
                    setState(() {
                      foodTemp = {
                        "category_id": widget.category.oid,
                        "category_type": widget.menuType,
                        "food_dict": {
                          "name": itemNameController.text,
                          "description": descriptionController.text,
                          "price": priceController.text,
                          "food_options": {
                            "options": options,
                            "choices": choices
                          }
                        },
                      };
                    });

                    widget.updateConfigDetailsToCloud(
                        foodTemp, "add_food_item");

                    itemNameController.clear();
                    descriptionController.clear();
                    priceController.clear();
                    foodOptionController.clear();
                    foodChoiceController.clear();
                  },
                ),

                ////////////////////// to display food item present in the menu///////////////////

                Expanded(
                  child: widget.category.foodList != null
                      ? ListView.builder(
                          shrinkWrap: true,
                          itemCount: widget.category.foodList.length,
                          itemBuilder: (context, index) {
                            return ListTile(
                              title: Text(widget.category.foodList[index].name),
                              subtitle: Text(
                                  widget.category.foodList[index].description),
                              trailing: Row(
                                mainAxisSize: MainAxisSize.min,
                                children: <Widget>[
//                                  IconButton(
//                                    icon: Icon(Icons.edit),
//                                    onPressed: () {
//                                      _itemNameEditController.text =
//                                          widget.category.foodList[index].name;
//
//                                      _descriptionEditController.text = widget
//                                          .category.foodList[index].description;
//                                      showBottomSheet(
//                                          context: context,
////                                          shape: RoundedRectangleBorder(
////                                            borderRadius: BorderRadius.vertical(
////                                                top: Radius.circular(25.0)),
////                                          ),
//                                          builder: (BuildContext context) {
//                                            return Container(
//                                              child: Column(
////                                                mainAxisSize: MainAxisSize
////                                                    .min, // To make the card compact
//
//                                                children: <Widget>[
//                                                  Row(
//                                                    children: <Widget>[
//                                                      Text(
//                                                        "Item Name : ",
//                                                        textAlign:
//                                                            TextAlign.center,
//                                                        style: TextStyle(
//                                                          fontSize: 16.0,
//                                                        ),
//                                                      ),
//                                                      SizedBox(width: 20),
//                                                      Container(
//                                                        width: 200,
//                                                        child: TextField(
//                                                          controller:
//                                                              _itemNameEditController,
//                                                          autofocus: true,
//                                                        ),
//                                                      ),
//                                                    ],
//                                                  ),
//                                                  SizedBox(height: 16.0),
//                                                  Row(
//                                                    mainAxisAlignment:
//                                                        MainAxisAlignment
//                                                            .spaceBetween,
//                                                    children: <Widget>[
//                                                      Text(
//                                                        "Description : ",
//                                                        textAlign:
//                                                            TextAlign.center,
//                                                        style: TextStyle(
//                                                          fontSize: 16.0,
//                                                        ),
//                                                      ),
//                                                      SizedBox(width: 20),
//                                                      Expanded(
//                                                        child: TextField(
//                                                          controller:
//                                                              _descriptionEditController,
//                                                        ),
//                                                      ),
//                                                    ],
//                                                  ),
//                                                  SizedBox(height: 16.0),
//                                                  Row(
//                                                    mainAxisAlignment:
//                                                        MainAxisAlignment
//                                                            .spaceBetween,
//                                                    children: <Widget>[
//                                                      Text(
//                                                        "option : ",
//                                                        textAlign:
//                                                            TextAlign.center,
//                                                        style: TextStyle(
//                                                          fontSize: 16.0,
//                                                        ),
//                                                      ),
//                                                      SizedBox(width: 20),
//                                                      Expanded(
//                                                        child: TextField(
//                                                          controller:
//                                                              _descriptionEditController,
//                                                        ),
//                                                      ),
//                                                    ],
//                                                  ),
//                                                  SizedBox(height: 16.0),
//                                                  Row(
//                                                    mainAxisAlignment:
//                                                        MainAxisAlignment
//                                                            .spaceBetween,
//                                                    children: <Widget>[
//                                                      Text(
//                                                        "Description : ",
//                                                        textAlign:
//                                                            TextAlign.center,
//                                                        style: TextStyle(
//                                                          fontSize: 16.0,
//                                                        ),
//                                                      ),
//                                                      SizedBox(width: 20),
//                                                      Expanded(
//                                                        child: TextField(
//                                                          controller:
//                                                              _descriptionEditController,
//                                                        ),
//                                                      ),
//                                                    ],
//                                                  ),
//                                                  SizedBox(height: 16.0),
//                                                  Row(
//                                                    children: <Widget>[
//                                                      Text(
//                                                        "Item Name : ",
//                                                        textAlign:
//                                                            TextAlign.center,
//                                                        style: TextStyle(
//                                                          fontSize: 16.0,
//                                                        ),
//                                                      ),
//                                                      SizedBox(width: 20),
//                                                      Container(
//                                                        width: 200,
//                                                        child: TextField(
//                                                          controller:
//                                                              _itemNameEditController,
//                                                          autofocus: true,
//                                                        ),
//                                                      ),
//                                                    ],
//                                                  ),
//                                                  SizedBox(height: 24.0),
//                                                  Row(
//                                                    mainAxisAlignment:
//                                                        MainAxisAlignment
//                                                            .spaceAround,
//                                                    children: <Widget>[
//                                                      FlatButton(
//                                                        onPressed: () {
//                                                          Navigator.of(context)
//                                                              .pop(); // To close the dialog
//                                                        },
//                                                        child: Text(
//                                                          "Cancel",
//                                                          style: TextStyle(
//                                                              color:
//                                                                  Colors.red),
//                                                        ),
//                                                      ),
//                                                      FlatButton(
//                                                        onPressed: () {
//                                                          Navigator.of(context)
//                                                              .pop(); // To close the dialog
//                                                        },
//                                                        child: Text(
//                                                          "Done",
//                                                          style: TextStyle(
//                                                              color:
//                                                                  Colors.green),
//                                                        ),
//                                                      ),
//                                                    ],
//                                                  )
//                                                ],
//                                              ),
//                                            );
//                                          });
//                                    },
//                                  ),
                                  IconButton(
                                    icon: Icon(Icons.cancel),
                                    onPressed: () {
                                      widget.updateConfigDetailsToCloud({
                                        "category_type": widget.menuType,
                                        "food_id":
                                            widget.category.foodList[index].oid
                                      }, "delete_food_item");
                                    },
                                  ),
                                ],
                              ),
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
  final Map<String, String> options;
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
              options["${foodOptionController.text}"] =
                  "${priceController.text}";
//                  .add({"${foodOptionController.text}": priceController.text});
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

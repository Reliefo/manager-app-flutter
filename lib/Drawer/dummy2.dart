//import 'package:adhara_socket_io_example/data.dart';
//import 'package:flutter/material.dart';
//
//class AddItem extends StatefulWidget {
//  final Category category;
//  final updateConfigDetailsToCloud;
//  final menuType;
//  AddItem({
//    this.category,
//    this.updateConfigDetailsToCloud,
//    this.menuType,
//  });
//  @override
//  _AddFoodItemState createState() => _AddFoodItemState();
//}
//
//class _AddFoodItemState extends State<AddItem> {
//  bool optionsCheckBoxValue = false;
//  bool choicesCheckBoxValue = false;
//  final itemNameController = TextEditingController();
//  final descriptionController = TextEditingController();
//  final priceController = TextEditingController();
//  final foodOptionController = TextEditingController();
//  final foodChoiceController = TextEditingController();
//
//  Map<String, dynamic> foodTemp = {};
//  List<String> choices = [];
//  List<Map<String, String>> options = [];
//  @override
//  Widget build(BuildContext context) {
//    print(' check here');
////    print(options);
//
//    print(foodTemp);
//    return SafeArea(
//      child: Scaffold(
//        appBar: AppBar(
//          backgroundColor: Colors.grey,
//          title: Text(widget.category.name),
//        ),
//        body: Container(
//          padding: EdgeInsets.symmetric(vertical: 12, horizontal: 18),
//          color: Color(0xffE0EAF0),
//          child: Card(
//            color: Color(0xffE5EDF1),
//            shape: RoundedRectangleBorder(
//              borderRadius: BorderRadius.circular(20.0),
//            ),
//            child: Column(
//              children: <Widget>[
//                Row(
//                  children: <Widget>[
//                    Expanded(
//                      flex: 2,
//                      child: Container(
//                        padding: EdgeInsets.all(12),
//                        child: TextFormField(
//                          controller: itemNameController,
//                          decoration: InputDecoration(
//                            labelText: "Item Name",
//                            fillColor: Colors.white,
//                            border: OutlineInputBorder(
//                              borderRadius: BorderRadius.circular(12.0),
//                            ),
//                            //fillColor: Colors.green
//                          ),
//                          keyboardType: TextInputType.text,
//                          validator: (value) {
//                            if (value.isEmpty) {
//                              return 'Please enter item';
//                            }
//                            return null;
//                          },
//                        ),
//                      ),
//                    ),
//                    Expanded(
//                      flex: 2,
//                      child: Container(
//                        padding: EdgeInsets.all(12),
//                        child: TextFormField(
//                          controller: descriptionController,
//                          decoration: InputDecoration(
//                            labelText: "Description",
//                            fillColor: Colors.white,
//                            border: OutlineInputBorder(
//                              borderRadius: BorderRadius.circular(12.0),
//                            ),
//                            //fillColor: Colors.green
//                          ),
//                          keyboardType: TextInputType.text,
//                          validator: (value) {
//                            if (value.isEmpty) {
//                              return 'Please enter Description';
//                            }
//                            return null;
//                          },
//                        ),
//                      ),
//                    ),
//                    Expanded(
//                      child: Container(
//                        child: Row(
//                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
//                          children: <Widget>[
//                            Column(
//                              children: <Widget>[
//                                Checkbox(
//                                  value: optionsCheckBoxValue,
//                                  onChanged: (bool value) {
//                                    setState(() {
//                                      optionsCheckBoxValue = value;
//                                    });
//                                  },
//                                ),
//                                Text('have options'),
//                              ],
//                            ),
//                            Column(
//                              children: <Widget>[
//                                Checkbox(
//                                  value: choicesCheckBoxValue,
//                                  onChanged: (bool value) {
//                                    setState(() {
//                                      choicesCheckBoxValue = value;
//                                    });
//                                  },
//                                ),
//                                Text('have choice'),
//                              ],
//                            ),
//                          ],
//                        ),
//                      ),
//                    ),
//                  ],
//                ),
//                optionsCheckBoxValue && choicesCheckBoxValue == true
//
//                    ///// when both are true////////
//                    ? Column(
//                        children: <Widget>[
//                          Row(
//                            children: <Widget>[
//                              Expanded(
//                                flex: 2,
//                                child: Container(
//                                  padding: EdgeInsets.all(12),
//                                  child: TextFormField(
//                                    controller: foodOptionController,
//                                    decoration: InputDecoration(
//                                      labelText: "option",
//                                      fillColor: Colors.white,
//                                      border: OutlineInputBorder(
//                                        borderRadius:
//                                            BorderRadius.circular(12.0),
//                                      ),
//                                      //fillColor: Colors.green
//                                    ),
//                                    keyboardType: TextInputType.text,
//                                    validator: (value) {
//                                      if (value.isEmpty) {
//                                        return 'Please enter option';
//                                      }
//                                      return null;
//                                    },
//                                  ),
//                                ),
//                              ),
//                              Expanded(
//                                flex: 2,
//                                child: Container(
//                                  padding: EdgeInsets.all(12),
//                                  child: TextFormField(
//                                    controller: priceController,
//                                    decoration: InputDecoration(
//                                      labelText: "price",
//                                      fillColor: Colors.white,
//                                      border: OutlineInputBorder(
//                                        borderRadius:
//                                            BorderRadius.circular(12.0),
//                                      ),
//                                      //fillColor: Colors.green
//                                    ),
//                                    keyboardType: TextInputType.text,
//                                    validator: (value) {
//                                      if (value.isEmpty) {
//                                        return 'Please enter price';
//                                      }
//                                      return null;
//                                    },
//                                  ),
//                                ),
//                              ),
//                              Expanded(
//                                child: FlatButton(
//                                    child: Text('add option'),
//                                    onPressed: () {
//                                      setState(() {
//                                        options.add({
//                                          "${foodOptionController.text}":
//                                              priceController.text
//                                        });
//                                      });
//                                    }),
//                              )
//                            ],
//                          ),
//                          Row(
//                            children: <Widget>[
//                              Expanded(
//                                flex: 2,
//                                child: Container(
//                                  padding: EdgeInsets.all(12),
//                                  child: TextFormField(
//                                    controller: foodChoiceController,
//                                    decoration: InputDecoration(
//                                      labelText: "choice",
//                                      fillColor: Colors.white,
//                                      border: OutlineInputBorder(
//                                        borderRadius:
//                                            BorderRadius.circular(12.0),
//                                      ),
//                                      //fillColor: Colors.green
//                                    ),
//                                    keyboardType: TextInputType.text,
//                                    validator: (value) {
//                                      if (value.isEmpty) {
//                                        return 'Please enter option';
//                                      }
//                                      return null;
//                                    },
//                                  ),
//                                ),
//                              ),
//                              Expanded(
//                                child: FlatButton(
//                                    child: Text('add choice'),
//                                    onPressed: () {
//                                      setState(() {
//                                        choices.add(foodChoiceController.text);
//                                      });
//                                    }),
//                              )
//                            ],
//                          )
//                        ],
//                      )
//                    : optionsCheckBoxValue || choicesCheckBoxValue == true
//                        ? Row(
//                            children: optionsCheckBoxValue == true
//
//                                //////////for options///////////////////
//                                ? <Widget>[
//                                    Expanded(
//                                      flex: 2,
//                                      child: Container(
//                                        padding: EdgeInsets.all(12),
//                                        child: TextFormField(
//                                          controller: foodOptionController,
//                                          decoration: InputDecoration(
//                                            labelText: "option",
//                                            fillColor: Colors.white,
//                                            border: OutlineInputBorder(
//                                              borderRadius:
//                                                  BorderRadius.circular(12.0),
//                                            ),
//                                            //fillColor: Colors.green
//                                          ),
//                                          keyboardType: TextInputType.text,
//                                          validator: (value) {
//                                            if (value.isEmpty) {
//                                              return 'Please enter option';
//                                            }
//                                            return null;
//                                          },
//                                        ),
//                                      ),
//                                    ),
//                                    Expanded(
//                                      flex: 2,
//                                      child: Container(
//                                        padding: EdgeInsets.all(12),
//                                        child: TextFormField(
//                                          controller: priceController,
//                                          decoration: InputDecoration(
//                                            labelText: "price ex: 120/230",
//                                            fillColor: Colors.white,
//                                            border: OutlineInputBorder(
//                                              borderRadius:
//                                                  BorderRadius.circular(12.0),
//                                            ),
//                                            //fillColor: Colors.green
//                                          ),
//                                          keyboardType: TextInputType.text,
//                                          validator: (value) {
//                                            if (value.isEmpty) {
//                                              return 'Please enter price';
//                                            }
//                                            return null;
//                                          },
//                                        ),
//                                      ),
//                                    ),
//                                    Expanded(
//                                      child: FlatButton(
//                                          child: Text('add option'),
//                                          onPressed: () {
//                                            setState(() {
//                                              options.add({
//                                                "${foodOptionController.text}":
//                                                    priceController.text
//                                              });
//                                            });
//                                          }),
//                                    )
//                                  ]
//
//                                //////for Choices/////////////////////////
//                                : <Widget>[
//                                    Expanded(
//                                      flex: 2,
//                                      child: Container(
//                                        padding: EdgeInsets.all(12),
//                                        child: TextFormField(
//                                          controller: priceController,
//                                          decoration: InputDecoration(
//                                            labelText: "price",
//                                            fillColor: Colors.white,
//                                            border: OutlineInputBorder(
//                                              borderRadius:
//                                                  BorderRadius.circular(12.0),
//                                            ),
//                                            //fillColor: Colors.green
//                                          ),
//                                          keyboardType: TextInputType.text,
//                                          validator: (value) {
//                                            if (value.isEmpty) {
//                                              return 'Please enter price';
//                                            }
//                                            return null;
//                                          },
//                                        ),
//                                      ),
//                                    ),
//                                    Expanded(
//                                      flex: 2,
//                                      child: Container(
//                                        padding: EdgeInsets.all(12),
//                                        child: TextFormField(
//                                          controller: foodChoiceController,
//                                          decoration: InputDecoration(
//                                            labelText: "choice",
//                                            fillColor: Colors.white,
//                                            border: OutlineInputBorder(
//                                              borderRadius:
//                                                  BorderRadius.circular(12.0),
//                                            ),
//                                            //fillColor: Colors.green
//                                          ),
//                                          keyboardType: TextInputType.text,
//                                          validator: (value) {
//                                            if (value.isEmpty) {
//                                              return 'Please enter option';
//                                            }
//                                            return null;
//                                          },
//                                        ),
//                                      ),
//                                    ),
//                                    Expanded(
//                                      child: FlatButton(
//                                          child: Text('add choice'),
//                                          onPressed: () {
//                                            setState(() {
//                                              choices.add(
//                                                  foodChoiceController.text);
//                                            });
//                                          }),
//                                    )
//                                  ],
//                          )
//
//                        //////////////////////////////// if no options and choices///////////////////////////
//                        : Row(
//                            children: <Widget>[
//                              Expanded(
//                                child: Container(
//                                  padding: EdgeInsets.all(12),
//                                  child: TextFormField(
//                                    controller: priceController,
//                                    decoration: InputDecoration(
//                                      labelText: "Price",
//                                      fillColor: Colors.white,
//                                      border: OutlineInputBorder(
//                                        borderRadius:
//                                            BorderRadius.circular(12.0),
//                                      ),
//                                      //fillColor: Colors.green
//                                    ),
//                                    keyboardType: TextInputType.text,
//                                    validator: (value) {
//                                      if (value.isEmpty) {
//                                        return 'Please enter Price';
//                                      }
//                                      return null;
//                                    },
//                                  ),
//                                ),
//                              ),
//                            ],
//                          ),
//                FlatButton(
//                  child: Text('confirm item'),
//                  onPressed: () {
//                    setState(() {
//                      foodTemp = {
//                        "category_id": widget.category.oid,
//                        "category_type": widget.menuType,
//                        "food_dict": {
//                          "name": itemNameController.text,
//                          "description": descriptionController.text,
//                          "price": priceController.text,
//                          "food_options": {
//                            "options": options,
//                            "choices": choices
//                          }
//                        },
//                      };
//                    });
//
//                    widget.updateConfigDetailsToCloud(
//                        foodTemp, "add_food_item");
//                  },
//                ),
//
//                ////////////////////// to display food item present in the menu///////////////////
//
//                Expanded(
//                  child: widget.category.foodList != null
//                      ? ListView.builder(
//                          shrinkWrap: true,
//                          itemCount: widget.category.foodList.length,
//                          itemBuilder: (context, index) {
//                            return ListTile(
//                              title: Text(widget.category.foodList[index].name),
//                              subtitle: Text(
//                                  widget.category.foodList[index].description),
//                              trailing: IconButton(
//                                icon: Icon(Icons.cancel),
//                                onPressed: () {
//                                  widget.updateConfigDetailsToCloud({
//                                    "category_type": widget.menuType,
//                                    "food_id":
//                                        widget.category.foodList[index].oid
//                                  }, "delete_food_item");
//                                },
//                              ),
//                            );
//                          },
//                        )
//                      : Text('no items'),
//                )
//              ],
//            ),
//          ),
//        ),
//      ),
//    );
//  }
//}

import 'package:flutter/material.dart';
import 'package:manager_app/Drawer/configureRestaurant/addFoodItem/addItem/naddItem.dart';
import 'package:manager_app/constants.dart';
import 'package:manager_app/fetchData/configureRestaurantData.dart';
import 'package:provider/provider.dart';

class AddFoodMenu extends StatefulWidget {
  @override
  _AddFoodMenuState createState() => _AddFoodMenuState();
}

class _AddFoodMenuState extends State<AddFoodMenu> {
  final _categoryController = TextEditingController();
  final _descriptionController = TextEditingController();
  final _categoryEditController = TextEditingController();
  final _descriptionEditController = TextEditingController();

  final FocusNode _categoryFocus = FocusNode();
  final FocusNode _descriptionFocus = FocusNode();

  bool _categoryValidate = false;

  _fieldFocusChange(
      BuildContext context, FocusNode currentFocus, FocusNode nextFocus) {
    currentFocus.unfocus();
    FocusScope.of(context).requestFocus(nextFocus);
  }

  _addCategory(restaurantData) {
    print("coming here");
    setState(() {
      if (_categoryController.text.isNotEmpty) {
        _categoryValidate = false;

        restaurantData.sendConfiguredDataToBackend(
          {
            "name": _categoryController.text,
            "description": _descriptionController.text
          },
          "add_food_category",
        );

        _categoryController.clear();
        _descriptionController.clear();
      } else
        _categoryValidate = true;
    });
  }

  @override
  Widget build(BuildContext context) {
    final RestaurantData restaurantData = Provider.of<RestaurantData>(context);
//    print(widget.restaurant.foodMenu);
    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
          backgroundColor: kThemeColor,
          title: Text('Add Food Menu'),
        ),
        body: Container(
          padding: EdgeInsets.symmetric(vertical: 12, horizontal: 18),
          color: Color(0xffE0EAF0),
          child: Column(
            children: <Widget>[
              Row(
                children: <Widget>[
                  Expanded(
                    child: Container(
                      padding: EdgeInsets.all(12),
                      child: TextFormField(
                        controller: _categoryController,
                        textInputAction: TextInputAction.next,
                        focusNode: _categoryFocus,
                        onFieldSubmitted: (term) {
                          _fieldFocusChange(
                              context, _categoryFocus, _descriptionFocus);
                        },
                        decoration: InputDecoration(
                          labelText: "Category",
                          fillColor: Colors.white,
                          errorText: _categoryValidate
                              ? 'Value Can\'t Be Empty'
                              : null,
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(12.0),
                          ),
                          //fillColor: Colors.green
                        ),
                        keyboardType: TextInputType.text,
                      ),
                    ),
                  ),
                  Expanded(
                    child: Container(
                      padding: EdgeInsets.all(12),
                      child: TextFormField(
                        controller: _descriptionController,
                        focusNode: _descriptionFocus,
                        onFieldSubmitted: (value) {
                          _addCategory(restaurantData);
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
                  Container(
                    padding: EdgeInsets.all(8),
                    child: RaisedButton(
                      color: kThemeColor,
                      child: Text(
                        'Add',
                        style: kTitleStyle,
                      ),
                      onPressed: () {
                        _addCategory(restaurantData);
                      },
                    ),
                  ),
                ],
              ),
              Container(
                padding: EdgeInsets.symmetric(vertical: 20, horizontal: 22),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: <Widget>[
                    restaurantData.restaurant.tables == null
                        ? Text('No of Category :')
                        : Text(
                            'No of Category : ${restaurantData.restaurant.foodMenu.length} ',
                            style: kTitleStyle,
                          ),
                  ],
                ),
              ),
              Expanded(
                child: restaurantData.restaurant.foodMenu != null
                    ? GridView.builder(
                        itemCount: restaurantData.restaurant.foodMenu.length,
                        shrinkWrap: true,
                        gridDelegate: SliverGridDelegateWithMaxCrossAxisExtent(
                          mainAxisSpacing: 4.0,
                          crossAxisSpacing: 4.0,
                          childAspectRatio: (5),
                          maxCrossAxisExtent:
                              MediaQuery.of(context).size.width * 0.5,
                        ),
                        itemBuilder: (BuildContext context, index) {
                          return Container(
                            decoration: BoxDecoration(
                              color: Colors.white,
                              borderRadius: BorderRadius.all(
                                Radius.circular(15.0),
                              ),
                            ),
                            margin: EdgeInsets.all(4),
                            child: Row(
//                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: <Widget>[
                                Expanded(
                                  child: Padding(
                                    padding: const EdgeInsets.symmetric(
                                        vertical: 8.0),
                                    child: ListTile(
                                      title: Padding(
                                        padding:
                                            const EdgeInsets.only(bottom: 4.0),
                                        child: Text(
                                          restaurantData
                                              .restaurant.foodMenu[index].name,
                                          style: kTitleStyle,
                                        ),
                                      ),
                                      subtitle: Text(
                                        restaurantData.restaurant
                                            .foodMenu[index].description,
                                        style: kSubTitleStyle,
                                      ),
                                      onTap: () {
                                        Navigator.push(
                                          context,
                                          MaterialPageRoute(
                                            builder: (context) => NAddItem(
                                              category: restaurantData
                                                  .restaurant.foodMenu[index],
                                              menuType: "food",
                                            ),
                                          ),
                                        );
                                      },
                                    ),
                                  ),
                                ),
                                VerticalDivider(
                                  indent: 16,
                                  endIndent: 16,
                                ),
                                Column(
                                  mainAxisSize: MainAxisSize.min,
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: <Widget>[
                                    Expanded(
                                      child: FlatButton(
                                        child: Text(
                                          "Edit",
                                          style: kBlueButtonStyle,
                                        ),
                                        onPressed: () {
                                          _categoryEditController.text =
                                              restaurantData.restaurant
                                                  .foodMenu[index].name;

                                          _descriptionEditController.text =
                                              restaurantData.restaurant
                                                  .foodMenu[index].description;
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
                                                content: Column(
                                                  mainAxisSize: MainAxisSize
                                                      .min, // To make the card compact
                                                  children: <Widget>[
                                                    Row(
                                                      mainAxisAlignment:
                                                          MainAxisAlignment
                                                              .spaceBetween,
                                                      children: <Widget>[
                                                        Text(
                                                          "Category : ",
                                                          textAlign:
                                                              TextAlign.center,
                                                          style: kTitleStyle,
                                                        ),
                                                        SizedBox(width: 20),
                                                        Container(
                                                          width: 200,
                                                          child: TextField(
                                                            controller:
                                                                _categoryEditController,
                                                            autofocus: true,
                                                          ),
                                                        ),
                                                      ],
                                                    ),
                                                    SizedBox(height: 16.0),
                                                    Row(
                                                      mainAxisAlignment:
                                                          MainAxisAlignment
                                                              .spaceBetween,
                                                      children: <Widget>[
                                                        Text(
                                                          "Description : ",
                                                          textAlign:
                                                              TextAlign.center,
                                                          style: kTitleStyle,
                                                        ),
                                                        SizedBox(width: 20),
                                                        Container(
                                                          width: 200,
                                                          child: TextField(
                                                            controller:
                                                                _descriptionEditController,
                                                          ),
                                                        ),
                                                      ],
                                                    ),
                                                    SizedBox(height: 24.0),
                                                    Row(
                                                      mainAxisAlignment:
                                                          MainAxisAlignment
                                                              .spaceAround,
                                                      children: <Widget>[
                                                        FlatButton(
                                                          child: Text(
                                                            "Cancel",
                                                            style: TextStyle(
                                                                fontFamily:
                                                                    "Poppins",
                                                                color:
                                                                    Colors.red),
                                                          ),
                                                          onPressed: () {
                                                            Navigator.of(
                                                                    context)
                                                                .pop(); // To close the dialog
                                                          },
                                                        ),
                                                        FlatButton(
                                                          child: Text(
                                                            "Done",
                                                            style: TextStyle(
                                                                fontFamily:
                                                                    "Poppins",
                                                                color: Colors
                                                                    .green),
                                                          ),
                                                          onPressed: () {
                                                            if (_categoryEditController
                                                                .text
                                                                .isNotEmpty) {
                                                              restaurantData
                                                                  .sendConfiguredDataToBackend(
                                                                {
                                                                  "category_id":
                                                                      "${restaurantData.restaurant.foodMenu[index].oid}",
                                                                  "editing_fields":
                                                                      {
                                                                    "name":
                                                                        _categoryEditController
                                                                            .text,
                                                                    "description":
                                                                        _descriptionEditController
                                                                            .text
                                                                  }
                                                                },
                                                                "edit_food_category",
                                                              );
                                                            }

                                                            Navigator.of(
                                                                    context)
                                                                .pop(); // To close the dialog
                                                          },
                                                        ),
                                                      ],
                                                    )
                                                  ],
                                                ),
                                              );
                                            },
                                          );
                                        },
                                      ),
                                    ),
                                    Expanded(
                                      child: FlatButton(
                                        child: Text(
                                          "Delete",
                                          style: TextStyle(
                                              color: Colors.red,
                                              fontFamily: "Poppins"),
                                        ),
                                        onPressed: () {
                                          showDialog(
                                            context: context,
                                            builder: (BuildContext context) {
                                              // return object of type Dialog
                                              return AlertDialog(
                                                title: Text(
                                                    "Remove ${restaurantData.restaurant.foodMenu[index].name} Category ?"),
                                                content: new Text(
                                                  "This action will delete all items in this category",
                                                  style: kSubTitleStyle,
                                                ),
                                                actions: <Widget>[
                                                  // usually buttons at the bottom of the dialog
                                                  FlatButton(
                                                    child: Text("Close"),
                                                    onPressed: () {
                                                      Navigator.of(context)
                                                          .pop();
                                                    },
                                                  ),
                                                  FlatButton(
                                                    child: new Text(
                                                      "Delete",
                                                      style: TextStyle(
                                                          fontFamily: "Poppins",
                                                          color: Colors.red),
                                                    ),
                                                    onPressed: () {
                                                      restaurantData
                                                          .sendConfiguredDataToBackend(
                                                              restaurantData
                                                                  .restaurant
                                                                  .foodMenu[
                                                                      index]
                                                                  .oid,
                                                              "delete_food_category");

                                                      Navigator.of(context)
                                                          .pop();
                                                    },
                                                  ),
                                                ],
                                              );
                                            },
                                          );
                                        },
                                      ),
                                    ),
                                  ],
                                ),
                              ],
                            ),
                          );
                        })
                    : Center(
                        child: Text('category list is empty'),
                      ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

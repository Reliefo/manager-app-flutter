import 'package:adhara_socket_io_example/Drawer/configureRestaurant/addItem.dart';
import 'package:adhara_socket_io_example/data.dart';
import 'package:flutter/material.dart';

class AddBarMenu extends StatefulWidget {
  final Restaurant restaurant;
  final updateConfigDetailsToCloud;

  AddBarMenu({
    this.restaurant,
    this.updateConfigDetailsToCloud,
  });

  @override
  _AddMenuState createState() => _AddMenuState();
}

class _AddMenuState extends State<AddBarMenu> {
  final _categoryController = TextEditingController();
  final _descriptionController = TextEditingController();
  final _categoryEditController = TextEditingController();
  final _descriptionEditController = TextEditingController();
  final FocusNode _categoryFocus = FocusNode();
  final FocusNode _descriptionFocus = FocusNode();
  Map<String, String> categoryTemp = {};

  bool _categoryValidate = false;

  _fieldFocusChange(
      BuildContext context, FocusNode currentFocus, FocusNode nextFocus) {
    currentFocus.unfocus();
    FocusScope.of(context).requestFocus(nextFocus);
  }

  _addCategory() {
    setState(() {
      if (_categoryController.text.isNotEmpty) {
        _categoryValidate = false;
        categoryTemp = {
          "name": _categoryController.text,
          "description": _descriptionController.text
        };

        widget.updateConfigDetailsToCloud(categoryTemp, "add_bar_category");

        _categoryController.clear();
        _descriptionController.clear();

        categoryTemp.clear();
      } else
        _categoryValidate = true;
    });
  }

  @override
  Widget build(BuildContext context) {
//    print(widget.restaurant.foodMenu);
    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
          backgroundColor: Colors.grey,
          title: Text('Add Bar Menu'),
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
                            _addCategory();
                          },
                          decoration: InputDecoration(
                            labelText: "Description",
                            fillColor: Colors.white,
                            border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(12.0),
                            ),
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
                        color: Colors.grey,
                        child: Text('Add'),
                        onPressed: _addCategory,
                      ),
                    ),
                  ],
                ),
                Expanded(
                  child: widget.restaurant.barMenu != null
                      ? ListView.builder(
                          itemCount: widget.restaurant.barMenu.length,
                          shrinkWrap: true,
                          itemBuilder: (BuildContext context, index) {
                            return ListTile(
                              title:
                                  Text(widget.restaurant.barMenu[index].name),
                              subtitle: Text(
                                  widget.restaurant.barMenu[index].description),
                              trailing: Row(
                                mainAxisSize: MainAxisSize.min,
                                children: <Widget>[
                                  FlatButton(
                                    child: Text('Add Drinks'),
                                    onPressed: () {
                                      Navigator.push(
                                        context,
                                        MaterialPageRoute(
                                          builder: (context) => AddItem(
                                            category: widget
                                                .restaurant.barMenu[index],
                                            updateConfigDetailsToCloud: widget
                                                .updateConfigDetailsToCloud,
                                            menuType: "bar",
                                          ),
                                        ),
                                      );
                                    },
                                  ),
                                  IconButton(
                                    icon: Icon(Icons.edit),
                                    onPressed: () {
                                      _categoryEditController.text =
                                          widget.restaurant.barMenu[index].name;

                                      _descriptionEditController.text = widget
                                          .restaurant
                                          .barMenu[index]
                                          .description;
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
                                                      style: TextStyle(
                                                        fontSize: 16.0,
                                                      ),
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
                                                      style: TextStyle(
                                                        fontSize: 16.0,
                                                      ),
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
                                                      onPressed: () {
                                                        Navigator.of(context)
                                                            .pop(); // To close the dialog
                                                      },
                                                      child: Text(
                                                        "Cancel",
                                                        style: TextStyle(
                                                            color: Colors.red),
                                                      ),
                                                    ),
                                                    FlatButton(
                                                      onPressed: () {
                                                        Navigator.of(context)
                                                            .pop(); // To close the dialog
                                                      },
                                                      child: Text(
                                                        "Done",
                                                        style: TextStyle(
                                                            color:
                                                                Colors.green),
                                                      ),
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
                                  IconButton(
                                    icon: Icon(Icons.cancel),
                                    onPressed: () {
                                      showDialog(
                                        context: context,
                                        builder: (BuildContext context) {
                                          // return object of type Dialog
                                          return AlertDialog(
                                            title: Text(
                                                "Remove ${widget.restaurant.barMenu[index].name} Category ?"),
                                            content: new Text(
                                                "this will delete all items in this category"),
                                            actions: <Widget>[
                                              FlatButton(
                                                child: new Text("Delete"),
                                                onPressed: () {
                                                  widget
                                                      .updateConfigDetailsToCloud(
                                                          widget
                                                              .restaurant
                                                              .barMenu[index]
                                                              .oid,
                                                          "delete_bar_category");

                                                  Navigator.of(context).pop();
                                                },
                                              ),
                                              // usually buttons at the bottom of the dialog
                                              FlatButton(
                                                child: Text("Close"),
                                                onPressed: () {
                                                  Navigator.of(context).pop();
                                                },
                                              ),
                                            ],
                                          );
                                        },
                                      );
                                    },
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
      ),
    );
  }
}
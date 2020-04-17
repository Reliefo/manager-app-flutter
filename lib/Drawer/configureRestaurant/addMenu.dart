import 'package:adhara_socket_io_example/Drawer/configureRestaurant/addItem.dart';
import 'package:adhara_socket_io_example/data.dart';
import 'package:flutter/material.dart';

class AddMenu extends StatefulWidget {
  final Restaurant restaurant;
  final updateConfigDetailsToCloud;
  final menuType;

  AddMenu({
    this.restaurant,
    this.updateConfigDetailsToCloud,
    this.menuType,
  });

  @override
  _AddMenuState createState() => _AddMenuState();
}

class _AddMenuState extends State<AddMenu> {
  final categoryController = TextEditingController();
  final descriptionController = TextEditingController();
  Map<String, String> categoryTemp = {};
  @override
  Widget build(BuildContext context) {
//    print(widget.restaurant.foodMenu);
    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
          backgroundColor: Colors.grey,
          title: widget.menuType == "food"
              ? Text('Add Food Menu')
              : Text('Add Bar Menu'),
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
                          controller: categoryController,
                          decoration: InputDecoration(
                            labelText: "Category",
                            fillColor: Colors.white,
                            border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(12.0),
                            ),
                            //fillColor: Colors.green
                          ),
                          keyboardType: TextInputType.text,
                          validator: (value) {
                            if (value.isEmpty) {
                              return 'Please enter category';
                            }
                            return null;
                          },
                        ),
                      ),
                    ),
                    Expanded(
                      child: Container(
                        padding: EdgeInsets.all(12),
                        child: TextFormField(
                          controller: descriptionController,
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
                        color: Colors.grey,
                        child: Text('Add'),
                        onPressed: () {
                          if (categoryController.text != null) {
                            setState(() {
                              categoryTemp = {
                                "name": categoryController.text,
                                "description": descriptionController.text
                              };
                            });

                            if (widget.menuType == "food") {
                              widget.updateConfigDetailsToCloud(
                                  categoryTemp, "add_food_menu");
                            } else if (widget.menuType == "bar") {
                              widget.updateConfigDetailsToCloud(
                                  categoryTemp, "add_bar_menu");
                            }

                            categoryTemp.clear();
                          }
                        },
                      ),
                    ),
                  ],
                ),
                Expanded(
                  child: widget.restaurant.foodMenu != null
                      ? ListView.builder(
                          itemCount: widget.restaurant.foodMenu.length,
                          shrinkWrap: true,
                          itemBuilder: (BuildContext context, index) {
                            return ListTile(
                              title:
                                  Text(widget.restaurant.foodMenu[index].name),
//                              subtitle: Text(widget
//                                  .restaurant.foodMenu[index].description),
                              trailing: Row(
                                mainAxisSize: MainAxisSize.min,
                                children: <Widget>[
                                  widget.menuType == "food"
                                      ? FlatButton(
                                          child: Text('Add Food'),
                                          onPressed: () {
                                            Navigator.push(
                                              context,
                                              MaterialPageRoute(
                                                builder: (context) => AddItem(
                                                  category: widget.restaurant
                                                      .foodMenu[index],
                                                  updateConfigDetailsToCloud: widget
                                                      .updateConfigDetailsToCloud,
                                                  menuType: widget.menuType,
                                                ),
                                              ),
                                            );
                                          },
                                        )
                                      : FlatButton(
                                          child: Text('Add Drinks'),
                                          onPressed: () {
                                            Navigator.push(
                                              context,
                                              MaterialPageRoute(
                                                builder: (context) => AddItem(
                                                  category: widget.restaurant
                                                      .barMenu[index],
                                                  updateConfigDetailsToCloud: widget
                                                      .updateConfigDetailsToCloud,
                                                  menuType: widget.menuType,
                                                ),
                                              ),
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
                                            title: widget.menuType == "food"
                                                ? Text(
                                                    "Remove ${widget.restaurant.foodMenu[index].name} Category ?")
                                                : Text(
                                                    "Remove ${widget.restaurant.barMenu[index].name} Category ?"),
                                            content: new Text(
                                                "this will delete all items in this category"),
                                            actions: <Widget>[
                                              FlatButton(
                                                child: new Text("Delete"),
                                                onPressed: () {
                                                  if (widget.menuType ==
                                                      "food") {
                                                    widget.updateConfigDetailsToCloud(
                                                        widget
                                                            .restaurant
                                                            .foodMenu[index]
                                                            .oid,
                                                        "remove_food_category");
                                                  } else if (widget.menuType ==
                                                      "bar") {
                                                    widget.updateConfigDetailsToCloud(
                                                        widget.restaurant
                                                            .barMenu[index].oid,
                                                        "remove_bar_category");
                                                  }

                                                  //todo: check event name with backend

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

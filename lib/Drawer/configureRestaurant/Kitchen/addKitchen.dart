import 'package:flutter/material.dart';
import 'package:manager_app/Drawer/configureRestaurant/Kitchen/kitchenDetails.dart';
import 'package:manager_app/constants.dart';
import 'package:manager_app/fetchData/configureRestaurantData.dart';
import 'package:provider/provider.dart';

class AddKitchen extends StatefulWidget {
  @override
  _AddDataState createState() => _AddDataState();
}

class _AddDataState extends State<AddKitchen> {
  final kitchenNameController = TextEditingController();
  final _kitchenNameEditController = TextEditingController();
  bool _kitchenNameValidate = false;

  _addStaff(restaurantData) {
    setState(() {
      if (kitchenNameController.text.isNotEmpty) {
        _kitchenNameValidate = false;

        print(kitchenNameController.text);

        restaurantData.sendConfiguredDataToBackend(
            {"name": kitchenNameController.text}, "add_kitchen");

        kitchenNameController.clear();
      } else
        _kitchenNameValidate = true;
    });
  }

  @override
  Widget build(BuildContext context) {
    final RestaurantData restaurantData = Provider.of<RestaurantData>(context);
    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
          backgroundColor: kThemeColor,
          title: Text('Kitchens'),
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
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                Row(
                  children: <Widget>[
                    Expanded(
                      flex: 4,
                      child: Container(
                        padding: EdgeInsets.all(12),
                        child: TextFormField(
                          controller: kitchenNameController,
                          onFieldSubmitted: (value) {
                            _addStaff(restaurantData);
                          },
                          decoration: InputDecoration(
                            labelText: "Kitchen Name",
                            fillColor: Colors.white,
                            errorText: _kitchenNameValidate
                                ? 'Value Can\'t Be Empty'
                                : null,
                            border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(12.0),
                            ),
                          ),
                          keyboardType: TextInputType.text,
                        ),
                      ),
                    ),
                    Expanded(
                      child: Container(
                        padding: EdgeInsets.all(8),
                        child: RaisedButton(
                          color: kThemeColor,
                          child: Text(
                            'Add',
                            style: kTitleStyle,
                          ),
                          onPressed: () {
                            _addStaff(restaurantData);
                          },
                        ),
                      ),
                    ),
                  ],
                ),
                Expanded(
                  child: restaurantData.restaurant.kitchens != null
                      ? ListView.builder(
                          itemCount: restaurantData.restaurant.kitchens.length,
                          shrinkWrap: true,
                          primary: false,
                          itemBuilder: (context, index) {
                            return ListTile(
                              title: Text(
                                'Name : ${restaurantData.restaurant.kitchens[index].name}',
                                style: kTitleStyle,
                              ),
                              trailing: Row(
                                mainAxisSize: MainAxisSize.min,
                                children: <Widget>[
                                  IconButton(
                                    icon: Icon(Icons.edit),
                                    onPressed: () {
                                      _kitchenNameEditController.text =
                                          restaurantData
                                              .restaurant.kitchens[index].name;

                                      showDialog(
                                        barrierDismissible: false,
                                        context: context,
                                        builder: (BuildContext context) {
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
                                                      "Kitchen Name :  ",
                                                      textAlign:
                                                          TextAlign.center,
                                                      style: kTitleStyle,
                                                    ),
                                                    SizedBox(width: 20),
                                                    Container(
                                                      width: 200,
                                                      child: TextField(
                                                        controller:
                                                            _kitchenNameEditController,
                                                        autofocus: true,
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
                                                            color: Colors.red),
                                                      ),
                                                      onPressed: () {
                                                        Navigator.of(context)
                                                            .pop(); // To close the dialog
                                                      },
                                                    ),
                                                    FlatButton(
                                                      child: Text(
                                                        "Done",
                                                        style: TextStyle(
                                                            fontFamily:
                                                                "Poppins",
                                                            color:
                                                                Colors.green),
                                                      ),
                                                      onPressed: () {
                                                        if (_kitchenNameEditController
                                                            .text.isNotEmpty) {
                                                          restaurantData
                                                              .sendConfiguredDataToBackend({
                                                            "editing_fields": {
                                                              "name":
                                                                  _kitchenNameEditController
                                                                      .text
                                                            },
                                                            "kitchen_id":
                                                                "${restaurantData.restaurant.kitchens[index].oid}"
                                                          }, "edit_kitchen");
                                                        }

                                                        Navigator.of(context)
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
                                  IconButton(
                                    icon: Icon(Icons.cancel),
                                    onPressed: () {
                                      showDialog(
                                        context: context,
                                        builder: (BuildContext context) {
                                          // return object of type Dialog
                                          return AlertDialog(
                                            title: Text(
                                                "Remove ${restaurantData.restaurant.kitchens[index].name} Kitchen ?"),
                                            content: new Text(
                                                "this will delete all the Staff inside this kitchen"),
                                            actions: <Widget>[
                                              FlatButton(
                                                child: Text("Close"),
                                                onPressed: () {
                                                  Navigator.of(context).pop();
                                                },
                                              ),
                                              FlatButton(
                                                child: new Text("Delete"),
                                                onPressed: () {
                                                  restaurantData
                                                      .sendConfiguredDataToBackend(
                                                          {
                                                        "kitchen_id":
                                                            restaurantData
                                                                .restaurant
                                                                .kitchens[index]
                                                                .oid
                                                      },
                                                          "delete_kitchen");
                                                  Navigator.of(context).pop();
                                                },
                                              ),
                                              // usually buttons at the bottom of the dialog
                                            ],
                                          );
                                        },
                                      );
                                    },
                                  ),
                                ],
                              ),
                              onTap: () {
                                Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                    builder: (context) => KitchenDetails(
                                      kitchen: restaurantData
                                          .restaurant.kitchens[index],
                                    ),
                                  ),
                                );
                              },
                            );
                          })
                      : Text(' '),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

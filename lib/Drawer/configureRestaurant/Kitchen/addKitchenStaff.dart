import 'package:flutter/material.dart';
import 'package:manager_app/Drawer/configureRestaurant/registerStaff.dart';
import 'package:manager_app/constants.dart';
import 'package:manager_app/data.dart';
import 'package:manager_app/fetchData/configureRestaurantData.dart';
import 'package:provider/provider.dart';

class AddKitchenStaff extends StatefulWidget {
  final Kitchen kitchen;
  AddKitchenStaff({
    this.kitchen,
  });
  @override
  _AddDataState createState() => _AddDataState();
}

class _AddDataState extends State<AddKitchenStaff> {
  final staffNameController = TextEditingController();
  final _staffNameEditController = TextEditingController();
  bool _staffNameValidate = false;

  _addStaff(restaurantData) {
    setState(() {
      if (staffNameController.text.isNotEmpty) {
        _staffNameValidate = false;
        print(staffNameController.text);
        restaurantData.sendConfiguredDataToBackend({
          "name": staffNameController.text,
          "kitchen_id": widget.kitchen.oid
        }, "add_kitchen_staff");

        staffNameController.clear();
      } else
        _staffNameValidate = true;
    });
  }

  @override
  Widget build(BuildContext context) {
    final RestaurantData restaurantData = Provider.of<RestaurantData>(context);
    print(widget.kitchen.kitchenStaffList);
    return Container(
      margin: EdgeInsets.only(left: 12, top: 12),
      color: Colors.white,
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
                    controller: staffNameController,
                    onFieldSubmitted: (value) {
                      _addStaff(restaurantData);
                    },
                    decoration: InputDecoration(
                      labelText: "Kitchen Staff Name",
                      fillColor: Colors.white,
                      errorText:
                          _staffNameValidate ? 'Value Can\'t Be Empty' : null,
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
                    color: Colors.grey,
                    child: Text('Add'),
                    onPressed: () {
                      _addStaff(restaurantData);
                    },
                  ),
                ),
              ),
//
            ],
          ),
          Expanded(
            child: widget.kitchen.kitchenStaffList != null
                ? ListView.builder(
                    itemCount: widget.kitchen.kitchenStaffList.length,
                    shrinkWrap: true,
                    primary: false,
                    itemBuilder: (context, index) {
                      return ListTile(
                        title: Text(
                          'Name : ${widget.kitchen.kitchenStaffList[index].name}',
                          style: kTitleStyle,
                        ),
                        trailing: Row(
                          mainAxisSize: MainAxisSize.min,
                          children: <Widget>[
                            FlatButton(
                              child: Text("Register"),
                              onPressed: () {
                                restaurantData.sendStaffRegistrationToBackend({
                                  "restaurant_name":
                                      restaurantData.restaurant.name,
                                  "restaurant_id":
                                      restaurantData.restaurant.restaurantId,
                                  "user_type": "kitchen",
                                  "object_id": widget
                                      .kitchen.kitchenStaffList[index].oid,
                                  "name": widget
                                      .kitchen.kitchenStaffList[index].name,
                                });
                                Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                    builder: (context) => RegisterStaff(),
                                  ),
                                );
                              },
                            ),
                            IconButton(
                              icon: Icon(Icons.edit),
                              onPressed: () {
                                _staffNameEditController.text =
                                    widget.kitchen.kitchenStaffList[index].name;

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
                                        mainAxisSize: MainAxisSize
                                            .min, // To make the card compact
                                        children: <Widget>[
                                          Row(
                                            mainAxisAlignment:
                                                MainAxisAlignment.spaceBetween,
                                            children: <Widget>[
                                              Text(
                                                "Staff Name :  ",
                                                textAlign: TextAlign.center,
                                                style: TextStyle(
                                                  fontSize: 16.0,
                                                ),
                                              ),
                                              SizedBox(width: 20),
                                              Container(
                                                width: 200,
                                                child: TextField(
                                                  controller:
                                                      _staffNameEditController,
                                                  autofocus: true,
                                                ),
                                              ),
                                            ],
                                          ),
                                          SizedBox(height: 24.0),
                                          Row(
                                            mainAxisAlignment:
                                                MainAxisAlignment.spaceAround,
                                            children: <Widget>[
                                              FlatButton(
                                                child: Text(
                                                  "Cancel",
                                                  style: TextStyle(
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
                                                      color: Colors.green),
                                                ),
                                                onPressed: () {
                                                  if (_staffNameEditController
                                                      .text.isNotEmpty) {
                                                    restaurantData
                                                        .sendConfiguredDataToBackend({
                                                      "editing_fields": {
                                                        "name":
                                                            _staffNameEditController
                                                                .text
                                                      },
                                                      "kitchen_staff_id":
                                                          "${widget.kitchen.kitchenStaffList[index].oid}",
                                                      "kitchen_id":
                                                          widget.kitchen.oid
                                                    }, "edit_kitchen_staff");
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
                                restaurantData.sendConfiguredDataToBackend({
                                  "kitchen_staff_id": widget
                                      .kitchen.kitchenStaffList[index].oid,
                                  "kitchen_id": widget.kitchen.oid
                                }, "delete_kitchen_staff");
                              },
                            ),
                          ],
                        ),
                      );
                    })
                : Text(' '),
          ),
        ],
      ),
    );
  }
}

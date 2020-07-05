import 'package:flutter/material.dart';
import 'package:manager_app/Drawer/configureRestaurant/registerStaff.dart';
import 'package:manager_app/constants.dart';
import 'package:manager_app/fetchData/configureRestaurantData.dart';
import 'package:provider/provider.dart';

class AddStaff extends StatefulWidget {
  @override
  _AddDataState createState() => _AddDataState();
}

class _AddDataState extends State<AddStaff> {
  final staffNameController = TextEditingController();
  final _staffNameEditController = TextEditingController();
  bool _staffNameValidate = false;

  _addStaff(restaurantData) {
    setState(() {
      if (staffNameController.text.isNotEmpty) {
        _staffNameValidate = false;

        restaurantData.sendConfiguredDataToBackend(
            {'name': staffNameController.text.toString()}, "add_staff");

        staffNameController.clear();
      } else
        _staffNameValidate = true;
    });
  }

  @override
  Widget build(BuildContext context) {
    final RestaurantData restaurantData = Provider.of<RestaurantData>(context);
    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
          backgroundColor: kThemeColor,
          title: Text('Staff Data'),
        ),
        body: Container(
          padding: EdgeInsets.symmetric(vertical: 12, horizontal: 18),
          color: Color(0xffE0EAF0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              Row(
                children: <Widget>[
                  Expanded(
//                    flex: 4,
                    child: Container(
                      padding: EdgeInsets.all(12),
                      child: TextFormField(
                        controller: staffNameController,
                        onFieldSubmitted: (value) {
                          _addStaff(restaurantData);
                        },
                        decoration: InputDecoration(
                          labelText: "Staff Name",
                          fillColor: Colors.white,
                          errorText: _staffNameValidate
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
                  Container(
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
                  Expanded(
                    child: Container(
                      padding:
                          EdgeInsets.symmetric(vertical: 20, horizontal: 22),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.end,
                        children: <Widget>[
                          restaurantData.restaurant.staff == null
                              ? Text('No of Staffs :')
                              : Text(
                                  'No of Staffs : ${restaurantData.restaurant.staff.length} ',
                                  style: kTitleStyle,
                                ),
                        ],
                      ),
                    ),
                  ),
                ],
              ),
              Expanded(
                child: restaurantData.restaurant.staff != null
                    ? ListView.builder(
                        itemCount: restaurantData.restaurant.staff.length,
                        shrinkWrap: true,
                        primary: false,
                        itemBuilder: (context, index) {
                          return ListTile(
                            title: Text(
                              'Name : ${restaurantData.restaurant.staff[index].name}',
                              style: kTitleStyle,
                            ),
                            trailing: Row(
                              mainAxisSize: MainAxisSize.min,
                              children: <Widget>[
                                FlatButton(
                                  child: Text(
                                    "Register",
                                    style: kTitleStyle,
                                  ),
                                  onPressed: () {
                                    restaurantData
                                        .sendStaffRegistrationToBackend({
                                      "restaurant_name":
                                          restaurantData.restaurant.name,
                                      "restaurant_id": restaurantData
                                          .restaurant.restaurantId,
                                      "user_type": "staff",
                                      "object_id": restaurantData
                                          .restaurant.staff[index].oid,
                                      "name": restaurantData
                                          .restaurant.staff[index].name,
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
                                        restaurantData
                                            .restaurant.staff[index].name;

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
                                                    "Staff Name :  ",
                                                    textAlign: TextAlign.center,
                                                    style: kTitleStyle,
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
                                                    MainAxisAlignment
                                                        .spaceAround,
                                                children: <Widget>[
                                                  FlatButton(
                                                    child: Text(
                                                      "Cancel",
                                                      style: TextStyle(
                                                          fontFamily: "Poppins",
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
                                                          fontFamily: "Poppins",
                                                          color: Colors.green),
                                                    ),
                                                    onPressed: () {
                                                      if (_staffNameEditController
                                                          .text.isNotEmpty) {
                                                        restaurantData
                                                            .sendConfiguredDataToBackend(
                                                                {
                                                              "editing_fields":
                                                                  {
                                                                "name":
                                                                    _staffNameEditController
                                                                        .text
                                                              },
                                                              "staff_id":
                                                                  "${restaurantData.restaurant.staff[index].oid}"
                                                            },
                                                                "edit_staff");
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
                                      "staff_id": restaurantData
                                          .restaurant.staff[index].oid
                                    }, "delete_staff");
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
        ),
      ),
    );
  }
}

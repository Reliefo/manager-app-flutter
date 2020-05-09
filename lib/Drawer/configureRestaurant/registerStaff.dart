import 'package:adhara_socket_io_example/fetchData/configureRestaurantData.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class RegisterStaff extends StatefulWidget {
  @override
  _RegisterStaffState createState() => _RegisterStaffState();
}

class _RegisterStaffState extends State<RegisterStaff> {
  String userType = 'staff';
  var _selectedStaffLabel;
  @override
  Widget build(BuildContext context) {
    final RestaurantData restaurantData = Provider.of<RestaurantData>(context);

    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
          backgroundColor: Colors.blueGrey,
          title: Text('Register User'),
        ),
        body: Container(
          child: Row(
            children: <Widget>[
              Expanded(
                child: Container(
                  color: Colors.cyan,
                  child: Column(
                    children: <Widget>[
                      Row(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: <Widget>[
                          Expanded(
                            child: RadioListTile(
                              groupValue: userType,
                              title: Text('Staff'),
                              value: 'staff',
                              onChanged: (val) {
                                setState(() {
                                  userType = val;
                                });
                              },
                            ),
                          ),
                          Expanded(
                            child: RadioListTile(
                              groupValue: userType,
                              title: Text('Kitchen'),
                              value: 'kitchen',
                              onChanged: (val) {
                                setState(() {
                                  userType = val;
                                });
                              },
                            ),
                          ),
                        ],
                      ),
                      userType == "staff"
                          ? Container(
                              padding: EdgeInsets.all(16),
                              child: DropdownButton(
                                value: _selectedStaffLabel,
                                items: restaurantData.restaurant.staff != null
                                    ? restaurantData.restaurant.staff
                                        .map((staff) {
                                        return DropdownMenuItem(
                                          value: staff,
                                          child: Text(staff.name),
                                        );
                                      }).toList()
                                    : [],
                                hint: Text('Select the Staff'),
                                isExpanded: true,
                                onChanged: (selected) {
                                  setState(() {
                                    _selectedStaffLabel = selected;
                                  });
                                },
                              ),
                            )
                          : Container(
                              padding: EdgeInsets.all(16),
                              child: DropdownButton(
                                value: _selectedStaffLabel,
                                items: restaurantData.restaurant.kitchenStaff !=
                                        null
                                    ? restaurantData.restaurant.kitchenStaff
                                        .map((kitchenStaff) {
                                        return DropdownMenuItem(
                                          value: kitchenStaff,
                                          child: Text(kitchenStaff.name),
                                        );
                                      }).toList()
                                    : [],
                                hint: Text('Select Kitchen Staff'),
                                isExpanded: true,
                                onChanged: (selected) {
                                  setState(() {
                                    _selectedStaffLabel = selected;
                                  });
                                },
                              ),
                            ),
                      FlatButton(
                        child: Text("Register"),
                        onPressed: () {
                          restaurantData.sendStaffRegistrationToBackend({
                            "auth_username": "MID001",
                            "restaurant_name": restaurantData.restaurant.name,
                            "restaurant_id":
                                restaurantData.restaurant.restaurantId,
                            "user_type": userType,
                            "object_id": _selectedStaffLabel.oid,
                            "name": _selectedStaffLabel.name,
                          });

                          _selectedStaffLabel = null;
                        },
                      )
                    ],
                  ),
                ),
              ),
              Expanded(
                child: Container(
                  color: Colors.orange,
                  child: Column(
                    children: <Widget>[
                      Container(
                        child: Text("Registered Staff"),
                      ),
                      Container(
                        padding: EdgeInsets.all(12),
                        child: Row(
                          children: <Widget>[
                            Text(
                                "Registered Type: ${restaurantData.registeredUser["user_type"]}"),
                          ],
                        ),
                      ),
                      Container(
                          padding: EdgeInsets.all(12),
                          child: Row(
                            children: <Widget>[
                              Text(
                                  "Name: ${restaurantData.registeredUser["name"]}"),
                            ],
                          )),
                      Container(
                        padding: EdgeInsets.all(12),
                        child: Row(
                          children: <Widget>[
                            Text(
                                "Username: ${restaurantData.registeredUser["username"]}"),
                          ],
                        ),
                      ),
                      Container(
                        padding: EdgeInsets.all(12),
                        child: Row(
                          children: <Widget>[
                            Text(
                                "Password: ${restaurantData.registeredUser["password"]}"),
                          ],
                        ),
                      ),
                      Container(
                        padding: EdgeInsets.all(12),
                        child: Row(
                          children: <Widget>[
                            Text(
                                "Registration Status: ${restaurantData.registeredUser["status"]}"),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

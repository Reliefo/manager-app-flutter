import 'package:flutter/material.dart';
import 'package:manager_app/Drawer/configureRestaurant/registerStaff.dart';
import 'package:manager_app/fetchData/configureRestaurantData.dart';
import 'package:provider/provider.dart';

class AddKitchenStaff extends StatefulWidget {
  @override
  _AddDataState createState() => _AddDataState();
}

class _AddDataState extends State<AddKitchenStaff> {
  List<Map<String, String>> temporaryStaffNames = [];

  final staffNameController = TextEditingController();
  final _staffNameEditController = TextEditingController();
  bool _staffNameValidate = false;

  _addStaff() {
    setState(() {
      if (staffNameController.text.isNotEmpty) {
        _staffNameValidate = false;
        print(staffNameController.text);
        temporaryStaffNames.add({'name': staffNameController.text.toString()});

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
          backgroundColor: Colors.grey,
          title: Text(' Kitchen Staff Data'),
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
//                Container(
//                  padding: EdgeInsets.all(16),
//                  child: Text('Staff Details'),
//                ),
                Row(
                  children: <Widget>[
                    Expanded(
                      flex: 4,
                      child: Container(
                        padding: EdgeInsets.all(12),
                        child: TextFormField(
                          controller: staffNameController,
                          onFieldSubmitted: (value) {
                            _addStaff();
                          },
                          decoration: InputDecoration(
                            labelText: "Kitchen Staff Name",
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

                    Expanded(
                      child: Container(
                        padding: EdgeInsets.all(8),
                        child: RaisedButton(
                          color: Colors.grey,
                          child: Text('Add'),
                          onPressed: _addStaff,
                        ),
                      ),
                    ),
//
                  ],
                ),
                Container(
                  padding: EdgeInsets.symmetric(vertical: 20, horizontal: 22),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: <Widget>[
                      restaurantData.restaurant.kitchenStaff == null
                          ? Text('No Of Staffs :')
                          : Text(
                              'No Of Staffs : ${restaurantData.restaurant.kitchenStaff.length} ',
                            ),
                      temporaryStaffNames.length == 0
                          ? Text(
                              'All Staff updated to cloud',
                              style: TextStyle(
                                  color: Colors.green,
                                  fontWeight: FontWeight.bold),
                            )
                          : Text(
                              '${temporaryStaffNames.length} Staff not updated to cloud',
                              style: TextStyle(
                                  color: Colors.red,
                                  fontWeight: FontWeight.bold),
                            ),
                      RaisedButton(
                        child: Text('Upload to Cloud'),
                        onPressed: () {
                          setState(() {
                            restaurantData.sendConfiguredDataToBackend(
                                temporaryStaffNames, "add_kitchen_staff");

                            temporaryStaffNames.clear();
                          });
                        },
                      ),
                    ],
                  ),
                ),

                Expanded(
                  child: ListView(
                    shrinkWrap: true,
                    children: <Widget>[
                      ListView.builder(
                          itemCount: temporaryStaffNames.length,
                          shrinkWrap: true,
                          primary: false,
                          itemBuilder: (context, index) {
                            return ListTile(
                              title: Text(
                                  'Name : ${temporaryStaffNames[index]['name']}'),
                              trailing: IconButton(
                                icon: Icon(Icons.cancel),
                                onPressed: () {
                                  setState(() {
                                    temporaryStaffNames.removeAt(index);
                                  });
                                },
                              ),
                            );
                          }),
                      restaurantData.restaurant.kitchenStaff != null
                          ? ListView.builder(
                              itemCount:
                                  restaurantData.restaurant.kitchenStaff.length,
                              shrinkWrap: true,
                              primary: false,
                              itemBuilder: (context, index) {
                                return ListTile(
                                  title: Text(
                                      'Name : ${restaurantData.restaurant.kitchenStaff[index].name}'),
                                  trailing: Row(
                                    mainAxisSize: MainAxisSize.min,
                                    children: <Widget>[
                                      FlatButton(
                                        child: Text("Register"),
                                        onPressed: () {
                                          restaurantData
                                              .sendStaffRegistrationToBackend({
                                            "restaurant_name":
                                                restaurantData.restaurant.name,
                                            "restaurant_id": restaurantData
                                                .restaurant.restaurantId,
                                            "user_type": "kitchen",
                                            "object_id": restaurantData
                                                .restaurant
                                                .kitchenStaff[index]
                                                .oid,
                                            "name": restaurantData.restaurant
                                                .kitchenStaff[index].name,
                                          });
                                          Navigator.push(
                                            context,
                                            MaterialPageRoute(
                                              builder: (context) =>
                                                  RegisterStaff(),
                                            ),
                                          );
                                        },
                                      ),
                                      IconButton(
                                        icon: Icon(Icons.edit),
                                        onPressed: () {
                                          _staffNameEditController.text =
                                              restaurantData.restaurant
                                                  .kitchenStaff[index].name;

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
                                                                color: Colors
                                                                    .green),
                                                          ),
                                                          onPressed: () {
                                                            if (_staffNameEditController
                                                                .text
                                                                .isNotEmpty) {
                                                              restaurantData
                                                                  .sendConfiguredDataToBackend({
                                                                "editing_fields":
                                                                    {
                                                                  "name":
                                                                      _staffNameEditController
                                                                          .text
                                                                },
                                                                "kitchen_staff_id":
                                                                    "${restaurantData.restaurant.kitchenStaff[index].oid}"
                                                              }, "edit_kitchen_staff");
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
                                      IconButton(
                                        icon: Icon(Icons.cancel),
                                        onPressed: () {
                                          restaurantData
                                              .sendConfiguredDataToBackend({
                                            "kitchen_staff_id": restaurantData
                                                .restaurant
                                                .kitchenStaff[index]
                                                .oid
                                          }, "delete_kitchen_staff");
                                        },
                                      ),
                                    ],
                                  ),
                                );
                              })
                          : Text(' '),
                    ],
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

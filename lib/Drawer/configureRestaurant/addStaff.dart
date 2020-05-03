import 'package:adhara_socket_io_example/fetchData/configureRestaurantData.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class AddStaff extends StatefulWidget {
//  final updateConfigDetailsToCloud;
//
//  final Restaurant restaurant;
//
//  AddStaff({
//    this.updateConfigDetailsToCloud,
//    this.restaurant,
//  });

  @override
  _AddDataState createState() => _AddDataState();
}

class _AddDataState extends State<AddStaff> {
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
          title: Text('Staff Data'),
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
                      restaurantData.restaurant.staff == null
                          ? Text('No Of Staffs :')
                          : Text(
                              'No Of Staffs : ${restaurantData.restaurant.staff.length} ',
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
                                temporaryStaffNames, "add_staff");

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
                      restaurantData.restaurant.staff != null
                          ? ListView.builder(
                              itemCount: restaurantData.restaurant.staff.length,
                              shrinkWrap: true,
                              primary: false,
                              itemBuilder: (context, index) {
                                return ListTile(
                                  title: Text(
                                      'Name : ${restaurantData.restaurant.staff[index].name}'),
                                  trailing: Row(
                                    mainAxisSize: MainAxisSize.min,
                                    children: <Widget>[
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
                                                                "staff_id":
                                                                    "${restaurantData.restaurant.staff[index].oid}"
                                                              }, "edit_staff");
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
                                              .sendConfiguredDataToBackend(
                                                  restaurantData.restaurant
                                                      .staff[index].oid,
                                                  "delete_staff");
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

//                      Expanded(
//                          child: ListView.builder(
//                              itemCount: widget.staffNameList.length,
//                              shrinkWrap: true,
//                              primary: false,
//                              itemBuilder: (context, index) {
//                                return ListItem(
//                                  staffNameList: widget.staffNameList,
//                                  index: index,
//                                );
//                              })),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

//class ListItem extends StatefulWidget {
//  final List<String> staffNameList;
//  final int index;
//
//  ListItem({
//    @required this.staffNameList,
//    this.index,
//  });
//  @override
//  _ListItemState createState() => _ListItemState();
//}
//
//class _ListItemState extends State<ListItem> {
//  bool _isEditing = false;
//  bool _done = true;
//  final editingController = TextEditingController();
//  @override
//  Widget build(BuildContext context) {
//    return ListTile(
//      title: _isEditing
//          ? TextFormField(
//              enabled: _isEditing,
//              controller: editingController,
//              decoration: InputDecoration(
//                hintText: 'Staff Name',
//              ),
//            )
//          : Text('${widget.staffNameList[widget.index]}'),
//
//      // The icon button which will notify list item to change
//      trailing: !_isEditing
//          ? GestureDetector(
//              child: Icon(
//                Icons.edit,
//                color: Colors.black,
//              ),
//              onTap: () {
//                setState(() {
//                  if (_isEditing == true) {
//                    _isEditing = false;
//                  }
//                  if (_isEditing == false) {
//                    _isEditing = true;
//                  }
//                });
//              },
//            )
//          : GestureDetector(
//              child: Icon(
//                Icons.done,
//                color: Colors.black,
//              ),
//              onTap: () {
//                setState(() {
//                  if (_done == true) {
//                    _done = false;
//                    _isEditing = false;
//                  }
//                  if (_done == false) {
//                    _done = true;
//                  }
//                  widget.staffNameList
//                      .insert(widget.index, editingController.text);
//                  widget.staffNameList.removeAt(widget.index + 1);
//                });
//              },
//            ),
//    );
//  }
//}

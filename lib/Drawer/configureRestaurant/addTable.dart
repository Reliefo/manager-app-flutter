import 'package:adhara_socket_io_example/fetchData/configureRestaurantData.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class AddData extends StatefulWidget {
////  final updateConfigDetailsToCloud;
//
//  AddData({
//    this.updateConfigDetailsToCloud,
////    this.restaurant,
//  });

  @override
  _AddDataState createState() => _AddDataState();
}

class _AddDataState extends State<AddData> {
  List<Map<String, String>> temporaryTables = [];

  final _tableNameController = TextEditingController();
  final _tableSeatController = TextEditingController();
  final _tableNameEditController = TextEditingController();
  final _tableSeatEditController = TextEditingController();

  final FocusNode _tableNameFocus = FocusNode();
  final FocusNode _tableSeatFocus = FocusNode();
  bool _tableNameValidate = false;
  bool _tableSeatValidate = false;

  _fieldFocusChange(
      BuildContext context, FocusNode currentFocus, FocusNode nextFocus) {
    currentFocus.unfocus();
    FocusScope.of(context).requestFocus(nextFocus);
  }

  _addTable() {
    setState(() {
      _tableNameController.text.isEmpty
          ? _tableNameValidate = true
          : _tableNameValidate = false;
      _tableSeatController.text.isEmpty
          ? _tableSeatValidate = true
          : _tableSeatValidate = false;
      if (_tableNameController.text.isNotEmpty &&
          _tableSeatController.text.isNotEmpty) {
        temporaryTables.add({
          'name': _tableNameController.text,
          'seats': _tableSeatController.text
        });

        _tableSeatController.clear();
        _tableNameController.clear();
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    final RestaurantData restaurantData = Provider.of<RestaurantData>(context);
    print(temporaryTables);
    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
          backgroundColor: Colors.grey,
          title: Text('Table Data'),
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
//                  child: Text('Table Details'),
//                ),
                Row(
                  children: <Widget>[
                    Expanded(
                      flex: 4,
                      child: Container(
                        padding: EdgeInsets.all(12),
                        child: TextFormField(
                          controller: _tableNameController,
                          textInputAction: TextInputAction.next,
                          focusNode: _tableNameFocus,
                          onFieldSubmitted: (term) {
                            _fieldFocusChange(
                                context, _tableNameFocus, _tableSeatFocus);
                          },
                          decoration: InputDecoration(
                            labelText: "Table Name",
                            fillColor: Colors.white,
                            errorText: _tableNameValidate
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
                      flex: 2,
                      child: Container(
                        padding: EdgeInsets.all(12),
                        child: TextFormField(
                          controller: _tableSeatController,
                          focusNode: _tableSeatFocus,
                          onFieldSubmitted: (value) {
                            _addTable();
                          },
                          decoration: InputDecoration(
                            labelText: "Seats",
                            fillColor: Colors.white,
                            errorText: _tableSeatValidate
                                ? 'Value Can\'t Be Empty'
                                : null,
                            border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(12.0),
                            ),
                          ),
                          keyboardType: TextInputType.number,
                        ),
                      ),
                    ),
                    Expanded(
                        child: Container(
                      padding: EdgeInsets.all(8),
                      child: RaisedButton(
                        color: Colors.grey,
                        child: Text('Add'),
                        onPressed: _addTable,
                      ),
                    )),
                  ],
                ),
                Container(
                  padding: EdgeInsets.symmetric(vertical: 20, horizontal: 22),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: <Widget>[
                      restaurantData.restaurant.tables == null
                          ? Text('No Of Tables :')
                          : Text(
                              'No Of Tables : ${restaurantData.restaurant.tables.length} ',
                            ),
                      temporaryTables.length == 0
                          ? Text(
                              'All tables updated to cloud',
                              style: TextStyle(
                                  color: Colors.green,
                                  fontWeight: FontWeight.bold),
                            )
                          : Text(
                              '${temporaryTables.length} tables not updated to cloud',
                              style: TextStyle(
                                  color: Colors.red,
                                  fontWeight: FontWeight.bold),
                            ),
                      RaisedButton(
                        child: Text('Upload to Cloud'),
                        onPressed: () {
                          setState(() {
                            restaurantData.sendConfiguredDataToBackend(
                                temporaryTables, "add_tables");
//                          widget.updateConfigDetailsToCloud(
//                              temporaryTables, "add_tables");
                            temporaryTables.clear();
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
                          itemCount: temporaryTables.length,
                          shrinkWrap: true,
                          primary: false,
                          itemBuilder: (context, index) {
                            return ListTile(
                              title: Text(
                                  'Table Name : ${temporaryTables[index]['name']}'),
                              subtitle: Text(
                                  'Capacity : ${temporaryTables[index]['seats']} Seats'),
                              trailing: IconButton(
                                icon: Icon(Icons.cancel),
                                onPressed: () {
                                  setState(() {
                                    temporaryTables.removeAt(index);
                                  });
                                },
                              ),
                            );
                          }),

                      ////displaying from cloud/ real updated data
                      restaurantData.restaurant.tables != null
                          ? ListView.builder(
                              itemCount:
                                  restaurantData.restaurant.tables.length,
                              shrinkWrap: true,
                              primary: false,
                              itemBuilder: (context, index) {
                                return ListTile(
                                  title: Text(
                                      'Table Name : ${restaurantData.restaurant.tables[index].name}'),
                                  subtitle: Text(
                                      'Capacity : ${restaurantData.restaurant.tables[index].seats} Seats'),
                                  trailing: Row(
                                    mainAxisSize: MainAxisSize.min,
                                    children: <Widget>[
                                      IconButton(
                                        icon: Icon(Icons.edit),
                                        onPressed: () {
                                          _tableNameEditController.text =
                                              restaurantData.restaurant
                                                  .tables[index].name;

                                          _tableSeatEditController.text =
                                              restaurantData.restaurant
                                                  .tables[index].seats;
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
                                                          "Table Name :  ",
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
                                                                _tableNameEditController,
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
                                                          "Seating Capacity :  ",
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
                                                                _tableSeatEditController,
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
                                                            if (_tableNameEditController
                                                                    .text
                                                                    .isNotEmpty &&
                                                                _tableSeatEditController
                                                                    .text
                                                                    .isNotEmpty) {
                                                              restaurantData
                                                                  .sendConfiguredDataToBackend({
                                                                "editing_fields":
                                                                    {
                                                                  "name":
                                                                      _tableNameEditController
                                                                          .text,
                                                                  "seats":
                                                                      _tableSeatEditController
                                                                          .text
                                                                },
                                                                "table_id":
                                                                    "${restaurantData.restaurant.tables[index].oid}"
                                                              }, "edit_tables");
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
                                          showDialog(
                                            context: context,
                                            builder: (BuildContext context) {
                                              // return object of type Dialog
                                              return AlertDialog(
                                                title: Text(
                                                    "Remove ${restaurantData.restaurant.tables[index].name} Table ?"),
                                                content: new Text(
                                                    "this will delete all the assigned Staff from this table"),
                                                actions: <Widget>[
                                                  FlatButton(
                                                    child: new Text("Delete"),
                                                    onPressed: () {
                                                      restaurantData
                                                          .sendConfiguredDataToBackend(
                                                              restaurantData
                                                                  .restaurant
                                                                  .tables[index]
                                                                  .oid,
                                                              "delete_tables");
                                                      Navigator.of(context)
                                                          .pop();
                                                    },
                                                  ),
                                                  // usually buttons at the bottom of the dialog
                                                  FlatButton(
                                                    child: Text("Close"),
                                                    onPressed: () {
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
                                    ],
                                  ),
                                );
                              })
                          : Text(' ')
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

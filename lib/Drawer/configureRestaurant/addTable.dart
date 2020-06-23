import 'package:flutter/material.dart';
import 'package:manager_app/constants.dart';
import 'package:manager_app/fetchData/configureRestaurantData.dart';
import 'package:provider/provider.dart';

class AddData extends StatefulWidget {
  @override
  _AddDataState createState() => _AddDataState();
}

class _AddDataState extends State<AddData> {
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

  Widget addNewTable(restaurantData) {
    return Container(
      decoration: BoxDecoration(
        color: Colors.black12,
        borderRadius: BorderRadius.all(
          Radius.circular(15.0),
        ),
      ),
      margin: EdgeInsets.all(4),
      child: Row(
        children: <Widget>[
          Expanded(
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: <Widget>[
                Expanded(
                  child: Container(
                    padding: EdgeInsets.all(16),
                    child: TextFormField(
                      controller: _tableNameController,
                      textInputAction: TextInputAction.next,
                      focusNode: _tableNameFocus,
                      onFieldSubmitted: (term) {
                        _fieldFocusChange(
                            context, _tableNameFocus, _tableSeatFocus);
                      },
                      decoration: InputDecoration(
                        hintText: "Table Name",
                        fillColor: Colors.white,
                        errorText:
                            _tableNameValidate ? 'Value Can\'t Be Empty' : null,
//                        border: OutlineInputBorder(
//                          borderRadius: BorderRadius.circular(12.0),
//                        ),
                      ),
                      keyboardType: TextInputType.text,
                      textCapitalization: TextCapitalization.words,
                    ),
                  ),
                ),
                Expanded(
                  child: Container(
                    padding: EdgeInsets.all(16),
                    child: TextFormField(
                      controller: _tableSeatController,
                      focusNode: _tableSeatFocus,
                      onFieldSubmitted: (value) {
                        _sendTableToBackend(restaurantData);
                      },
                      decoration: InputDecoration(
                        hintText: "Seats",
                        fillColor: Colors.white,
                        errorText:
                            _tableSeatValidate ? 'Value Can\'t Be Empty' : null,
//                        border: OutlineInputBorder(
//                          borderRadius: BorderRadius.circular(12.0),
//                        ),
                      ),
                      keyboardType: TextInputType.number,
                    ),
                  ),
                ),
              ],
            ),
          ),
          VerticalDivider(
            indent: 16,
            endIndent: 16,
          ),
          FlatButton(
            child: Text(
              "Add",
              style: kGreenButtonStyle,
            ),
            onPressed: () {
              _sendTableToBackend(restaurantData);
            },
          ),
        ],
      ),
    );
  }

  _sendTableToBackend(restaurantData) {
    setState(() {
      _tableNameController.text.isEmpty
          ? _tableNameValidate = true
          : _tableNameValidate = false;
      _tableSeatController.text.isEmpty
          ? _tableSeatValidate = true
          : _tableSeatValidate = false;
      if (_tableNameController.text.isNotEmpty &&
          _tableSeatController.text.isNotEmpty) {
        setState(() {
          restaurantData.sendConfiguredDataToBackend([
            {
              'name': _tableNameController.text,
              'seats': _tableSeatController.text
            }
          ], "add_tables");
        });

        _tableSeatController.clear();
        _tableNameController.clear();
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    final RestaurantData restaurantData = Provider.of<RestaurantData>(context);

    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
          backgroundColor: kThemeColor,
          title: Text('Table Data'),
        ),
        body: Container(
          padding: EdgeInsets.symmetric(vertical: 12, horizontal: 18),
          color: Color(0xffE0EAF0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              Container(
                padding: EdgeInsets.symmetric(vertical: 20, horizontal: 22),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: <Widget>[
                    restaurantData.restaurant.tables == null
                        ? Text('No of Tables :')
                        : Text(
                            'No of Tables : ${restaurantData.restaurant.tables.length} ',
                            style: kTitleStyle,
                          ),
                  ],
                ),
              ),
              Expanded(
                child: restaurantData.restaurant.tables != null
                    ? GridView.builder(
                        itemCount: restaurantData.restaurant.tables.length + 1,
                        shrinkWrap: true,
                        gridDelegate: SliverGridDelegateWithMaxCrossAxisExtent(
                          mainAxisSpacing: 4.0,
                          crossAxisSpacing: 4.0,
                          childAspectRatio: (6 / 2),
                          maxCrossAxisExtent: 450,
                        ),
                        primary: false,
                        itemBuilder: (context, index) {
                          if (index == 0) {
                            return addNewTable(restaurantData);
                          }
                          return Container(
                            decoration: BoxDecoration(
                              color: Colors.white,
                              borderRadius: BorderRadius.all(
                                Radius.circular(15.0),
                              ),
                            ),
                            margin: EdgeInsets.all(4),
//                                padding: EdgeInsets.fromLTRB(16, 8, 4, 0),
                            child: Row(
                              children: <Widget>[
                                Expanded(
                                  child: ListTile(
                                    title: Padding(
                                      padding:
                                          const EdgeInsets.only(bottom: 4.0),
                                      child: Text(
                                        'Table Name : ${restaurantData.restaurant.tables[index - 1].name}',
                                        style: kTitleStyle,
                                      ),
                                    ),
                                    subtitle: Text(
                                      'Capacity : ${restaurantData.restaurant.tables[index - 1].seats} Seats',
                                      style: kSubTitleStyle,
                                    ),
                                  ),
                                ),

                                VerticalDivider(
                                  indent: 16,
                                  endIndent: 16,
                                ),

                                //////////////// edit and delete buttons //////////////////
                                Column(
                                  children: <Widget>[
                                    Expanded(
                                      child: FlatButton(
                                        child: Text(
                                          "Edit",
                                          style: kBlueButtonStyle,
                                        ),
                                        onPressed: () {
                                          _tableNameEditController.text =
                                              restaurantData.restaurant
                                                  .tables[index - 1].name;

                                          _tableSeatEditController.text =
                                              restaurantData.restaurant
                                                  .tables[index - 1].seats;
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
                                                          style: kTitleStyle,
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
                                                          style: kTitleStyle,
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
                                                            style:
                                                                kRedButtonStyle,
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
                                                            style:
                                                                kGreenButtonStyle,
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
                                                                    "${restaurantData.restaurant.tables[index - 1].oid}"
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
                                    ),
                                    Expanded(
                                      child: FlatButton(
                                        child: Text(
                                          "Delete",
                                          style: kRedButtonStyle,
                                        ),
                                        onPressed: () {
                                          showDialog(
                                            context: context,
                                            builder: (BuildContext context) {
                                              // return object of type Dialog
                                              return AlertDialog(
                                                title: Text(
                                                    "Remove ${restaurantData.restaurant.tables[index - 1].name} Table ?"),
                                                content: new Text(
                                                    "this will delete all the assigned Staff from this table"),
                                                actions: <Widget>[
                                                  FlatButton(
                                                    child: Text(
                                                      "Close",
                                                      style: kBlueButtonStyle,
                                                    ),
                                                    onPressed: () {
                                                      Navigator.of(context)
                                                          .pop();
                                                    },
                                                  ),
                                                  FlatButton(
                                                    child: new Text(
                                                      "Delete",
                                                      style: kRedButtonStyle,
                                                    ),
                                                    onPressed: () {
                                                      restaurantData
                                                          .sendConfiguredDataToBackend(
                                                              restaurantData
                                                                  .restaurant
                                                                  .tables[
                                                                      index - 1]
                                                                  .oid,
                                                              "delete_tables");
                                                      Navigator.of(context)
                                                          .pop();
                                                    },
                                                  ),
                                                  // usually buttons at the bottom of the dialog
                                                ],
                                              );
                                            },
                                          );
                                        },
                                      ),
                                    ),
                                  ],
                                )
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

import 'dart:core';

import 'package:flutter/material.dart';
import 'package:manager_app/constants.dart';
import 'package:manager_app/data.dart';
import 'package:manager_app/fetchData/configureRestaurantData.dart';
import 'package:provider/provider.dart';

class ReorderCategory extends StatefulWidget {
  final List<Category> itemList;
  final String configurationType;
  ReorderCategory({
    Key key,
    @required this.itemList,
    @required this.configurationType,
  }) : super(key: key);
  @override
  _ReorderCategoryState createState() => _ReorderCategoryState();
}

class _ReorderCategoryState extends State<ReorderCategory> {
  List<Category> newItemList = [];
  List<String> idList = [];
  Function sendConfiguredDataToBackend;
  void _onReorder(int oldIndex, int newIndex) {
    setState(
      () {
        if (newIndex > oldIndex) {
          newIndex -= 1;
        }
        final Category changedItem = newItemList.removeAt(oldIndex);
        newItemList.insert(newIndex, changedItem);
      },
    );
  }

  Widget itemView(index, item) {
    return ListTile(
      contentPadding: EdgeInsets.all(12),
      key: Key(item.oid),
      leading: Icon(Icons.drag_handle),
      title: Text(index.toString() + " .  " + item.name, style: kTitleStyle),
    );
  }

  Future<bool> _onBackPressed() {
    return showDialog(
            context: context,
            builder: (context) {
              return AlertDialog(
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(20),
                ),
                title: new Text('Changes not saved'),
                content: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: <Widget>[
                    Text('Do you want to Save the changes.?'),
                    SizedBox(height: 24),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceAround,
                      children: <Widget>[
                        FlatButton(
                          child: Text(
                            "Don't Save",
                            style: TextStyle(
                                fontFamily: "Poppins", color: Colors.red),
                          ),
                          onPressed: () {
                            Navigator.of(context)
                                .pop(true); // To close the dialog
                          },
                        ),
                        FlatButton(
                          child: Text(
                            "Save Changes",
                            style: TextStyle(
                                fontFamily: "Poppins", color: Colors.green),
                          ),
                          onPressed: () {
                            newItemList.forEach((element) {
                              idList.add(element.oid);
                            });

                            Map<String, dynamic> localData = {
                              "category_id_list": idList
                            };

                            sendConfiguredDataToBackend(
                                localData, widget.configurationType);

                            Navigator.of(context)
                                .pop(true); // To close the dialog
                          },
                        ),
                      ],
                    )
                  ],
                ),
              );
            }) ??
        false;
  }

  @override
  void initState() {
    // TODO: implement initState
    newItemList = List.from(widget.itemList);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final RestaurantData restaurantData = Provider.of<RestaurantData>(context);
    sendConfiguredDataToBackend = restaurantData.sendConfiguredDataToBackend;

    print("printing here");
    print(newItemList);

    return WillPopScope(
      onWillPop: _onBackPressed,
      child: SafeArea(
        child: Scaffold(
          appBar: AppBar(
            title: Text("Tap and hold to Reorder"),
            backgroundColor: kThemeColor,
          ),
          body: Container(
            child: ReorderableListView(
              children: newItemList.map((item) {
                var index = newItemList.indexOf(item);
                return itemView(index + 1, item);
              }).toList(),
              onReorder: _onReorder,
            ),
          ),
        ),
      ),
    );
  }
}

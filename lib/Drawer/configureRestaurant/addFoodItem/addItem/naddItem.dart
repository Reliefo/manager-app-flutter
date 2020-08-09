import 'package:flutter/material.dart';
import 'package:manager_app/Drawer/configureRestaurant/addFoodItem/ViewItem/viewItem.dart';
import 'package:manager_app/Drawer/configureRestaurant/addFoodItem/addItem/reorderFoodItem.dart';
import 'package:manager_app/constants.dart';
import 'package:manager_app/data.dart';
import 'package:manager_app/fetchData/configureRestaurantData.dart';
import 'package:provider/provider.dart';
import 'dart:async';
import 'package:fluttertoast/fluttertoast.dart';

class NAddItem extends StatefulWidget {
  final Category category;

  final menuType;
  NAddItem({
    this.category,
    this.menuType,
  });
  @override
  _NAddItemState createState() => _NAddItemState();
}

class _NAddItemState extends State<NAddItem> {
  final itemNameController = TextEditingController();

  Widget addNewItem(RestaurantData restaurantData) {
    return GestureDetector(
        child: Container(
          decoration: BoxDecoration(
            color: Colors.black12,
            borderRadius: BorderRadius.all(
              Radius.circular(15.0),
            ),
          ),
          margin: EdgeInsets.all(4),
          child: Icon(Icons.add, size: 60),
        ),
        onTap: () {
          showDialog(
              barrierDismissible: false,
              context: context,
              builder: (BuildContext context) {
                return AlertDialog(
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(20),
                  ),
                  content: Container(
                    child: Column(
                      mainAxisSize: MainAxisSize.min,
                      children: <Widget>[
                        Row(
                          children: <Widget>[
                            Text("Item Name : "),
                            SizedBox(width: 8),
                            Container(
                              width: 200,
                              child: TextField(
                                controller: itemNameController,
                                keyboardType: TextInputType.text,
                                textCapitalization:
                                    TextCapitalization.sentences,
                                autofocus: true,
                              ),
                            ),
                          ],
                        ),
                        SizedBox(height: 24.0),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceAround,
                          children: <Widget>[
                            FlatButton(
                              onPressed: () {
                                Navigator.of(context)
                                    .pop(); // To close the dialog
                              },
                              child: Text(
                                "Cancel",
                                style: TextStyle(color: Colors.red),
                              ),
                            ),
                            FlatButton(
                              onPressed: () async {
                                if (itemNameController.text.isNotEmpty) {
                                  restaurantData.sendConfiguredDataToBackend({
                                    "category_id": widget.category.oid,
                                    "category_type": widget.menuType,
                                    "food_dict": {
                                      "name": itemNameController.text,
                                    },
                                  }, "add_food_item");
                                  await new Future.delayed(
                                      const Duration(seconds: 1));
                                  itemNameController.clear();
                                  Navigator.of(context).pop();
                                  Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                      builder: (context) => ViewItem(
                                        showCustomization: true,
                                        menuType: widget.menuType,
                                        foodItem: widget.category.foodList[
                                            widget.category.foodList.length -
                                                1],
                                      ),
                                    ),
                                  );
                                } else {
                                  Fluttertoast.showToast(
                                      msg: "Please enter name",
                                      toastLength: Toast.LENGTH_SHORT,
                                      gravity: ToastGravity.BOTTOM,
                                      timeInSecForIosWeb: 1,
                                      backgroundColor: Colors.red,
                                      textColor: Colors.white,
                                      fontSize: 16.0);
                                }

//                                if (widget.category.foodList != null) {
//                                  Navigator.push(
//                                    context,
//                                    MaterialPageRoute(
//                                      builder: (context) => ViewItem(
//                                        showCustomization: true,
//                                        menuType: widget.menuType,
//                                        foodItem: widget.category.foodList.last,
//                                      ),
//                                    ),
//                                  );
//                                }
                              },
                              child: Text(
                                "Done",
                                style: TextStyle(color: Colors.green),
                              ),
                            ),
                          ],
                        )
                      ],
                    ),
                  ),
                );
              });
        });
  }

  @override
  Widget build(BuildContext kcontext) {
    final RestaurantData restaurantData = Provider.of<RestaurantData>(kcontext);

    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
          backgroundColor: kThemeColor,
          title: Text(widget.category.name ?? " "),
          actions: <Widget>[
            widget.category.foodList != null &&
                    widget.category.foodList.isNotEmpty
                ? FlatButton(
                    child: Text('Re-Order'),
                    onPressed: () {
                      Navigator.push(
                        kcontext,
                        MaterialPageRoute(
                          builder: (context) => ReorderFoodItem(
                              menuType: widget.menuType,
                              categoryId: widget.category.oid,
                              itemList: widget.category.foodList,
                              configurationType: "reorder_food_item"),
                        ),
                      );
                    },
                  )
                : Container(width: 0, height: 0),
          ],
        ),
        body: widget.category.foodList != null
            ? Padding(
                padding: const EdgeInsets.all(8.0),
                child: GridView.builder(
                  itemCount: widget.category.foodList.length + 1,
                  shrinkWrap: true,
                  gridDelegate: SliverGridDelegateWithMaxCrossAxisExtent(
                    mainAxisSpacing: 4.0,
                    crossAxisSpacing: 4.0,
                    childAspectRatio: (3 / 2),
                    maxCrossAxisExtent: 300,
                  ),
                  itemBuilder: (context, index) {
                    /////////////////// add new food item /////////////////
                    if (index == 0) {
                      return addNewItem(restaurantData);
                    }

                    /////////////////////// display food items //////////////////
                    return GestureDetector(
                      child: Container(
                        decoration: BoxDecoration(
                          color:
                              widget.category.foodList[index - 1].visibility ==
                                      true
                                  ? Colors.green[100]
                                  : Colors.red[100],
                          borderRadius: BorderRadius.all(
                            Radius.circular(15.0),
                          ),
                        ),
                        margin: EdgeInsets.all(4),
                        padding: EdgeInsets.fromLTRB(16, 8, 4, 0),
                        child: Column(
                          children: <Widget>[
                            Row(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: <Widget>[
                                Expanded(
                                  child: Padding(
                                    padding: const EdgeInsets.symmetric(
                                        vertical: 10.0),
                                    child: Text(
                                      widget.category.foodList[index - 1].name,
                                      style: kTitleStyle,
                                      maxLines: 2,
                                      overflow: TextOverflow.ellipsis,
                                    ),
                                  ),
                                ),
                                IconButton(
                                  icon: Icon(Icons.cancel),
                                  onPressed: () {
                                    restaurantData.sendConfiguredDataToBackend({
                                      "category_type": widget.menuType,
                                      "food_id": widget
                                          .category.foodList[index - 1].oid
                                    }, "delete_food_item");
                                  },
                                ),
                              ],
                            ),
                            Padding(
                              padding: const EdgeInsets.only(right: 8.0),
                              child: Text(
                                widget.category.foodList[index - 1]
                                        .description ??
                                    "",
                                maxLines: 3,
                                overflow: TextOverflow.ellipsis,
                                style: kSubTitleStyle,
                              ),
                            ),
                          ],
                        ),
                      ),
                      onTap: () {
                        //////////////////////////////// view item ///////////////
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => ViewItem(
                              showCustomization: true,
                              menuType: widget.menuType,
                              foodItem: widget.category.foodList[index - 1],
                            ),
                          ),
                        );
                      },
                    );
                  },
                ),
              )
            : Center(
                child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  addNewItem(restaurantData),
                  Text("Add New Item"),
                ],
              )),
      ),
    );
  }
}

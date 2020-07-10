import 'package:flutter/material.dart';
import 'package:manager_app/Drawer/configureRestaurant/addFoodItem/ViewItem/viewItem.dart';
import 'package:manager_app/constants.dart';
import 'package:manager_app/data.dart';
import 'package:manager_app/fetchData/configureRestaurantData.dart';
import 'package:provider/provider.dart';

class AddOnsMenu extends StatefulWidget {
  @override
  _AddFoodItemState createState() => _AddFoodItemState();
}

class _AddFoodItemState extends State<AddOnsMenu> {
  final itemNameController = TextEditingController();
  final descriptionController = TextEditingController();
  final priceController = TextEditingController();

  final FocusNode itemNameFocus = FocusNode();
  final FocusNode descriptionFocus = FocusNode();
  final FocusNode priceFocus = FocusNode();

  _fieldFocusChange(
      BuildContext context, FocusNode currentFocus, FocusNode nextFocus) {
    currentFocus.unfocus();
    FocusScope.of(context).requestFocus(nextFocus);
  }

  confirmItem(restaurantData) {
    restaurantData.sendConfiguredDataToBackend({
      "category_type": "add_ons",
      "food_dict": {
        "name": itemNameController.text,
        "description": descriptionController.text,
        "price": priceController.text,
      },
    }, "add_add_ons");

    itemNameController.clear();
    descriptionController.clear();
    priceController.clear();
  }

  removeAddOnEverywhere(String addOnId, restaurantData) {
    List<MenuFoodItem> changedFoodItems = [];
    removeAddOnsFromCategory(category) {
      category?.foodList?.forEach((food) {
        food.customizations?.forEach((customization) {
          if (customization.customizationType == "add_ons") {
            List<MenuFoodItem> addOnsToDelete = [];
            customization.addOns.forEach((addOn) {
              if (addOn.oid == addOnId) {
                addOnsToDelete.add(addOn);
                changedFoodItems.add(food);
              }
            });
            addOnsToDelete?.forEach((item) {
              customization.addOns.remove(item);
            });
          }
        });
      });
    }

    restaurantData.restaurant.foodMenu?.forEach((category) {
      removeAddOnsFromCategory(category);
    });
    restaurantData.restaurant.barMenu?.forEach((category) {
      removeAddOnsFromCategory(category);
    });
    changedFoodItems?.forEach((item) {
      List<Map<String, dynamic>> dataToBackend = [];
      item.customizations.forEach((customization) {
        dataToBackend.add(customization.toJson());
      });
      restaurantData.sendConfiguredDataToBackend({
        "food_id": item.oid,
        "editing_fields": {"customization": dataToBackend}
      }, "edit_food_item");

      dataToBackend.clear();
    });
  }

  @override
  Widget build(BuildContext context) {
    final RestaurantData restaurantData = Provider.of<RestaurantData>(context);

    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
          backgroundColor: kThemeColor,
          title: Text("Add-On"),
        ),
        body: Container(
          padding: EdgeInsets.symmetric(vertical: 12, horizontal: 18),
          color: Color(0xffE0EAF0),
          child: Card(
            color: Color(0xffE5EDF1),
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(20.0),
            ),
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                Expanded(
                  child: SingleChildScrollView(
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: <Widget>[
                        Row(
                          children: <Widget>[
                            Expanded(
                              child: Container(
                                padding: EdgeInsets.all(12),
                                child: TextFormField(
                                  controller: itemNameController,
                                  textInputAction: TextInputAction.next,
                                  focusNode: itemNameFocus,
                                  onFieldSubmitted: (term) {
                                    _fieldFocusChange(context, itemNameFocus,
                                        descriptionFocus);
                                  },
                                  decoration: InputDecoration(
                                    labelText: "Item Name",
                                    fillColor: Colors.white,
                                    border: OutlineInputBorder(
                                      borderRadius: BorderRadius.circular(12.0),
                                    ),
                                    //fillColor: Colors.green
                                  ),
                                  keyboardType: TextInputType.text,
                                  textCapitalization:
                                      TextCapitalization.sentences,
                                  validator: (value) {
                                    if (value.isEmpty) {
                                      return 'Please enter item';
                                    }
                                    return null;
                                  },
                                ),
                              ),
                            ),
                          ],
                        ),
                        Row(
                          children: <Widget>[
                            Expanded(
                              child: Container(
                                padding: EdgeInsets.all(12),
                                child: TextFormField(
                                  controller: descriptionController,
                                  textInputAction: TextInputAction.next,
                                  focusNode: descriptionFocus,
                                  onFieldSubmitted: (term) {
                                    _fieldFocusChange(
                                        context, descriptionFocus, priceFocus);
                                  },
                                  decoration: InputDecoration(
                                    labelText: "Description",
                                    fillColor: Colors.white,
                                    border: OutlineInputBorder(
                                      borderRadius: BorderRadius.circular(12.0),
                                    ),
                                    //fillColor: Colors.green
                                  ),
                                  keyboardType: TextInputType.text,
                                  textCapitalization:
                                      TextCapitalization.sentences,
                                  validator: (value) {
                                    if (value.isEmpty) {
                                      return 'Please enter Description';
                                    }
                                    return null;
                                  },
                                ),
                              ),
                            ),
                          ],
                        ),

                        Row(
                          children: <Widget>[
                            Expanded(
                              child: Container(
                                padding: EdgeInsets.all(12),
                                child: TextFormField(
                                  controller: priceController,
                                  focusNode: priceFocus,
                                  decoration: InputDecoration(
                                    labelText: "Price",
                                    fillColor: Colors.white,
                                    border: OutlineInputBorder(
                                      borderRadius: BorderRadius.circular(12.0),
                                    ),
                                  ),
                                  keyboardType: TextInputType.numberWithOptions(
                                      decimal: true),
                                  validator: (value) {
                                    if (value.isEmpty) {
                                      return 'Please enter Price';
                                    }
                                    return null;
                                  },
                                ),
                              ),
                            ),
                            FlatButton(
                              child: Text('confirm item'),
                              onPressed: () {
                                confirmItem(restaurantData);
                              },
                            ),
                          ],
                        ),

                        ////////////////// to display food item present in the menu///////////////////
                      ],
                    ),
                  ),
                ),
                VerticalDivider(
                  thickness: 2,
                  indent: 12,
                  endIndent: 12,
                ),
                Expanded(
                  child: restaurantData.restaurant.addOnsMenu != null
                      ? ListView.builder(
                          shrinkWrap: true,
                          itemCount:
                              restaurantData.restaurant.addOnsMenu.length,
                          itemBuilder: (context, index) {
                            return FlatButton(
                              child: ListTile(
                                title: Text(
                                  restaurantData
                                      .restaurant.addOnsMenu[index].name,
                                  style: kTitleStyle,
                                ),
                                subtitle: Text(
                                  " ₹ " +
                                      restaurantData
                                          .restaurant.addOnsMenu[index].price,
                                  style: kSubTitleStyle,
                                ),
                                trailing: Row(
                                  mainAxisSize: MainAxisSize.min,
                                  children: <Widget>[
                                    Container(
                                      decoration: BoxDecoration(
                                        shape: BoxShape.circle,
                                        color: restaurantData
                                                    .restaurant
                                                    .addOnsMenu[index]
                                                    .visibility ==
                                                true
                                            ? Colors.green
                                            : Colors.red,
                                      ),
                                      height: 16,
                                      width: 16,
                                    ),
                                    IconButton(
                                      icon: Icon(Icons.cancel),
                                      onPressed: () {
                                        /////////////////////////////////////////////
                                        removeAddOnEverywhere(
                                            restaurantData.restaurant
                                                .addOnsMenu[index].oid,
                                            restaurantData);
                                        ///////////////////////////////////////////
                                        restaurantData
                                            .sendConfiguredDataToBackend({
                                          "food_id": restaurantData
                                              .restaurant.addOnsMenu[index].oid
                                        }, "delete_add_ons");
                                      },
                                    ),
                                  ],
                                ),
                              ),
                              onPressed: () {
                                //////////////////////////////// view item ///////////////
                                Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                    builder: (context) => ViewItem(
                                      showCustomization: false,
                                      menuType: "add_ons",
                                      foodItem: restaurantData
                                          .restaurant.addOnsMenu[index],
                                    ),
                                  ),
                                );
                              },
                            );
                          },
                        )
                      : Center(
                          child: Text(
                            'No items in Add-ons.!!',
                            style: kHeaderStyleSmall,
                          ),
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

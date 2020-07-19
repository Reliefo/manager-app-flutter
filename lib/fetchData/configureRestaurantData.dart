import 'dart:convert';
import 'dart:math';

import 'package:flutter/material.dart';
import 'package:manager_app/data.dart';

class RestaurantData extends ChangeNotifier {
  final Restaurant restaurant;
  final Map<String, dynamic> registeredUser;
  final sockets;
//  final jsSocket;

  RestaurantData({
    this.restaurant,
    this.registeredUser,
    this.sockets,
//    this.jsSocket,
  });

  sendDataThroughSocket(String eventName, var encodedData) {
    String socketPackage = "socketio";
    if (socketPackage == "adhara") {
      sockets['working'].emit(eventName, [encodedData]);
    } else {
      sockets['liqr'].emit(eventName, encodedData);
    }
  }

  sendConfiguredDataToBackend(Map<String, dynamic> localData, type) {
    var encode;
    String restaurantId = restaurant.restaurantId;
////////////////////////////////    table      ///////////////////

    if (type == "add_tables") {
      encode = jsonEncode({
        "restaurant_id": restaurantId,
        "type": type,
        "table": localData,
      });
    }

    if (type == "edit_tables") {
      encode = jsonEncode({
        "restaurant_id": restaurantId,
        "type": type,
        "table_id": localData["table_id"],
        "editing_fields": localData["editing_fields"]
      });
    }

    if (type == "delete_tables") {
      localData["type"] = type;
      localData['restaurant_id'] = restaurantId;
      encode = jsonEncode(localData);
    }

///////////////////////////////////////////////staff//////////////////////////////////
    if (type == "add_staff") {
      encode = jsonEncode({
        "restaurant_id": restaurantId,
        "type": type,
        "staff": localData,
      });
    }

    if (type == "edit_staff") {
      encode = jsonEncode({
        "restaurant_id": restaurantId,
        "type": type,
        "staff_id": localData["staff_id"],
        "editing_fields": localData["editing_fields"]
      });
    }

    if (type == "delete_staff") {
      localData["type"] = type;
      localData['restaurant_id'] = restaurantId;
      encode = jsonEncode(localData);
    }

    if (type == "assign_staff") {
      encode = jsonEncode({
        "restaurant_id": restaurantId,
        "type": type,
        "table_id": localData["table_id"],
        "assigned_staff": localData["assigned_staff"]
      });
    }

    if (type == "withdraw_staff") {
      encode = jsonEncode({
        "restaurant_id": restaurantId,
        "type": type,
        "table_id": localData["table_id"],
        "withdraw_staff_id": localData["withdraw_staff_id"],
      });
    }

    ////////////////////////////////////kitchen staff//////////////////////////////
    if (type == "add_kitchen_staff") {
      localData['restaurant_id'] = restaurantId;
      localData['type'] = type;
      encode = jsonEncode(localData);
    }

    if (type == "edit_kitchen_staff") {
      localData['restaurant_id'] = restaurantId;
      localData['type'] = type;
      encode = jsonEncode(localData);
    }

    if (type == "delete_kitchen_staff") {
      localData['restaurant_id'] = restaurantId;
      localData['type'] = type;
      encode = jsonEncode(localData);
    }

    ////////////////////////////  kitchen ///////////////////////

    if (type == "add_kitchen") {
      localData['restaurant_id'] = restaurantId;
      localData['type'] = type;
      encode = jsonEncode(localData);
    }

    if (type == "edit_kitchen") {
      localData['restaurant_id'] = restaurantId;
      localData['type'] = type;
      encode = jsonEncode(localData);
    }

    if (type == "delete_kitchen") {
      localData['restaurant_id'] = restaurantId;
      localData['type'] = type;
      encode = jsonEncode(localData);
    }

    ////////////////////////////assign category ////////////////
    if (type == "category_kitchen") {
      localData['restaurant_id'] = restaurantId;
      localData['type'] = type;
      encode = jsonEncode(localData);
    }

    if (type == "decategory_kitchen") {
      localData['restaurant_id'] = restaurantId;
      localData['type'] = type;
      encode = jsonEncode(localData);
    }

////////////////////////////////////////   menu         /////////////////////
    if (type == "add_food_category") {
      encode = jsonEncode(
          {"restaurant_id": restaurantId, "type": type, "category": localData});
    }

    if (type == "edit_food_category") {
      encode = jsonEncode({
        "restaurant_id": restaurantId,
        "type": type,
        "category_id": localData["category_id"],
        "editing_fields": localData["editing_fields"]
      });
    }

    if (type == "delete_food_category") {
      localData["type"] = type;
      localData['restaurant_id'] = restaurantId;
      encode = jsonEncode(localData);
    }

    if (type == "reorder_food_category") {
      localData["type"] = type;
      localData['restaurant_id'] = restaurantId;
      encode = jsonEncode(localData);
    }

    if (type == "add_bar_category") {
      encode = jsonEncode({
        "restaurant_id": restaurantId,
        "type": type,
        "category": localData,
      });
    }

    if (type == "edit_bar_category") {
      encode = jsonEncode({
        "restaurant_id": restaurantId,
        "type": type,
        "category_id": localData["category_id"],
        "editing_fields": localData["editing_fields"]
      });
    }

    if (type == "delete_bar_category") {
      localData["type"] = type;
      localData['restaurant_id'] = restaurantId;
      encode = jsonEncode(localData);
    }

    if (type == "reorder_bar_category") {
      localData["type"] = type;
      localData['restaurant_id'] = restaurantId;
      encode = jsonEncode(localData);
    }

    if (type == "add_food_item") {
      localData["type"] = type;
      localData['restaurant_id'] = restaurantId;
      encode = jsonEncode(localData);
    }

//    if (type == "add_food_item") {
//      if (localData['food_dict']["food_options"]['options'].length == 0)
//        localData['food_dict']["food_options"].remove('options');
//      else {
//        List pricesList = [];
//
//        localData['food_dict']["food_options"]['options'].forEach((option) {
//          pricesList.add(option["option_price"]);
//        });
//        localData['food_dict']['price'] = pricesList.join('/');
//      }
//      if (localData['food_dict']["food_options"]['choices'].length == 0)
//        localData['food_dict']["food_options"].remove('choices');
//      if (localData['food_dict']["food_options"].length == 0)
//        localData['food_dict'].remove('food_options');
//      localData['restaurant_id'] = restaurantId;
//      localData['food_dict']['restaurant_id'] = restaurantId;
//      localData['type'] = type;
//      encode = jsonEncode(localData);
//    }

//    if (type == "edit_food_item") {
//      if (localData['editing_fields']['customization'] != null) {
//        if (localData['editing_fields']['food_options']['options'] != null) {
//          List pricesList = [];
//          localData['editing_fields']['food_options']['options']
//              ?.forEach((optionsPair) {
//            pricesList.add(optionsPair['option_price']);
//          });
//          encode = jsonEncode({
//            "restaurant_id": restaurantId,
//            "type": type,
//            "food_id": localData["food_id"],
//            "category_type": localData["category_type"],
//            "editing_fields": {
//              "price": pricesList.join('/'),
//              "food_options": localData['editing_fields']['food_options'],
//            },
//          });
//        }
//      } else {
//        localData["type"] = type;
//        localData['restaurant_id'] = restaurantId;
//        encode = jsonEncode(localData);
//      }
//    }
    if (type == "edit_food_item") {
      if (localData['editing_fields']['customization'] != null) {
        double price = 0;
        List<double> priceList = [];
        localData['editing_fields']['customization']?.forEach((customization) {
          print(customization);
          if (customization['customization_type'] == "options") {
            print("will add price");

            customization['list_of_options']?.forEach((option) {
              print(option['option_price'].runtimeType);
              priceList.add(option['option_price']);
            });
            if (priceList.isNotEmpty) {
              price = price + priceList.reduce(min);
            }

            encode = jsonEncode({
              "restaurant_id": restaurantId,
              "type": type,
              "category_type": localData["category_type"],
              "food_id": localData["food_id"],
              "editing_fields": {
                "price": "${price.toString() + " +"}",
                "customization": localData["editing_fields"]["customization"],
              },
            });
          }
        });
        print("price:  ");
        print(price);
        encode = jsonEncode({
          "restaurant_id": restaurantId,
          "type": type,
          "category_type": localData["category_type"],
          "food_id": localData["food_id"],
          "editing_fields": {
            "customization": localData["editing_fields"]["customization"],
          },
        });
      } else {
        localData["type"] = type;
        localData['restaurant_id'] = restaurantId;
        encode = jsonEncode(localData);
      }
    }
    if (type == "delete_food_item") {
      encode = jsonEncode({
        "restaurant_id": restaurantId,
        "type": type,
        "category_type": localData["category_type"],
        "food_id": localData["food_id"],
      });
    }

    if (type == "reorder_food_item") {
      localData['restaurant_id'] = restaurantId;
      localData['type'] = type;
      encode = jsonEncode(localData);
    }

    if (type == "visibility_food_item") {
      localData['restaurant_id'] = restaurantId;
      localData['type'] = type;
      encode = jsonEncode(localData);
    }
    /////////////////////////////////add -ons///////////////////

    if (type == "add_add_ons") {
      localData['restaurant_id'] = restaurantId;
      localData['type'] = type;

      encode = jsonEncode(localData);
    }

    if (type == "delete_add_ons") {
      localData['restaurant_id'] = restaurantId;
      localData['type'] = type;

      encode = jsonEncode(localData);
    }
/////////////////////////////////////////////////////////
    if (type == "add_home_screen_tags") {
      localData['restaurant_id'] = restaurantId;
      localData['type'] = type;

      encode = jsonEncode(localData);
    }

    if (type == "delete_home_screen_tags") {
      //todo: check
      localData['restaurant_id'] = restaurantId;
      localData['type'] = type;

      encode = jsonEncode(localData);
    }

    if (type == "attach_home_screen_tags") {
      localData['restaurant_id'] = restaurantId;
      localData['type'] = type;

      encode = jsonEncode(localData);
    }

    if (type == "remove_home_screen_tags") {
      //todo: check
      localData['restaurant_id'] = restaurantId;
      localData['type'] = type;

      encode = jsonEncode(localData);
    }

    if (type == "reorder_home_screen_tags") {
      localData['restaurant_id'] = restaurantId;
      localData['type'] = type;

      encode = jsonEncode(localData);
    }

    if (type == "ordering-ability_manage") {
      localData['restaurant_id'] = restaurantId;
      localData['type'] = type;

      encode = jsonEncode(localData);
    }

    if (type == "display-order-buttons_manage") {
      localData['restaurant_id'] = restaurantId;
      localData['type'] = type;

      encode = jsonEncode(localData);
    }

    if (type == "set_taxes") {
      encode = jsonEncode({
        "restaurant_id": restaurantId,
        "type": type,
        "taxes": localData["taxes"],
      });
    }
    print("before sending to cloud");

    print(encode);
    //todo: get sockets from socket connection
    sendDataThroughSocket('configuring_restaurant', encode);
    print('uploded to cloud');
  }

  sendStaffRegistrationToBackend(data) {
    var encode;
    print("test sending");
    encode = jsonEncode(data);
    print(encode);
//    sockets['working'].emit('register_your_people', [encode]);
    sendDataThroughSocket('register_your_people', encode);
  }

  billTheTable(data) {
    var encode;
    print("test sending");
    encode = jsonEncode(data);
    print(encode);
//    sockets['working'].emit('bill_the_table', [encode]);
    sendDataThroughSocket('bill_the_table', encode);
  }

  refreshAllData() {
//    sockets['working'].emit("fetch_rest_manager", [
//      jsonEncode({"restaurant_id": restaurant.restaurantId})
//    ]);
    sendDataThroughSocket('fetch_rest_manager',
        jsonEncode({"restaurant_id": restaurant.restaurantId}));
  }
}

import 'dart:convert';

import 'package:adhara_socket_io/adhara_socket_io.dart';
import 'package:flutter/material.dart';
import 'package:manager_app/data.dart';

class RestaurantData extends ChangeNotifier {
  final Restaurant restaurant;
  final Map<String, dynamic> registeredUser;

  final Map<String, SocketIO> sockets;
  RestaurantData({
    this.restaurant,
    this.registeredUser,
    this.sockets,
  });

//  fetchRestaurant(data) {
//    if (data is Map) {
//      data = json.encode(data);
//    }
//
//    var decoded = jsonDecode(data);
////    print(decoded);
//    restaurant = Restaurant.fromJson(decoded);
//  }

//  getConfiguredDataFromBackend(data) {
//    if (data is Map) {
//      data = json.encode(data);
//    }
//
//    var decode = jsonDecode(data);
//    print('configuring restaurant');
//    print(decode);
//    ////////////////////////////////    table      ///////////////////
//
//    if (decode["type"] == "add_tables") {
//      restaurant.addTableDetails(decode['tables']);
//    }
//
//    if (decode["type"] == "edit_tables") {
//      restaurant.tables.forEach((table) {
//        if (table.oid == decode["table_id"]) {
//          table.name = decode["editing_fields"]["name"];
//          table.seats = decode["editing_fields"]["seats"];
//        }
//      });
//    }
//
//    if (decode["type"] == "delete_tables") {
//      restaurant.tables.removeWhere((table) => table.oid == decode["table_id"]);
//    }
//    ////////////////////////////////    staff     ///////////////////
//    if (decode["type"] == "add_staff") {
//      restaurant.addStaffDetails(decode['staff']);
//    }
//
//    if (decode["type"] == "edit_staff") {
//      restaurant.staff.forEach((staff) {
//        if (staff.oid == decode["staff_id"]) {
//          staff.name = decode["editing_fields"]["name"];
//        }
//      });
//    }
//
//    if (decode["type"] == "delete_staff") {
//      restaurant.staff.removeWhere((staff) => staff.oid == decode["staff_id"]);
//    }
//    ////////////////////////////////    assign staff     ///////////////////
//    if (decode["type"] == "assign_staff") {
//      restaurant.tables.forEach((table) {
//        if (table.oid == decode["table_id"]) {
//          print('table matched: ${table.name}');
//
//          decode["assigned_staff"].forEach((assignedStaff) {
//            print("assigning new staff ");
//            print(assignedStaff);
//            restaurant.staff.forEach((restStaff) {
//              if (assignedStaff == restStaff.oid) {
//                table.addTableStaff(restStaff);
//              }
//            });
//          });
//        }
//      });
//    }
//
//    if (decode["type"] == "withdraw_staff") {
//      restaurant.tables.forEach((table) {
//        if (table.oid == decode["table_id"]) {
//          table.staff.removeWhere(
//            (staff) => staff.oid == decode["withdraw_staff_id"],
//          );
//        }
//      });
//    }
//////////////////////////////////////////   menu         /////////////////////
//    if (decode["type"] == "add_food_category") {
//      restaurant.addFoodMenuCategory(decode["category"]);
//    }
//
//    if (decode["type"] == "edit_food_category") {
//      restaurant.foodMenu.forEach((category) {
//        if (category.oid == decode["category_id"]) {
//          category.name = decode["editing_fields"]["name"];
//
//          category.description = decode["editing_fields"]["description"];
//        }
//      });
//    }
//
//    if (decode["type"] == "delete_food_category") {
//      restaurant.foodMenu
//          .removeWhere((category) => category.oid == decode["category_id"]);
//    }
//    if (decode["type"] == "add_bar_category") {
//      restaurant.addBarMenuCategory(decode["category"]);
//    }
//
//    if (decode["type"] == "edit_bar_category") {
//      restaurant.barMenu.forEach((category) {
//        if (category.oid == decode["category_id"]) {
//          category.name = decode["editing_fields"]["name"];
//
//          category.description = decode["editing_fields"]["description"];
//        }
//      });
//    }
//
//    if (decode["type"] == "delete_bar_category") {
//      restaurant.barMenu
//          .removeWhere((category) => category.oid == decode["category_id"]);
//    }
//
//    if (decode["type"] == "add_food_item") {
//      if (decode["category_type"] == "food") {
//        restaurant.foodMenu.forEach((category) {
//          if (category.oid == decode["category_id"]) {
//            print("${category.name} matched");
//            category.addFoodItem(decode["food_dict"]);
//          }
//        });
//      } else if (decode["category_type"] == "bar") {
//        restaurant.barMenu.forEach((category) {
//          if (category.oid == decode["category_id"]) {
//            print("${category.name} matched");
//            category.addFoodItem(decode["food_dict"]);
//          }
//        });
//      }
//    }
//
//    if (decode["type"] == "edit_food_item") {
//      if (decode["category_type"] == "food") {
//        restaurant.foodMenu.forEach((category) {
//          category.foodList.forEach((foodItem) {
//            if (foodItem.oid == decode["food_id"]) {
//              print("hjsdhsjhsjdh");
//              foodItem.addEdited(decode["editing_fields"]);
//            }
//          });
//        });
//      } else if (decode["category_type"] == "bar") {
//        restaurant.barMenu.forEach((category) {
//          category.foodList.forEach((foodItem) {
//            if (foodItem.oid == decode["food_id"]) {
//              print("hjsdhsjhsjdh");
//              foodItem.addEdited(decode["editing_fields"]);
//            }
//          });
//        });
//      }
//    }
//
//    if (decode["type"] == "delete_food_item") {
//      restaurant.foodMenu.forEach((category) {
//        category.foodList.removeWhere((food) => food.oid == decode["food_id"]);
//      });
//      restaurant.barMenu.forEach((category) {
//        category.foodList.removeWhere((food) => food.oid == decode["food_id"]);
//      });
//    }
//
//    notifyListeners();
//  }

//Todo: will be fetched using providers
  sendConfiguredDataToBackend(localData, type) {
//    print(type);
//    print(localData);
    var encode;
    String restaurantId = restaurant.restaurantId;
////////////////////////////////    table      ///////////////////
//    var request_type = type.split()[1]
//    configuringTables(localData, request_type)

    if (type == "add_tables") {
      encode = jsonEncode({
        "restaurant_id": restaurantId,
        "type": type,
        "tables": localData,
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
      encode = jsonEncode({
        "restaurant_id": restaurantId,
        "type": type,
        "table_id": localData,
      });
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
      encode = jsonEncode({
        "restaurant_id": restaurantId,
        "type": type,
        "staff_id": localData,
      });
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
      encode = jsonEncode({
        "restaurant_id": restaurantId,
        "type": type,
        "category_id": localData
      });
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
      encode = jsonEncode({
        "restaurant_id": restaurantId,
        "type": type,
        "category_id": localData
      });
    }

    if (type == "add_food_item") {
      if (localData['food_dict']["food_options"]['options'].length == 0)
        localData['food_dict']["food_options"].remove('options');
      else {
        List pricesList = [];

        localData['food_dict']["food_options"]['options'].forEach((option) {
          pricesList.add(option["option_price"]);
        });
        localData['food_dict']['price'] = pricesList.join('/');
      }
      if (localData['food_dict']["food_options"]['choices'].length == 0)
        localData['food_dict']["food_options"].remove('choices');
      if (localData['food_dict']["food_options"].length == 0)
        localData['food_dict'].remove('food_options');
      localData['restaurant_id'] = restaurantId;
      localData['food_dict']['restaurant_id'] = restaurantId;
      localData['type'] = type;
      encode = jsonEncode(localData);
    }

    if (type == "edit_food_item") {
      if (localData['editing_fields']['food_options'] != null) {
        if (localData['editing_fields']['food_options']['options'] != null) {
          List pricesList = [];
          localData['editing_fields']['food_options']['options']
              ?.forEach((optionsPair) {
            pricesList.add(optionsPair['option_price']);
          });
          encode = jsonEncode({
            "restaurant_id": restaurantId,
            "type": type,
            "food_id": localData["food_id"],
            "category_type": localData["category_type"],
            "editing_fields": {
              "price": pricesList.join('/'),
              "food_options": localData['editing_fields']['food_options'],
            },
          });
        }
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

    if (type == "visibility_food_item") {
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
    sockets['working'].emit('configuring_restaurant', [encode]);
    print('uploded to cloud');
  }

  sendStaffRegistrationToBackend(data) {
    var encode;
    print("test sending");
    encode = jsonEncode(data);
    print(encode);
    sockets['working'].emit('register_your_people', [encode]);
  }

  billTheTable(data) {
    var encode;
    print("test sending");
    encode = jsonEncode(data);
    print(encode);
    sockets['working'].emit('bill_the_table', [encode]);
  }
}

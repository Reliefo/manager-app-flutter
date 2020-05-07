import 'package:adhara_socket_io_example/data.dart';
import 'package:flutter/material.dart';

class OrderData extends ChangeNotifier {
  List<TableOrder> queueOrders;
  List<TableOrder> cookingOrders;
  List<TableOrder> completedOrders;
  Restaurant restaurant;
  OrderData({
    this.restaurant,
    this.queueOrders,
    this.cookingOrders,
    this.completedOrders,
  });
//  initialOrderLists(data) {
//    if (data is Map) {
//      data = json.encode(data);
//    }
//    int queue = 0;
//    int cooking = 0;
//    int completed = 0;
//
//    var decoded = jsonDecode(data);
//
//    queueOrders.clear();
//    cookingOrders.clear();
//    completedOrders.clear();
//
//    decoded["queue"].forEach((item) {
//      TableOrder order = TableOrder.fromJson(item);
//
//      queueOrders.add(order);
/////////////for adding count to table
//      restaurant.tables.forEach((table) {
//        if (item["table_id"] == table.oid) {
//          item["orders"].forEach((order) {
//            queue = queue + order["food_list"].length;
//            print(queue);
//            table.updateOrderCount(queue, cooking, completed);
//          });
//        }
//        queue = 0;
//      });
//    });
//    decoded["cooking"].forEach((item) {
//      TableOrder order = TableOrder.fromJson(item);
//
//      cookingOrders.add(order);
/////////////for adding count to table
//      restaurant.tables.forEach((table) {
//        if (item["table_id"] == table.oid) {
//          item["orders"].forEach((order) {
//            cooking = cooking + order["food_list"].length;
//            table.updateOrderCount(queue, cooking, completed);
//          });
//        }
//        cooking = 0;
//      });
//    });
//    decoded["completed"].forEach((item) {
//      TableOrder order = TableOrder.fromJson(item);
//
//      completedOrders.add(order);
/////////////for adding count to table
//      restaurant.tables.forEach((table) {
//        if (item["table_id"] == table.oid) {
//          item["orders"].forEach((order) {
//            completed = completed + order["food_list"].length;
//            table.updateOrderCount(queue, cooking, completed);
//          });
//        }
//        completed = 0;
//      });
//    });
//  }

//  newOrders(data) {
//    if (data is Map) {
//      data = json.encode(data);
//    }
//    int queue = 0;
//    var decoded = jsonDecode(data);
//
//    TableOrder order = TableOrder.fromJson(decoded);
//
//    queueOrders.add(order);
//
//    restaurant.tables.forEach((table) {
//      if (decoded["table_id"] == table.oid) {
//        decoded["orders"].forEach((order) {
//          queue = queue + order["food_list"].length;
//        });
//        table.updateOrderCount(queue, 0, 0);
//      }
//      queue = 0;
//    });
//  }
//
//  orderUpdates(data) {
//    if (data is Map) {
//      data = json.encode(data);
//    }
//    var decoded = jsonDecode(data);
//
//    var selectedOrder;
//
//    if (decoded['type'] == "cooking") {
//      selectedOrder = queueOrders;
//    } else if (decoded['type'] == "completed") {
//      selectedOrder = cookingOrders;
//    }
//
//    var currentTableId;
//    selectedOrder.forEach((tableorder) {
//      if (tableorder.oId == decoded['table_order_id']) {
//        currentTableId = tableorder.tableId;
//        restaurant.tables.forEach((table) {
//          if (currentTableId == table.oid) {
//            if (decoded['type'] == "cooking") {
//              table.updateOrderCount(-1, 1, 0);
//            } else if (decoded['type'] == "completed") {
//              table.updateOrderCount(0, -1, 1);
//            }
//          }
//        });
//
////          print('table id  matched${decoded['food_id']}');
//        tableorder.orders.forEach((order) {
//          if (order.oId == decoded['order_id']) {
////              print('order id  matched${decoded['food_id']}');
//            order.foodList.forEach((fooditem) {
//              if (fooditem.foodId == decoded['food_id']) {
////                  print('food id  matched${decoded['food_id']}');
//                fooditem.status = decoded['type'];
////                   push to cooking and completed orders
//                pushTo(tableorder, order, fooditem, decoded['type']);
////                  print('coming here at leastsadf');
//
//                order.removeFoodItem(decoded['food_id']);
////                  print('coming here at least');
//                tableorder.cleanOrders(order.oId);
//                if (tableorder.selfDestruct()) {
////                    print('self destruct');
//
//                  selectedOrder.removeWhere(
//                      (taborder) => taborder.oId == tableorder.oId);
//                }
//              }
//            });
//          }
//        });
//      }
//    });
//  }
//
//  pushTo(table_order, order, foodItem, type) {
//    var foundTable = false;
//    var foundOrder = false;
//    var pushingTo;
//    if (type == "cooking") {
//      pushingTo = cookingOrders;
//    } else if (type == "completed") {
//      pushingTo = completedOrders;
//    }
//
//    if (pushingTo.length == 0) {
//      TableOrder tableOrder = TableOrder.fromJsonNew(table_order.toJson());
//      Order currOrder = Order.fromJsonNew(order.toJson());
//      currOrder.addFirstFood(foodItem);
//
//      tableOrder.addFirstOrder(currOrder);
////        print(tableOrder.orders[0].foodList[0].name);
//      pushingTo.add(tableOrder);
//    } else {
//      pushingTo.forEach((tableOrder) {
//        if (table_order.oId == tableOrder.oId) {
//          foundTable = true;
//          tableOrder.orders.forEach((currOrder) {
//            if (order.oId == currOrder.oId) {
//              foundOrder = true;
//              currOrder.addFood(foodItem);
//            }
//          });
//          if (!foundOrder) {
//            Order currOrder = Order.fromJsonNew(order.toJson());
//            currOrder.addFirstFood(foodItem);
//
//            tableOrder.addOrder(currOrder);
//          }
//        }
//      });
//      if (!foundTable) {
//        TableOrder tableOrder = TableOrder.fromJsonNew(table_order.toJson());
//        Order currOrder = Order.fromJsonNew(order.toJson());
//        currOrder.addFirstFood(foodItem);
//
//        tableOrder.addFirstOrder(currOrder);
////          print(tableOrder.orders[0].foodList[0].name);
//        pushingTo.add(tableOrder);
//      }
//    }
//  }
}

import 'dart:convert';

import 'package:adhara_socket_io/adhara_socket_io.dart';
import 'package:flutter/material.dart';
import 'package:manager_app/data.dart';
import 'package:manager_app/tabs.dart';
import 'package:manager_app/url.dart';

import 'session.dart';

class SocketConnection extends StatefulWidget {
  final String jwt;
  final String restaurantId;
  SocketConnection({
    this.jwt,
    this.restaurantId,
  });

  @override
  _SocketConnectionState createState() => _SocketConnectionState();
}

class _SocketConnectionState extends State<SocketConnection> {
  @override
  void initState() {
    initSocket(uri);
//    login();
    super.initState();
  }

  Restaurant restaurant = Restaurant();
  List<TableOrder> queueOrders = [];
  List<TableOrder> cookingOrders = [];
  List<TableOrder> completedOrders = [];
//  List<AssistanceRequest> assistanceReq = [];
  Map<String, dynamic> registeredUser = {};

  SocketIOManager manager = SocketIOManager();
  Map<String, SocketIO> sockets = {};
  Map<String, bool> _isProbablyConnected = {};
  Session loginSession = Session();

  initSocket(String uri) async {
    print('hey from new init file');
//    print(loginSession.jwt);
//    print(sockets.length);
    var identifier = 'working';
    SocketIO socket = await manager.createInstance(SocketOptions(
        //Socket IO server URI
        uri,
        nameSpace: "/reliefo",
        //Query params - can be used for authentication
        query: {
          "jwt": widget.jwt,
//          "username": loginSession.username,
          "info": "new connection from adhara-socketio",
          "timestamp": DateTime.now().toString()
        },
        //Enable or disable platform channel logging
        enableLogging: false,
        transports: [
          Transports.WEB_SOCKET /*, Transports.POLLING*/
//          Transports.POLLING
        ] //Enable required transport

        ));
    socket.onConnect((data) {
      pprint({"Status": "connected..."});
//      pprint(data);
//      sendMessage("DEFAULT");
      socket.emit("fetch_rest_manager", [
        jsonEncode({"restaurant_id": widget.restaurantId})
      ]);
//      socket.emit("rest_with_id", [widget.restaurantId]);
//      socket.emit("fetch_order_lists", [widget.restaurantId]);
      socket.emit("check_logger", [" sending........."]);
    });
    socket.onConnectError(pprint);
    socket.onConnectTimeout(pprint);
    socket.onError(pprint);
    socket.onDisconnect((data) {
      print('object disconnnecgts');
//      disconnect('working');
    });
    socket.on("logger", (data) => pprint(data));

    socket.on("restaurant_object", (data) => fetchRestaurant(data));

    socket.on("updating_config", (data) => getConfiguredDataFromBackend(data));
    socket.on("receive_your_people", (data) => fetchRegisteredUsers(data));

    socket.on("order_lists", (data) => initialOrderLists(data));

    socket.on("new_orders", (data) => newOrders(data));
    socket.on("order_updates", (data) => orderUpdates(data));

    socket.on("assist", (data) => newAssistanceRequests(data));

    socket.on("user_scan", (data) => fetchScanUpdates(data));
    socket.on("billing", (data) => fetchBilled(data));

    socket.connect();
    sockets[identifier] = socket;
  }

  bool isProbablyConnected(String identifier) {
    return _isProbablyConnected[identifier] ?? false;
  }

  disconnect(String identifier) async {
    await manager.clearInstance(sockets[identifier]);
    _isProbablyConnected[identifier] = false;
  }

  pprint(data) {
    if (data is Map) {
      data = json.encode(data);
    }
    print("from logger: $data");
  }

  printRest() {
    print("Printing rest name");
    print(restaurant.name);
  }

//////////////////////////////////restaurant///////////////////////////
  fetchRestaurant(data) {
    setState(() {
      if (data is Map) {
        data = json.encode(data);
      }

      var decoded = jsonDecode(data);
      print("comfirming");
      print(decoded);
//      print("here:  ${decoded["navigate_better_tags"].length}");

      restaurant = Restaurant.fromJson(decoded);
    });
  }

  getConfiguredDataFromBackend(data) {
    setState(() {
      if (data is Map) {
        data = json.encode(data);
      }

      var decode = jsonDecode(data);
      print('configuring restaurant');
      print(decode);
      ////////////////////////////////    table      ///////////////////

      if (decode["type"] == "add_tables") {
        restaurant.addTableDetails(decode['tables']);
      }

      if (decode["type"] == "edit_tables") {
        restaurant.tables.forEach((table) {
          if (table.oid == decode["table_id"]) {
            table.name = decode["editing_fields"]["name"];
            table.seats = decode["editing_fields"]["seats"];
          }
        });
      }

      if (decode["type"] == "delete_tables") {
        restaurant.tables
            .removeWhere((table) => table.oid == decode["table_id"]);
      }

      ////////////////////////////////  kitchen staff     ///////////////////
      if (decode["type"] == "add_kitchen_staff") {
        restaurant.addKitchenStaffDetails(decode['kitchen_staff']);
      }

      if (decode["type"] == "edit_kitchen_staff") {
        restaurant.kitchenStaff.forEach((kitchenStaff) {
          if (kitchenStaff.oid == decode["kitchen_staff_id"]) {
            kitchenStaff.name = decode["editing_fields"]["name"];
          }
        });
      }

      if (decode["type"] == "delete_kitchen_staff") {
        restaurant.kitchenStaff.removeWhere(
            (kitchenStaff) => kitchenStaff.oid == decode["kitchen_staff_id"]);
      }
      ////////////////////////////////    staff     ///////////////////
      if (decode["type"] == "add_staff") {
        restaurant.addStaffDetails(decode['staff']);
      }

      if (decode["type"] == "edit_staff") {
        restaurant.staff.forEach((staff) {
          if (staff.oid == decode["staff_id"]) {
            staff.name = decode["editing_fields"]["name"];
          }
        });
      }

      if (decode["type"] == "delete_staff") {
//        {restaurant_id: BNGHSR0003, type: delete_staff, staff_id: 5eca869084f3f4e32ec2625e}
        setState(() {
          restaurant.staff
              .removeWhere((staff) => staff.oid == decode["staff_id"]);
        });
        setState(() {
          restaurant.tables.forEach((table) {
            print(" table name ${table.name}");
            if (table.staff != null && table.staff.isNotEmpty) {
              var thisStaff;
              table.staff.forEach((staff) {
                print(" table name: ${table.name}  staff name : ${staff.name}");
                if (staff.oid == decode["staff_id"]) {
                  print("staff matched : ${staff.name}");
                  thisStaff = staff;

                  print("rererewwe");
                }
              });

              table.staff.removeWhere((element) => thisStaff == element);
            } else
              print("is empty");
          });
        });
      }
      ////////////////////////////////    assign staff     ///////////////////
      if (decode["type"] == "assign_staff") {
        restaurant.tables.forEach((table) {
          if (table.oid == decode["table_id"]) {
            print('table matched: ${table.name}');

            decode["assigned_staff"].forEach((assignedStaff) {
              print("assigning new staff ");
              print(assignedStaff);
              restaurant.staff.forEach((restStaff) {
                if (assignedStaff == restStaff.oid) {
                  table.addTableStaff(restStaff);
                }
              });
            });
          }
        });
      }

      if (decode["type"] == "withdraw_staff") {
        restaurant.tables.forEach((table) {
          if (table.oid == decode["table_id"]) {
            table.staff.removeWhere(
              (staff) => staff.oid == decode["withdraw_staff_id"],
            );
          }
        });
      }
////////////////////////////////////////   menu         /////////////////////
      if (decode["type"] == "add_food_category") {
        restaurant.addFoodMenuCategory(decode["category"]);
      }

      if (decode["type"] == "edit_food_category") {
        restaurant.foodMenu.forEach((category) {
          if (category.oid == decode["category_id"]) {
            category.name = decode["editing_fields"]["name"];

            category.description = decode["editing_fields"]["description"];
          }
        });
      }

      if (decode["type"] == "delete_food_category") {
        restaurant.foodMenu
            .removeWhere((category) => category.oid == decode["category_id"]);
      }
      if (decode["type"] == "add_bar_category") {
        restaurant.addBarMenuCategory(decode["category"]);
      }

      if (decode["type"] == "edit_bar_category") {
        restaurant.barMenu.forEach((category) {
          if (category.oid == decode["category_id"]) {
            category.name = decode["editing_fields"]["name"];

            category.description = decode["editing_fields"]["description"];
          }
        });
      }

      if (decode["type"] == "delete_bar_category") {
        restaurant.barMenu
            .removeWhere((category) => category.oid == decode["category_id"]);
      }

      if (decode["type"] == "add_food_item") {
        if (decode["category_type"] == "food") {
          restaurant.foodMenu.forEach((category) {
            if (category.oid == decode["category_id"]) {
              print("${category.name} matched");
              category.addFoodItem(decode["food_dict"]);
            }
          });
        } else if (decode["category_type"] == "bar") {
          restaurant.barMenu.forEach((category) {
            if (category.oid == decode["category_id"]) {
              print("${category.name} matched");
              category.addFoodItem(decode["food_dict"]);
            }
          });
        }
      }

      if (decode["type"] == "edit_food_item") {
        if (decode["category_type"] == "food") {
          restaurant.foodMenu.forEach((category) {
            category.foodList.forEach((foodItem) {
              if (foodItem.oid == decode["food_id"]) {
                print("hjsdhsjhsjdh");
                foodItem.addEdited(decode["editing_fields"]);
              }
            });
          });
        } else if (decode["category_type"] == "bar") {
          restaurant.barMenu.forEach((category) {
            category.foodList.forEach((foodItem) {
              if (foodItem.oid == decode["food_id"]) {
                print("hjsdhsjhsjdh");
                foodItem.addEdited(decode["editing_fields"]);
              }
            });
          });
        }
      }

      if (decode["type"] == "delete_food_item") {
        restaurant.foodMenu.forEach((category) {
          category.foodList
              .removeWhere((food) => food.oid == decode["food_id"]);
        });
        restaurant.barMenu.forEach((category) {
          category.foodList
              .removeWhere((food) => food.oid == decode["food_id"]);
        });
      }
/////////////////////////////////       tags     //////////////////

      if (decode["type"] == "add_home_screen_tags") {
        if (decode["add_to"] == "navigate_better") {
          restaurant.navigateBetterTags.add(decode["tag_name"]);
        }

        if (decode["add_to"] == "home_screen") {
          restaurant.homeScreenTags.add(decode["tag_name"]);
        }
      }
      if (decode["type"] == "delete_home_screen_tags") {
        if (decode["remove_from"] == "navigate_better") {
          restaurant.navigateBetterTags
              .removeWhere((tag) => tag == decode["tag_name"]);
        }

        if (decode["remove_from"] == "home_screen") {
          restaurant.homeScreenTags
              .removeWhere((tag) => tag == decode["tag_name"]);
        }
      }
      if (decode["type"] == "attach_home_screen_tags") {
        restaurant.foodMenu.forEach((category) {
          category.foodList.forEach((foodItem) {
            if (foodItem.oid == decode["food_id"]) {
              foodItem.tags.add(decode["tag_name"]);
            }
          });
        });

        restaurant.barMenu.forEach((category) {
          category.foodList.forEach((barItem) {
            if (barItem.oid == decode["food_id"]) {
              barItem.tags.add(decode["tag_name"]);
            }
          });
        });
      }

      if (decode["type"] == "remove_home_screen_tags") {
        restaurant.foodMenu.forEach((category) {
          category.foodList.forEach((foodItem) {
            if (foodItem.oid == decode["food_id"]) {
              foodItem.tags.removeWhere((tag) => tag == decode["tag_name"]);
            }
          });
        });

        restaurant.barMenu.forEach((category) {
          category.foodList.forEach((barItem) {
            if (barItem.oid == decode["food_id"]) {
//              print(barItem.tags);
              barItem.tags.removeWhere((tag) => tag == decode["tag_name"]);
//              print(barItem.tags);
            }
          });
        });
      }
    });
  }

  fetchScanUpdates(data) {
    setState(() {
      if (data is Map) {
        data = json.encode(data);
      }

      var decoded = jsonDecode(data);
      print("inside scanned update");
      print(decoded);

//      {_id: {$oid: 5ebbc03a58aabe0f1c7f1599}, _cls: User.TempUser, name: Venus_1,
//      dine_in_history: [], current_table_id: 5eb41b91adb66da6f5312123, personal_cart: [],
//      timestamp: {$date: 1589322567835}, planet: Venus, planet_no: 1, unique_id: 9a8269f2-881f-4$Venus_1}
      print(decoded["current_table_id"]);
      print(decoded["_id"]["\$oid"]);
      restaurant.tables.forEach((table) {
        print("object");
        print(table.oid);
        if (table.oid == decoded["current_table_id"]) {
          print("here");
          if (!table.users.contains(decoded["_id"]["\$oid"])) {
            print("adding user");
            table.users.add(decoded["_id"]["\$oid"]);
          }
        }
      });
    });
  }

  fetchBilled(data) {
    print("inside billing");
    print(data);
//todo: implement billing when requested from customer app
    if (data["status"] == "billed") {
      setState(() {
        completedOrders
            .removeWhere((order) => order.tableId == data["table_id"]);

        restaurant.assistanceRequests
            .removeWhere((request) => request.tableId == data["table_id"]);
      });
    }
  }

  fetchRegisteredUsers(data) {
    print("registered users");
    print(data);
//    {auth_username: MID001, restaurant_name: House of Commons, user_type: staff,
//    object_id: 5ead65e1e1823a4f213257af, name: Kunal, username: SIDHOUKUN0,
//    password: SIDHOUKUN128, status: Registration successful}
    setState(() {
      data.forEach((k, v) => registeredUser[k.toString()] = v);
    });
  }

//////////////////////////orders//////////////////////////
  initialOrderLists(data) {
    setState(() {
      if (data is Map) {
        data = json.encode(data);
      }
      int queue = 0;
      int cooking = 0;
      int completed = 0;

      var decoded = jsonDecode(data);

      queueOrders.clear();
      cookingOrders.clear();
      completedOrders.clear();

      decoded["queue"].forEach((item) {
        TableOrder order = TableOrder.fromJson(item);

        queueOrders.add(order);
///////////for adding count to table
        restaurant.tables.forEach((table) {
          if (item["table_id"] == table.oid) {
            item["orders"].forEach((order) {
              queue = queue + order["food_list"].length;
              print(queue);
              table.updateOrderCount(queue, cooking, completed);
            });
          }
          queue = 0;
        });
      });
      decoded["cooking"].forEach((item) {
        TableOrder order = TableOrder.fromJson(item);

        cookingOrders.add(order);
///////////for adding count to table
        restaurant.tables.forEach((table) {
          if (item["table_id"] == table.oid) {
            item["orders"].forEach((order) {
              cooking = cooking + order["food_list"].length;
              table.updateOrderCount(queue, cooking, completed);
            });
          }
          cooking = 0;
        });
      });
      decoded["completed"].forEach((item) {
        TableOrder order = TableOrder.fromJson(item);

        completedOrders.add(order);
//        completedOrders.insert(0, order);

///////////for adding count to table
        restaurant.tables.forEach((table) {
          if (item["table_id"] == table.oid) {
            item["orders"].forEach((order) {
              completed = completed + order["food_list"].length;
              table.updateOrderCount(queue, cooking, completed);
            });
          }
          completed = 0;
        });
      });
    });
  }

  newOrders(data) {
    setState(() {
      print("new order");
      if (data is Map) {
        data = json.encode(data);
      }
      int queue = 0;
      var decoded = jsonDecode(data);

      print(decoded);

      TableOrder order = TableOrder.fromJson(decoded);

      queueOrders.add(order);

      restaurant.tables.forEach((table) {
        if (decoded["table_id"] == table.oid) {
          decoded["orders"].forEach((order) {
            queue = queue + order["food_list"].length;
          });
          table.updateOrderCount(queue, 0, 0);
        }
        queue = 0;
      });
    });
  }

  orderUpdates(data) {
    setState(() {
      if (data is Map) {
        data = json.encode(data);
      }
      var decoded = jsonDecode(data);
      print("order updateds");
      print(decoded);
      var selectedOrder;

      if (decoded['type'] == "cooking") {
        selectedOrder = queueOrders;
      } else if (decoded['type'] == "completed") {
        selectedOrder = cookingOrders;
      }

      var currentTableId;
      selectedOrder.forEach((tableorder) {
        if (tableorder.oId == decoded['table_order_id']) {
          currentTableId = tableorder.tableId;
          restaurant.tables.forEach((table) {
            if (currentTableId == table.oid) {
              if (decoded['type'] == "cooking") {
                table.updateOrderCount(-1, 1, 0);
              } else if (decoded['type'] == "completed") {
                table.updateOrderCount(0, -1, 1);
              }
            }
          });

//          print('table id  matched${decoded['food_id']}');
          tableorder.orders.forEach((order) {
            if (order.oId == decoded['order_id']) {
//              print('order id  matched${decoded['food_id']}');
              order.foodList.forEach((fooditem) {
                if (fooditem.foodId == decoded['food_id']) {
//                  print('food id  matched${decoded['food_id']}');
                  fooditem.status = decoded['type'];
//                   push to cooking and completed orders
                  print("before pushing");
                  print(tableorder.toJson());
                  pushTo(tableorder, order, fooditem, decoded['type']);
//                  print('coming here at leastsadf');

                  order.removeFoodItem(decoded['food_id']);
//                  print('coming here at least');
                  tableorder.cleanOrders(order.oId);
                  if (tableorder.selfDestruct()) {
//                    print('self destruct');

                    selectedOrder.removeWhere(
                        (taborder) => taborder.oId == tableorder.oId);
                  }
                }
              });
            }
          });
        }
      });
    });
  }

  pushTo(table_order, order, foodItem, type) {
    setState(() {
      var foundTable = false;
      var foundOrder = false;
      var pushingTo;
      if (type == "cooking") {
        pushingTo = cookingOrders;
      } else if (type == "completed") {
        pushingTo = completedOrders;
      }

      if (pushingTo.length == 0) {
        TableOrder tableOrder = TableOrder.fromJsonNew(table_order.toJson());
        Order currOrder = Order.fromJsonNew(order.toJson());
        currOrder.addFirstFood(foodItem);

        tableOrder.addFirstOrder(currOrder);
//        print(tableOrder.orders[0].foodList[0].name);
        pushingTo.add(tableOrder);
      } else {
        pushingTo.forEach((tableOrder) {
          if (table_order.oId == tableOrder.oId) {
            foundTable = true;
            tableOrder.orders.forEach((currOrder) {
              if (order.oId == currOrder.oId) {
                foundOrder = true;
                currOrder.addFood(foodItem);
              }
            });
            if (!foundOrder) {
              Order currOrder = Order.fromJsonNew(order.toJson());
              currOrder.addFirstFood(foodItem);

              tableOrder.addOrder(currOrder);
            }
          }
        });
        if (!foundTable) {
          TableOrder tableOrder = TableOrder.fromJsonNew(table_order.toJson());
          Order currOrder = Order.fromJsonNew(order.toJson());
          currOrder.addFirstFood(foodItem);

          tableOrder.addFirstOrder(currOrder);
//          print(tableOrder.orders[0].foodList[0].name);
          pushingTo.add(tableOrder);
        }
      }
    });
  }

//////////////////////////Assistance//////////////////////////
  newAssistanceRequests(data) {
    setState(() {
      if (data is Map) {
        data = json.encode(data);
      }
      print("new assistanceReq");
      var decoded = jsonDecode(data);
      print(decoded);
      print(decoded['status']);
      if (decoded['status'] == "accepted") {
        acceptedAssistanceReq(decoded);
      } else if (decoded['status'] == "pending") {
        if (restaurant.assistanceRequests == null) {
          restaurant.assistanceRequests = new List<AssistanceRequest>();
        }
        AssistanceRequest assist = AssistanceRequest.fromJson(decoded);

        restaurant.assistanceRequests.add(assist);
      }
    });
  }

  acceptedAssistanceReq(decoded) {
    setState(() {
      restaurant.assistanceRequests.forEach((request) {
        if (request.assistanceReqId == decoded['assistance_req_id']) {
          request.acceptedBy = {
            "staff_name": decoded['accepted_by']['staff_name'],
            "staff_id": decoded['accepted_by']['staff_id']
          };
        }
      });
    });
  }

  printOrders() {
//    print("completed");
//    completedOrders.forEach((completed) {
//      print(completed.tableId);
//    });
    print("cooking");
    cookingOrders.forEach((cooking) {
      print(cooking.tableId);
    });
  }

  @override
  Widget build(BuildContext context) {
    print("hereeeeww");
//    printOrders();
//    print(restaurant.assistanceRequests);
//    print(restaurant.tables[1].staff[0].name);
//      5eccc49668b1b9d33f7108ac
    return TabContainerBottom(
      sockets: sockets,
      restaurant: restaurant,
      registeredUser: registeredUser,
      queueOrders: queueOrders,
      cookingOrders: cookingOrders,
      completedOrders: completedOrders,
//      assistanceReq: assistanceReq,
    );
  }
}

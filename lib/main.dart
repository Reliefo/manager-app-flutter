import 'dart:convert';

import 'package:adhara_socket_io/adhara_socket_io.dart';
import 'package:adhara_socket_io/options.dart';
import 'package:adhara_socket_io_example/tabs.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import 'Drawer/drawermenu.dart';
import 'data.dart';
import 'session.dart';

void main() => runApp(MyApp());

//const String URI = "http://192.168.0.9:5050/";

const String URI =
    "http://ec2-13-232-202-63.ap-south-1.compute.amazonaws.com:5050/";

class MyApp extends StatefulWidget {
  @override
  _MyAppState createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  List<String> toPrint = [];

  List<Map<String, String>> temporaryStaffNames = [];
  List<Map<String, String>> temporaryTables = [];

  List<TableOrder> queueOrders = [];
  List<TableOrder> cookingOrders = [];
  List<TableOrder> completedOrders = [];
  List<AssistanceRequest> assistanceReq = [];
  Restaurant restaurant = Restaurant();
  SocketIOManager manager;
  Map<String, SocketIO> sockets = {};
  Map<String, bool> _isProbablyConnected = {};
  var headersi;
  Session loginSession;

  @override
  void initState() {
    manager = SocketIOManager();
//    initSocket("web_socket");
    loginSession = new Session();
//    initSocket(URI);

    login();
//    initSocket('default');

    super.initState();
  }

//  var connectingURI = "http://192.168.0.9:5050/login";
  var connectingURI =
      "http://ec2-13-232-202-63.ap-south-1.compute.amazonaws.com:5050/login";
  login() async {
    var output = await loginSession
        .post(connectingURI, {"username": "MID001", "password": "password123"});
    print("I am loggin in ");
    initSocket(URI);
    print(output);
//    headersi = response.headers['set-cookie'];
//    print(headersi['set-cookie']);
//    var resp = jsonDecode(response.body);
//    print(resp);
  }

  getRest() async {
    var output = await loginSession.get("http://192.168.0.9:5050/rest");
    print(output);
  }

  initSocket(uri) async {
    print('hey');
    print(loginSession.jwt);
    print(sockets.length);
    var identifier = 'working';
    SocketIO socket = await manager.createInstance(SocketOptions(
        //Socket IO server URI
        uri,
        nameSpace: "/reliefo",
        //Query params - can be used for authentication
        query: {
          "jwt": loginSession.jwt,
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
      socket.emit("fetch_handshake", ["Hello world!"]);
      socket.emit("rest_with_id", ["BNGHSR0001"]);
      socket.emit("fetch_order_lists", ["arguments"]);
      socket.emit("fetch_me", [" sending........."]);
    });
    socket.onConnectError(pprint);
    socket.onConnectTimeout(pprint);
    socket.onError(pprint);
    socket.onDisconnect((data) {
      print('object disconnnecgts');
//      disconnect('working');
    });
    socket.on("fetch", (data) => pprint(data));
    socket.on("hand_shake", (data) => shakeHands(data));
    socket.on("restaurant_object", (data) => updateRestaurant(data));
    socket.on("order_lists", (data) => fetchInitialLists(data));
    socket.on("updating_config", (data) => configuringRestaurant(data));
    socket.on("new_orders", (data) => fetchNewOrders(data));
    socket.on("assist", (data) => fetchAssistRequests(data));
    socket.on("assist_updates", (data) => fetchAccepted(data));
    socket.on("order_updates", (data) => fetchOrderUpdates(data));
//    socket.on("user_scan", (data) => fetchScanUpdates(data));

    socket.connect();
    sockets[identifier] = socket;
  }

  shakeHands(data) {
    print("HEREREHRAFNDOKSVOD");
    if (data is Map) {
      data = json.encode(data);
    }

    sockets['working'].emit('hand_shook', ["arg"]);
  }

  bool isProbablyConnected(String identifier) {
    return _isProbablyConnected[identifier] ?? false;
  }

  disconnect(String identifier) async {
    await manager.clearInstance(sockets[identifier]);
    setState(() => _isProbablyConnected[identifier] = false);
  }

  pprint(data) {
    setState(() {
      if (data is Map) {
        data = json.encode(data);
      }
      print(data);
      toPrint.add(data);
    });
  }

  sendMessage(identifier) {
    if (sockets[identifier] != null) {
      print("sending message from '$identifier'...");
      sockets[identifier].emit("fetchme", [
        {'data': "ples recevie data HSIDFODSNVOSDNVODSNO"}
      ]);
      print("Message emitted from '$identifier'...");
    }
  }

  updateRestaurant(data) {
    setState(() {
      if (data is Map) {
        data = json.encode(data);
      }

      var decoded = jsonDecode(data);

      restaurant = Restaurant.fromJson(decoded);
    });
  }

  fetchInitialLists(data) {
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

  fetchNewOrders(data) {
    setState(() {
      if (data is Map) {
        data = json.encode(data);
      }
      int queue = 0;
      var decoded = jsonDecode(data);

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

  fetchOrderUpdates(data) {
    setState(() {
      if (data is Map) {
        data = json.encode(data);
      }
      var decoded = jsonDecode(data);

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

  fetchAssistRequests(data) {
    setState(() {
      if (data is Map) {
        data = json.encode(data);
      }

      AssistanceRequest assist = AssistanceRequest.fromJson(jsonDecode(data));
      assistanceReq.add(assist);
    });
  }

  fetchAccepted(data) {
    setState(() {
      if (data is Map) {
        data = json.encode(data);
      }
      print(jsonDecode(data));
      assistanceReq.forEach((request) {
        if (request.oId == jsonDecode(data)['assistance_id']) {
          request.acceptedBy = jsonDecode(data)['staff_name'];
        }
      });
    });
  }

  updateConfigDetailsToCloud(localData, String type) {
    print(type);
    print(localData);
    var encode;
    String restaurantId = restaurant.restaurantId;
////////////////////////////////    table      ///////////////////
    if (type == "add_tables") {
      encode = jsonEncode(
          {"restaurant_id": restaurantId, "type": type, "tables": localData});
    }

    if (type == "delete_tables") {
      encode = jsonEncode(
          {"restaurant_id": restaurantId, "type": type, "table_id": localData});
    }

    if (type == "add_staff") {
      encode = jsonEncode(
          {"restaurant_id": restaurantId, "type": type, "staff": localData});
    }

    if (type == "delete_staff") {
      encode = jsonEncode(
          {"restaurant_id": restaurantId, "type": type, "staff_id": localData});
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

      //todo:
    }
////////////////////////////////////////   menu         /////////////////////
    if (type == "add_food_category") {
      encode = jsonEncode(
          {"restaurant_id": restaurantId, "type": type, "category": localData});
    }

    if (type == "delete_food_category") {
      encode = jsonEncode({
        "restaurant_id": restaurantId,
        "type": type,
        "category_id": localData
      });
      //todo:
    }

    if (type == "add_bar_category") {
      encode = jsonEncode(
          {"restaurant_id": restaurantId, "type": type, "category": localData});
      //todo:
    }

    if (type == "delete_bar_category") {
      encode = jsonEncode({
        "restaurant_id": restaurantId,
        "type": type,
        "category_id": localData
      });
      //todo:
    }

    if (type == "add_food_item") {
      encode = jsonEncode({
        "restaurant_id": restaurantId,
        "type": type,
        "category_type": localData["category_type"],
        "category_id": localData['category_id'],
        "food_dict": localData['food_dict'],
      });
    }

    if (type == "delete_food_item") {
      encode = jsonEncode({
        "restaurant_id": restaurantId,
        "type": type,
        "category_type": localData["category_type"],
        "food_id": localData["food_id"],
      });
    }

    print("before sending to cloud");

    print(encode);

    sockets['working'].emit('configuring_restaurant', [encode]);
    print('uploded to cloud');
  }

  configuringRestaurant(data) {
    //todo: refactor
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

      if (decode["type"] == "delete_tables") {
        restaurant.tables
            .removeWhere((table) => table.oid == decode["table_id"]);
      }

      if (decode["type"] == "add_staff") {
        restaurant.addStaffDetails(decode['staff']);
      }

      if (decode["type"] == "delete_staff") {
        restaurant.staff
            .removeWhere((staff) => staff.oid == decode["staff_id"]);
      }
////////////////////////////////////////   menu         /////////////////////
      if (decode["type"] == "add_food_category") {
        restaurant.addFoodMenuCategory(decode["category"]);
      }
      if (decode["type"] == "delete_food_category") {
        restaurant.foodMenu
            .removeWhere((category) => category.oid == decode["category_id"]);
      }
      if (decode["type"] == "add_bar_category") {
        restaurant.addBarMenuCategory(decode["category"]);
      }
      if (decode["type"] == "delete_bar_category") {
        restaurant.barMenu
            .removeWhere((category) => category.oid == decode["category_id"]);
      }

      print(decode);
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
    });
  }

  @override
  Widget build(BuildContext context) {
//    print(restaurant.tables[1].noOfUsers);
//    print(queueOrders[0].oId);
//    print(restaurant.tables[7].);

    SystemChrome.setPreferredOrientations([
      DeviceOrientation.landscapeLeft,
      DeviceOrientation.landscapeRight,
    ]);
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: Scaffold(
//        appBar: AppBar(
//          title: Text('Squirky'),
//          backgroundColor: Colors.black,
//          elevation: 0.0,
//        ),
//        body: HomePage(
//          list: toPrint,
//          queueOrders: queueOrders,
//          getButtonSet: getButtonSet("default"),
        drawer: Drawer(
          child: DrawerMenu(
            restaurant: restaurant,
            updateConfigDetailsToCloud: updateConfigDetailsToCloud,
            login: login,
            getRest: getRest,
          ),
        ),

        body: TabContainerBottom(
          restaurant: restaurant,
          queueOrders: queueOrders,
          cookingOrders: cookingOrders,
          completedOrders: completedOrders,
          assistanceReq: assistanceReq,
        ),
      ),
    );
  }
}

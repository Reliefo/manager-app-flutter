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

const String URI = "http://192.168.0.9:5050/";

//const String URI =
//    "http://ec2-13-233-196-75.ap-south-1.compute.amazonaws.com:5050/";

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
    super.initState();
    manager = SocketIOManager();
//    initSocket("web_socket");
    loginSession = new Session();
//    initSocket(URI);
    print("session");
    login();
//    initSocket('default');
  }

  login() async {
    var output = await loginSession.post("http://192.168.0.9:5050/login",
        {"username": "akshay_23", "password": "password123"});
    print("I am loggin in ");
    initSocket(URI);
    print(output);
//    headersi = response.headers['set-cookie'];
//    print(headersi['set-cookie']);
//    var resp = jsonDecode(response.body);
//    print(resp);
  }

  get_rest() async {
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
        nameSpace: "/adhara",
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
      socket.emit("fetchme", ["Hello world!"]);
      socket.emit("rest_with_id", ["BNGHSR0002"]);
      socket.emit("fetch_order_lists", ["arguments"]);
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

  sendMessage(identifier) {
    if (sockets[identifier] != null) {
      print("sending message from '$identifier'...");
      sockets[identifier].emit("fetchme", [
        {'data': "ples recevie data HSIDFODSNVOSDNVODSNO"}
      ]);
      print("Message emitted from '$identifier'...");
    }
  }

  fetchInitialLists(data) {
    setState(() {
      if (data is Map) {
        data = json.encode(data);
      }

      var decoded = jsonDecode(data);

      queueOrders.clear();
      cookingOrders.clear();
      completedOrders.clear();

      decoded["queue"].forEach((item) {
        TableOrder order = TableOrder.fromJson(item);

        queueOrders.add(order);
      });
      decoded["cooking"].forEach((item) {
        TableOrder order = TableOrder.fromJson(item);

        cookingOrders.add(order);
      });
      decoded["completed"].forEach((item) {
        TableOrder order = TableOrder.fromJson(item);

        completedOrders.add(order);
      });
    });
  }

  updateMenuToCloud(localData, String type) {
    print('before sending food to cloud');

    var encode;

    if (type == "add_food_menu") {
      encode = jsonEncode(
          {"restaurant_id": "BNGHSR0002", "type": type, "category": localData});
    }

    if (type == "add_bar_menu") {
      encode = jsonEncode(
          {"restaurant_id": "BNGHSR0002", "type": type, "category": localData});
    }

    if (type == "add_food_item") {
      localData.forEach((v) {
        encode = jsonEncode({
          "restaurant_id": "BNGHSR0002",
          "type": type,
          "category_id": v['category_id'],
          "food_dict": v['food_dict'],
        });
      });
    }

    print(encode);
    sockets['working'].emit('configuring_restaurant', [encode]);
  }

  updateTableDetailsToCloud(localData, String type) {
    print(type);
    var encode;

    if (type == "add_tables") {
      encode = jsonEncode(
          {"restaurant_id": "BNGHSR0002", "type": type, "tables": localData});
    }

    if (type == "delete_table") {
      encode = jsonEncode(
          {"restaurant_id": "BNGHSR0002", "type": type, "table_id": localData});
    }

    if (type == "add_staff") {
      encode = jsonEncode(
          {"restaurant_id": "BNGHSR0002", "type": type, "staff": localData});
    }

    if (type == "delete_staff") {
      encode = jsonEncode(
          {"restaurant_id": "BNGHSR0002", "type": type, "staff_id": localData});
    }

    if (type == "assign_staff") {
      encode = jsonEncode({
        "restaurant_id": "BNGHSR0002",
        "type": type,
        "table_id": localData["table_id"],
        "assigned_staff": localData["assigned_staff"]
      });
    }

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

      if (decode["type"] == "add_tables") {
        restaurant.addTableDetails(decode['tables']);
      }

      if (decode["type"] == "delete_table") {
        restaurant.tables
            .removeWhere((table) => table.oid == decode["table_id"]);
      }
      if (decode["type"] == "delete_staff") {
        restaurant.staff
            .removeWhere((staff) => staff.oid == decode["staff_id"]);
      }

      if (decode["type"] == "add_staff") {
        restaurant.addStaffDetails(decode['staff']);
      }
      if (decode["type"] == "add_food_menu") {
        print("food menu");
        restaurant.addFoodMenuCategory(decode["category"]);
      }
      if (decode["type"] == "add_bar_menu") {
        restaurant.addBarMenuCategory(decode["category"]);
      }

      if (decode["type"] == "add_food_item") {
        restaurant.foodMenu.forEach((category) {
          if (category.oid == decode["category_id"]) {
            print("${category.name} matched");
            category.addFoodItem(decode["food_dict"]);
          }
        });
      }

      if (decode["type"] == "assign_staff") {
        restaurant.tables.forEach((table) {
          if (table.oid == decode["table_id"]) {
            print('table matched: ${table.name}');

            table.addTableStaff(decode['assigned_staff']);
            //todo: change only id to full staff object from backend
          }
        });
      }
//      reply for assigned staff      {restaurant_id: BNGHSR0002, type: assign_staff,
//       table_id: 5e90b5184584a1d3d9e641db, assigned_staff: [5e90bc2f4584a1d3d9e641de, 5e90b5294584a1d3d9e641dc]}

//  reply for adding food    {restaurant_id: BNGHSR0002, type: add_food_item, category_id: 5e94959afe4ce65500586c26,
//      food_dict: {name: new food, description: tyukk, price: 45p, food_options: {options: {},
//      choices: []}, food_id: 5e949ed8fe4ce65500586c29}}
    });
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

  updateRestaurant(data) {
    setState(() {
      if (data is Map) {
        data = json.encode(data);
      }

      var decoded = jsonDecode(data);

      restaurant = Restaurant.fromJson(decoded);
    });
  }

  fetchNewOrders(data) {
    setState(() {
      if (data is Map) {
        data = json.encode(data);
      }

      TableOrder order = TableOrder.fromJson(jsonDecode(data));

      queueOrders.add(order);
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

      assistanceReq.forEach((request) {
        if (request.oId == jsonDecode(data)['assistance_id']) {
          request.acceptedBy = jsonDecode(data)['staff_name'];
        }
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
//      print('printing from here');
//      print(decoded);
//      print(selectedOrder[0].table);

      selectedOrder.forEach((tableorder) {
//        print(tableorder.oId);
        if (tableorder.oId == decoded['table_order_id']) {
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

  pushTo(table_order, order, food_item, type) {
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
        currOrder.addFirstFood(food_item);

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
                currOrder.addFood(food_item);
              }
            });
            if (!foundOrder) {
              Order currOrder = Order.fromJsonNew(order.toJson());
              currOrder.addFirstFood(food_item);

              tableOrder.addOrder(currOrder);
            }
          }
        });
        if (!foundTable) {
          TableOrder tableOrder = TableOrder.fromJsonNew(table_order.toJson());
          Order currOrder = Order.fromJsonNew(order.toJson());
          currOrder.addFirstFood(food_item);

          tableOrder.addFirstOrder(currOrder);
//          print(tableOrder.orders[0].foodList[0].name);
          pushingTo.add(tableOrder);
        }
      }
    });
  }

  @override
  Widget build(BuildContext context) {
//    print(restaurant.foodMenu[19].foodList[0].name);
    // Set landscape orientation
    SystemChrome.setPreferredOrientations([
      DeviceOrientation.landscapeLeft,
      DeviceOrientation.landscapeRight,
    ]);
    return MaterialApp(
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
            updateTableDetailsToCloud: updateTableDetailsToCloud,
            updateMenuToCloud: updateMenuToCloud,
            login: login,
            get_rest: get_rest,
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

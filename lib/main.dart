import 'dart:convert';

import 'package:adhara_socket_io/adhara_socket_io.dart';
import 'package:adhara_socket_io/options.dart';
import 'package:adhara_socket_io_example/tabs.dart';
import 'package:flutter/material.dart';

import 'Drawer/drawermenu.dart';
import 'data.dart';

void main() => runApp(MyApp());

const String URI = "http://192.168.0.9:5050/";

class MyApp extends StatefulWidget {
  @override
  _MyAppState createState() => _MyAppState();
// Figure out what _MyAppState is
// what's the use of createState() and that => _MyAppState
// What is toPrint, how is it printing
// STATELESS VS STATEFULL

}

class _MyAppState extends State<MyApp> {
  List<String> toPrint = [];
  int tableCount = 20;

  List<TableDetails> tableDetailsList = [];
  List<String> staffNameList = [];

  List<TableOrder> queueOrders = [];
  List<TableOrder> cookingOrders = [];
  List<TableOrder> completedOrders = [];
  List<AssistanceRequest> assistanceReq = [];
  Restaurant restaurant = Restaurant();
//  Map<Map<>>
  SocketIOManager manager;
  Map<String, SocketIO> sockets = {};
  Map<String, bool> _isProbablyConnected = {};

  @override
  void initState() {
    super.initState();
    manager = SocketIOManager();
//    initSocket("web_socket");
    initSocket(URI);
//    initSocket('default');
  }

  initSocket(uri) async {
    print('hey');
    print(sockets.length);
    var identifier = 'working';
    SocketIO socket = await manager.createInstance(SocketOptions(
        //Socket IO server URI
        uri,
        nameSpace: "/adhara",
        //Query params - can be used for authentication
        query: {
          "info": "new connection from adhara-socketio",
          "timestamp": DateTime.now().toString()
        },
        //Enable or disable platform channel logging
        enableLogging: false,
        transports: [
          Transports.WEB_SOCKET /*, Transports.POLLING*/
        ] //Enable required transport

        ));
    socket.onConnect((data) {
      pprint({"Status": "connected..."});
//      pprint(data);
//      sendMessage("DEFAULT");
      socket.emit("fetchme", ["Hello world!"]);
    });
    socket.onConnectError(pprint);
    socket.onConnectTimeout(pprint);
    socket.onError(pprint);
    socket.onDisconnect((data) {
      print('object disconnnecgts');
      disconnect('working');
    });
    socket.on("fetch", (data) => pprint(data));
    socket.on("restaurant_object", (data) => updateRestaurant(data));
    socket.on("new_orders", (data) => fetchNewOrders(data));
    socket.on("assist", (data) => fetchAssistRequests(data));
    socket.on("assist_updates", (data) => fetchAccepted(data));
    socket.on("order_updates", (data) => fetchOrderUpdates(data));
//    socket.on("user_scan", (data) => fetchScanUpdates(data));

    socket.connect();
    sockets[identifier] = socket;
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

  updateTableDetails(String tableName, String seats) {
    setState(() {
      if (tableName != null) {
        TableDetails details = TableDetails.fromStrings(tableName, seats);
        tableDetailsList.add(details);
      }
    });
  }

  updateStaffDetails(String name) {
    setState(() {
      if (name != null) {
        staffNameList.add(name);
      }
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
      print("from restaurant");
      restaurant = Restaurant.fromJson(jsonDecode(data));
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
          request.acceptedBy = jsonDecode(data)['server_name'];
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

      selectedOrder.forEach((tableorder) {
        if (tableorder.oId == decoded['tableorder_id']['\$oid']) {
          tableorder.orders.forEach((order) {
            if (order.oId == decoded['order_id']['\$oid']) {
              order.foodlist.forEach((fooditem) {
                if (fooditem.foodId == decoded['food_id']) {
//                  print('all completed id  matched${decoded['food_id']}');
                  fooditem.status = decoded['type'];
                  // push to cooking and completed orders
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
        print(tableOrder.orders[0].foodlist[0].name);
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
          print(tableOrder.orders[0].foodlist[0].name);
          pushingTo.add(tableOrder);
        }
      }
    });
  }

  @override
  Widget build(BuildContext context) {
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
            updateTableDetails: updateTableDetails,
            updateStaffDetails: updateStaffDetails,
            tableDetailsList: tableDetailsList,
            staffNameList: staffNameList,
          ),
        ),

        body: TabContainerBottom(
          queueOrders: queueOrders,
          cookingOrders: cookingOrders,
          completedOrders: completedOrders,
          assistanceReq: assistanceReq,
          tableCount: tableCount,
//
        ),
      ),
    );
  }
}

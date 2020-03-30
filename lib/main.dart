import 'dart:convert';

import 'package:adhara_socket_io/adhara_socket_io.dart';
import 'package:adhara_socket_io/options.dart';
import 'package:adhara_socket_io_example/tabs.dart';
import 'package:flutter/material.dart';

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
  List<TableOrder> queueOrders = [];
  List<AssistanceRequest> assistanceReq = [];
  List<TableOrder> cookingOrders = [];
//  Map<Map<>>
  SocketIOManager manager;
  Map<String, SocketIO> sockets = {};
  Map<String, bool> _isProbablyConnected = {};

  @override
  void initState() {
    super.initState();
    manager = SocketIOManager();
//    initSocket("web_socket");
    minitSocket(URI);
//    initSocket('default');
  }

  minitSocket(uri) async {
    print('hey');
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
    socket.on("new_orders", (data) => fetchNewOrders(data));
    socket.on("assist", (data) => fetchAssistRequests(data));
    socket.on("assist_updates", (data) => fetchAccepted(data));
    socket.on("order_updates", (data) => fetchOrderUpdates(data));

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

  pprint(data) {
    setState(() {
      if (data is Map) {
        data = json.encode(data);
      }
      print(data);
      toPrint.add(data);
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

      for (var i = 0; i < assistanceReq.length; ++i) {
        if (assistanceReq[i].oId == jsonDecode(data)['assistance_id']) {
          assistanceReq[i].acceptedBy = jsonDecode(data)['server_name'];
        }
      }
    });
  }

  fetchOrderUpdates(data) {
    setState(() {
      if (data is Map) {
        data = json.encode(data);
      }
      var decoded = jsonDecode(data);
      queueOrders.forEach((tableorder) {
        if (tableorder.oId == decoded['tableorder_id']['\$oid']) {
          tableorder.orders.forEach((order) {
            if (order.oId == decoded['order_id']['\$oid']) {
              order.foodlist.forEach((fooditem) {
                if (fooditem.foodId == decoded['food_id']) {
                  print('all id  matched');
                  fooditem.status = decoded['type'];
                  pushToCooking(tableorder, order, fooditem);
                  order.removeFoodItem(decoded['food_id']);
                }
              });
            }
          });
        }
      });
    });
  }

  pushToCooking(table_order, order, food_item) {
    setState(() {
      if (cookingOrders.length == 0) {
        TableOrder tableOrder = TableOrder.fromJsonNew(table_order.toJson());
        Order currOrder = Order.fromJsonNew(order.toJson());
        currOrder.addFirstFood(food_item);

        tableOrder.addFirstOrder(currOrder);
        print(tableOrder.orders[0].foodlist[0].name);
        cookingOrders.add(tableOrder);
      } else {
        cookingOrders.forEach((tableOrder) {
          if (table_order.oId == tableOrder.oId) {
            tableOrder.orders.forEach((currOrder) {
              if (order.oId == currOrder.oId) {
                currOrder.addFood(food_item);
              }
            });
          }
        });
      }
    });
  }

  @override
  Widget build(BuildContext context) {
//    print('cooking orders');
//    print(cookingOrders);
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
//        ),
        body: TabContainerBottom(
          list: toPrint,
          assistanceReq: assistanceReq,
          queueOrders: queueOrders,
          cookingOrders: cookingOrders,
//          getButtonSet: getButtonSet("default"),
        ),
      ),
    );
  }
}

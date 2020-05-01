import 'dart:convert';

import 'package:adhara_socket_io/adhara_socket_io.dart';
import 'package:adhara_socket_io_example/fetchData/configureRestaurantData.dart';
import 'package:adhara_socket_io_example/fetchData/fetchAssistanceData.dart';
import 'package:adhara_socket_io_example/fetchData/fetchOrderData.dart';

import 'session.dart';

class SocketConnection {
  ConfigureRestaurantData configureRestaurantData = ConfigureRestaurantData();
  FetchOrderData fetchOrderData = FetchOrderData();
  FetchAssistanceData fetchAssistanceData = FetchAssistanceData();
  SocketIOManager manager = SocketIOManager();
  Map<String, SocketIO> sockets = {};
  Map<String, bool> _isProbablyConnected = {};

  initSocket(String uri, Session loginSession) async {
    print('hey from new init file');
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
    socket.on("restaurant_object",
        (data) => configureRestaurantData.fetchRestaurant(data));

    socket.on("updating_config",
        (data) => configureRestaurantData.getConfiguredDataFromBackend(data));
    socket.on("order_lists", (data) => fetchOrderData.initialOrderLists(data));

    socket.on("new_orders", (data) => fetchOrderData.newOrders(data));
    socket.on("order_updates", (data) => fetchOrderData.orderUpdates(data));

    socket.on("assist", (data) => fetchAssistanceData.newRequests(data));
    socket.on("assist_updates", (data) => fetchAssistanceData.accepted(data));

//    socket.on("user_scan", (data) => fetchScanUpdates(data));

    socket.connect();
    sockets[identifier] = socket;
    ConfigureRestaurantData(sockets: sockets);
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
    print(data);
  }

  shakeHands(data) {
    print("HEREREHRAFNDOKSVOD");
    if (data is Map) {
      data = json.encode(data);
    }

    sockets['working'].emit('hand_shook', ["arg"]);
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
}

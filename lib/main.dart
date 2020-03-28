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
    socket.onDisconnect(pprint);
    socket.on("fetch", (data) => pprint(data));
    socket.on("new_orders", (data) => fetchNewOrders(data));
    socket.on("assist", (data) => fetchAssistRequests(data));
    socket.on("accepted_by", (data) => fetchAccepted(data));

    socket.connect();
    sockets[identifier] = socket;
  }

  initSocket(String identifier) async {
    SocketIO socket = await manager.createInstance(SocketOptions(
        //Socket IO server URI
        URI,
        nameSpace: (identifier == "namespaced") ? "/adhara" : "/",
        //Query params - can be used for authentication
        query: {
          "auth": "--SOME AUTH STRING---",
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
      pprint("connected...");
      pprint(data);
//      sendMessage(identifier);
    });
    socket.onConnectError(pprint);
    socket.onConnectTimeout(pprint);
    socket.onError(pprint);
    socket.onDisconnect(pprint);
    socket.on("type:string", (data) => pprint("type:string | $data"));
    socket.on("type:bool", (data) => pprint("type:bool | $data"));
    socket.on("type:number", (data) => pprint("type:number | $data"));
    socket.on("type:object", (data) => pprint("type:object | $data"));
    socket.on("type:list", (data) => pprint("type:list | $data"));
    socket.on("response", (data) => pprint(data));
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

//      var decoded = jsonDecode(data);

//      print(decoded['table'].substring(5));

      TableOrder order = TableOrder.fromJson(jsonDecode(data));
//      print(jsonDecode(jsonDecode(data)['new_order']));

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

      AssistanceRequest assist = AssistanceRequest.fromJson(jsonDecode(data));
      assistanceReq.add(assist);
    });
  }

  Container getButtonSet(String identifier) {
    bool ipc = isProbablyConnected(identifier);
    return Container(
      height: 60.0,
      child: ListView(
        scrollDirection: Axis.horizontal,
        children: <Widget>[
          Container(
            margin: EdgeInsets.symmetric(horizontal: 8.0),
            child: RaisedButton(
              child: Text("Connect"),
              onPressed: ipc ? null : () => sendMessage('working'),
              padding: EdgeInsets.symmetric(horizontal: 8.0),
            ),
          ),
        ],
      ),
    );
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
//        ),
        body: TabContainerBottom(
          list: toPrint,
          assistanceReq: assistanceReq,
          queueOrders: queueOrders,
          getButtonSet: getButtonSet("default"),
        ),
      ),
    );
  }
}

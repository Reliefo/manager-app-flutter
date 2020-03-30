//initSocket(String identifier) async {
//  SocketIO socket = await manager.createInstance(SocketOptions(
//    //Socket IO server URI
//      URI,
//      nameSpace: (identifier == "namespaced") ? "/adhara" : "/",
//      //Query params - can be used for authentication
//      query: {
//        "auth": "--SOME AUTH STRING---",
//        "info": "new connection from adhara-socketio",
//        "timestamp": DateTime.now().toString()
//      },
//      //Enable or disable platform channel logging
//      enableLogging: false,
//      transports: [
//        Transports.WEB_SOCKET /*, Transports.POLLING*/
//      ] //Enable required transport
//  ));
//  socket.onConnect((data) {
//    pprint("connected...");
//    pprint(data);
////      sendMessage(identifier);
//  });
//  socket.onConnectError(pprint);
//  socket.onConnectTimeout(pprint);
//  socket.onError(pprint);
//  socket.onDisconnect(pprint);
//  socket.on("type:string", (data) => pprint("type:string | $data"));
//  socket.on("type:bool", (data) => pprint("type:bool | $data"));
//  socket.on("type:number", (data) => pprint("type:number | $data"));
//  socket.on("type:object", (data) => pprint("type:object | $data"));
//  socket.on("type:list", (data) => pprint("type:list | $data"));
//  socket.on("response", (data) => pprint(data));
//  socket.connect();
//  sockets[identifier] = socket;
//}

//Container getButtonSet(String identifier) {
//  bool ipc = isProbablyConnected(identifier);
//  return Container(
//    height: 60.0,
//    child: ListView(
//      scrollDirection: Axis.horizontal,
//      children: <Widget>[
//        Container(
//          margin: EdgeInsets.symmetric(horizontal: 8.0),
//          child: RaisedButton(
//            child: Text("Connect"),
//            onPressed: ipc ? null : () => sendMessage('working'),
//            padding: EdgeInsets.symmetric(horizontal: 8.0),
//          ),
//        ),
//      ],
//    ),
//  );
//}

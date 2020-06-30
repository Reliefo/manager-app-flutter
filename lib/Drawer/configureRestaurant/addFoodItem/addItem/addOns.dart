//import 'package:flutter/material.dart';
//
//class AddOns extends StatefulWidget {
//  final addOnsController;
//  final addOnsPriceController;
//  final List<Map<String, dynamic>> addOns;
//  final FocusNode addOnsFocus;
//
//  AddOns({
//    @required this.addOns,
//    @required this.addOnsController,
//    @required this.addOnsPriceController,
//    @required this.addOnsFocus,
//  });
//
//  @override
//  _AddOnsState createState() => _AddOnsState();
//}
//
//class _AddOnsState extends State<AddOns> {
//  @override
//  Widget build(BuildContext context) {
//    return Column(
//      children: <Widget>[
//        Row(children: <Widget>[
//          Expanded(
//            flex: 2,
//            child: Container(
//              padding: EdgeInsets.all(12),
//              child: TextFormField(
//                controller: widget.addOnsController,
//                focusNode: widget.addOnsFocus,
//                decoration: InputDecoration(
//                  labelText: "add-ons",
//                  fillColor: Colors.white,
//                  border: OutlineInputBorder(
//                    borderRadius: BorderRadius.circular(12.0),
//                  ),
//                ),
//                keyboardType: TextInputType.text,
//                validator: (value) {
//                  if (value.isEmpty) {
//                    return 'Please enter add-on';
//                  }
//                  return null;
//                },
//              ),
//            ),
//          ),
//          Expanded(
//            flex: 2,
//            child: Container(
//              padding: EdgeInsets.all(12),
//              child: TextFormField(
//                controller: widget.addOnsPriceController,
//                decoration: InputDecoration(
//                  labelText: "price",
//                  fillColor: Colors.white,
//                  border: OutlineInputBorder(
//                    borderRadius: BorderRadius.circular(12.0),
//                  ),
//                  //fillColor: Colors.green
//                ),
//                keyboardType: TextInputType.text,
//                validator: (value) {
//                  if (value.isEmpty) {
//                    return 'Please enter price';
//                  }
//                  return null;
//                },
//              ),
//            ),
//          ),
//          Expanded(
//            child: FlatButton(
//                child: Text('add add-on'),
//                onPressed: () {
//                  setState(() {
//                    widget.addOns.add({
//                      "add_on_name": widget.addOnsController.text,
//                      "add_on_price": widget.addOnsPriceController.text
//                    });
//                  });
//
//                  widget.addOnsController.clear();
//                  widget.addOnsPriceController.clear();
//                }),
//          )
//        ]),
//        Container(
//          child: ListView.builder(
//            shrinkWrap: true,
//            primary: false,
//            itemCount: widget.addOns.length,
//            itemBuilder: (context, index) {
//              return ListTile(
//                title: Text(widget.addOns[index]["add_on_name"]),
//                subtitle:
//                    Text("Price : ${widget.addOns[index]["add_on_price"]}"),
//                trailing: IconButton(
//                  icon: Icon(
//                    Icons.cancel,
//                  ),
//                  onPressed: () {
//                    setState(() {
//                      widget.addOns.removeAt(index);
//                    });
//                  },
//                ),
//              );
//            },
//          ),
//        )
//      ],
//    );
//  }
//}

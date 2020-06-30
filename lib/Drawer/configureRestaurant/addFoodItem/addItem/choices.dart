//import 'package:flutter/material.dart';
//
//class Choices extends StatefulWidget {
//  final foodChoiceController;
//  final priceController;
//  final FocusNode foodChoiceFocus;
//  final List<String> choices;
//  Choices({
//    @required this.foodChoiceController,
//    @required this.priceController,
//    this.foodChoiceFocus,
//    @required this.choices,
//  });
//
//  @override
//  _ChoicesState createState() => _ChoicesState();
//}
//
//class _ChoicesState extends State<Choices> {
//  @override
//  Widget build(BuildContext context) {
//    return Column(
//      mainAxisSize: MainAxisSize.min,
//      mainAxisAlignment: MainAxisAlignment.start,
//      children: <Widget>[
//        Row(
//          mainAxisAlignment: MainAxisAlignment.spaceBetween,
//          children: <Widget>[
//            Expanded(
//              child: Container(
//                padding: EdgeInsets.all(12),
//                child: TextFormField(
//                  controller: widget.foodChoiceController,
//                  focusNode: widget.foodChoiceFocus,
//                  decoration: InputDecoration(
//                    labelText: "choice",
//                    fillColor: Colors.white,
//                    border: OutlineInputBorder(
//                      borderRadius: BorderRadius.circular(12.0),
//                    ),
//                    //fillColor: Colors.green
//                  ),
//                  keyboardType: TextInputType.text,
//                  validator: (value) {
//                    if (value.isEmpty) {
//                      return 'Please enter option';
//                    }
//                    return null;
//                  },
//                ),
//              ),
//            ),
//            FlatButton(
//              child: Text('add choice'),
//              onPressed: () {
//                setState(() {
//                  widget.choices.add(widget.foodChoiceController.text);
//                });
//                widget.foodChoiceController.clear();
//              },
//            ),
//          ],
//        ),
//        Container(
//          child: ListView.builder(
//            shrinkWrap: true,
//            primary: false,
//            itemCount: widget.choices.length,
//            itemBuilder: (context, index) {
//              return ListTile(
//                title: Text(widget.choices[index]),
//                trailing: IconButton(
//                  icon: Icon(
//                    Icons.cancel,
//                  ),
//                  onPressed: () {
//                    setState(() {
//                      widget.choices.removeAt(index);
//                    });
//                  },
//                ),
//              );
//            },
//          ),
//        ),
//      ],
//    );
//  }
//}

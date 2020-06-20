import 'package:flutter/material.dart';
import 'package:manager_app/constants.dart';

class Inventory extends StatefulWidget {
  @override
  _InventoryState createState() => _InventoryState();
}

class _InventoryState extends State<Inventory> {
  final itemNameController = TextEditingController();
  final FocusNode itemNameFocus = FocusNode();
  final FocusNode descriptionFocus = FocusNode();

  _fieldFocusChange(
      BuildContext context, FocusNode currentFocus, FocusNode nextFocus) {
    currentFocus.unfocus();
    FocusScope.of(context).requestFocus(nextFocus);
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
          title: Text("Inventory"),
          backgroundColor: kThemeColor,
        ),
        body: Container(
          child: Row(
            children: <Widget>[
              Column(
                children: <Widget>[
                  Expanded(
                    flex: 2,
                    child: Container(
                      padding: EdgeInsets.all(12),
                      child: TextFormField(
                        controller: itemNameController,
                        textInputAction: TextInputAction.next,
                        focusNode: itemNameFocus,
                        onFieldSubmitted: (term) {
                          _fieldFocusChange(
                              context, itemNameFocus, descriptionFocus);
                        },
                        decoration: InputDecoration(
                          labelText: "Item Name",
                          fillColor: Colors.white,
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(12.0),
                          ),
                        ),
                        keyboardType: TextInputType.text,
                        validator: (value) {
                          if (value.isEmpty) {
                            return 'Please enter item';
                          }
                          return null;
                        },
                      ),
                    ),
                  ),
                ],
              ),
              Column(
                children: <Widget>[],
              ),
            ],
          ),
        ),
      ),
    );
  }
}

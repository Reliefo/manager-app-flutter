import 'package:flutter/material.dart';
import 'package:manager_app/fetchData/configureRestaurantData.dart';
import 'package:provider/provider.dart';

class SetTaxes extends StatefulWidget {
  @override
  _SetTaxesState createState() => _SetTaxesState();
}

class _SetTaxesState extends State<SetTaxes> {
  Map<String, String> taxes = {};
  final serviceTaxController = TextEditingController();
  final sgstController = TextEditingController();
  final cgstController = TextEditingController();

  sendToBackend(restaurantData) {
    if (cgstController.text.isNotEmpty &&
        serviceTaxController.text.isNotEmpty &&
        sgstController.text.isNotEmpty) {
      restaurantData.sendConfiguredDataToBackend({
        "taxes": {
          "Service": double.parse(serviceTaxController.text),
          "SGST": double.parse(sgstController.text),
          "CGST": double.parse(cgstController.text),
        }
      }, "set_taxes");
    }
  }

  @override
  Widget build(BuildContext context) {
    final RestaurantData restaurantData = Provider.of<RestaurantData>(context);
    return SafeArea(
      child: Scaffold(
        body: Container(
          child: Column(
            children: <Widget>[
              Row(
                children: <Widget>[
                  Flexible(child: Text("Service Tax :")),
                  Expanded(
                    child: Container(
                      padding: EdgeInsets.all(12),
                      child: TextFormField(
                        controller: serviceTaxController,
                        onFieldSubmitted: (value) {
//                _addStaff();
                        },
                        decoration: InputDecoration(
                          labelText: "Service Tax",
                          fillColor: Colors.white,
//                errorText: _staffNameValidate
//                    ? 'Value Can\'t Be Empty'
//                    : null,
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(12.0),
                          ),
                        ),
                        keyboardType:
                            TextInputType.numberWithOptions(decimal: true),
                      ),
                    ),
                  ),
                ],
              ),
              Row(
                children: <Widget>[
                  Flexible(child: Text("SGST :")),
                  Expanded(
                    child: Container(
                      padding: EdgeInsets.all(12),
                      child: TextFormField(
                        controller: sgstController,
                        onFieldSubmitted: (value) {
//                _addStaff();
                        },
                        decoration: InputDecoration(
                          labelText: "SGST",
                          fillColor: Colors.white,
//                errorText: _staffNameValidate
//                    ? 'Value Can\'t Be Empty'
//                    : null,
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(12.0),
                          ),
                        ),
                        keyboardType:
                            TextInputType.numberWithOptions(decimal: true),
                      ),
                    ),
                  ),
                ],
              ),
              Row(
                children: <Widget>[
                  Flexible(child: Text("CGST :")),
                  Expanded(
                    child: Container(
                      padding: EdgeInsets.all(12),
                      child: TextFormField(
                        controller: cgstController,
                        onFieldSubmitted: (value) {
//                _addStaff();
                        },
                        decoration: InputDecoration(
                          labelText: "CGST",
                          fillColor: Colors.white,
//                errorText: _staffNameValidate
//                    ? 'Value Can\'t Be Empty'
//                    : null,
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(12.0),
                          ),
                        ),
                        keyboardType:
                            TextInputType.numberWithOptions(decimal: true),
                      ),
                    ),
                  ),
                ],
              ),
              RaisedButton(
                  child: Text("add"),
                  onPressed: () {
                    sendToBackend(restaurantData);
                  }),
            ],
          ),
        ),
      ),
    );
  }
}

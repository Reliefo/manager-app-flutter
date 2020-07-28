import 'package:flutter/material.dart';
import 'package:manager_app/constants.dart';
import 'package:manager_app/data.dart';
import 'package:manager_app/fetchData/configureRestaurantData.dart';

class NewCustomization extends StatefulWidget {
  final List<Customization> newCustomizations;
  final RestaurantData restaurantData;
  final Function addEditChoiceOption;

  NewCustomization({
    @required this.newCustomizations,
    @required this.restaurantData,
    @required this.addEditChoiceOption,
  });

  @override
  _NewCustomizationState createState() => _NewCustomizationState();
}

class _NewCustomizationState extends State<NewCustomization> {
/////////////////this less_more ///////

  List<Map<String, dynamic>> availableVal = [
    {"name": "Less than", "value": -1},
    {"name": "Exactly", "value": 0},
    {"name": "More than", "value": 1},
  ];
  Map<String, dynamic> selectedVal;

  bool _customizationListValidate = true;

  ///////////////////////////////////////
  final nameController = TextEditingController();
  final thatNumberController = TextEditingController();

  String customizationType = 'add_ons';

  String _addon = 'yes';

  Widget optionalLayout() {
    return Column(
      children: <Widget>[
        Container(
          padding: EdgeInsets.symmetric(vertical: 16),
          child: Text(
            "An Add-On or an Option?",
            style: kTitleStyle,
          ),
        ),
        Row(
          children: <Widget>[
            Expanded(
              child: RadioListTile(
                groupValue: _addon,
                title: Text(
                  'Add-on',
                  style: kTitleStyle,
                ),
                value: 'yes',
                onChanged: (val) {
                  setState(() {
                    _addon = val;
                    customizationType = 'add_ons';
                  });
                },
              ),
            ),
            Expanded(
              child: RadioListTile(
                groupValue: _addon,
                title: Text(
                  'Option',
                  style: kTitleStyle,
                ),
                value: 'no',
                onChanged: (val) {
                  setState(() {
                    _addon = val;
                  });
                },
              ),
            ),
          ],
        ),
      ],
    );
  }

  @override
  Widget build(BuildContext context) {
//    RestaurantData restaurantData = Provider.of<RestaurantData>(context);

    return AlertDialog(
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(20),
      ),
      title: Text(
        "New customization list",
        style: kHeaderStyleSmall,
      ),
      content: SingleChildScrollView(
        child: Container(
          width: 350,
          child: Column(
            mainAxisSize: MainAxisSize.min, // To make the card compact
            children: <Widget>[
              Row(
                children: <Widget>[
                  Text("Name : "),
                  SizedBox(width: 8),
                  Expanded(
                    child: TextField(
                      controller: nameController,
                      decoration: InputDecoration(
                        errorText: _customizationListValidate ? null : 'Value Can\'t Be Empty',
                      ),
                    ),
                  ),
                ],
              ),
              optionalLayout(),
              _addon == 'no'
                  ? Container(
                      width: 350,
                      child: Column(
                        children: <Widget>[
                          Container(
                            padding: EdgeInsets.symmetric(vertical: 16),
                            child: Text(
                              "Option with or without price?",
                              style: kTitleStyle,
                            ),
                          ),
                          Row(
                            children: <Widget>[
                              Expanded(
                                child: RadioListTile(
                                  groupValue: customizationType,
                                  title: Text(
                                    'With price',
                                    style: kTitleStyle,
                                  ),
                                  value: 'options',
                                  onChanged: (val) {
                                    setState(() {
                                      customizationType = val;
                                    });
                                  },
                                ),
                              ),
                              Expanded(
                                child: RadioListTile(
                                  groupValue: customizationType,
                                  title: Text(
                                    'Without Price',
                                    style: kTitleStyle,
                                  ),
                                  value: 'choices',
                                  onChanged: (val) {
                                    setState(() {
                                      customizationType = val;
                                    });
                                  },
                                ),
                              ),
                            ],
                          ),

                          /////////////////////////////////////////////////////////////////////////
                          Row(
                            children: <Widget>[
                              Expanded(
                                child: Container(
                                  child: DropdownButton(
                                    value: selectedVal,
                                    items: availableVal.map((element) {
                                      return DropdownMenuItem(
                                        value: element,
                                        child: Text(element['name']),
                                      );
                                    }).toList(),
                                    hint: Text('Select'),
                                    isExpanded: true,
                                    onChanged: (selected) {
                                      setState(() {
                                        selectedVal = selected;
                                      });
                                    },
                                  ),
                                ),
                              ),
                              Expanded(
                                child: Container(
                                  child: TextField(
                                      controller: thatNumberController,
                                      keyboardType: TextInputType.number

//                                    autofocus: true,
                                      ),
                                ),
                              ),
                            ],
                          ),
                        ],
                      ),
                    )
                  : Container(),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: <Widget>[
                  FlatButton(
                    child: Text(
                      "Cancel",
                      style: TextStyle(color: Colors.red),
                    ),
                    onPressed: () {
                      Navigator.of(context).pop(); // To close the dialog
                    },
                  ),
                  FlatButton(
                    child: Text(
                      "Create",
                      style: TextStyle(color: Colors.green),
                    ),
                    onPressed: () {
                      print(" selected customizationType :");
                      print(customizationType);

                      print(nameController.text);
                      var temp;
                      if (customizationType == "add_ons") {
                        temp = {
                          "name": nameController.text,
                          "customization_type": customizationType,
                          "less_more": 1,
                          "that_number": 0,
                        };
                      } else {
                        temp = {
                          "name": nameController.text,
                          "customization_type": customizationType,
                          "less_more": selectedVal['value'],
                          "that_number": int.parse(thatNumberController.text),
                        };
                      }

                      if (nameController.text.isNotEmpty) {
                        Customization newCustom = new Customization.fromJson(
                            temp, widget.restaurantData.restaurant.addOnsMenu);
                        setState(() {
                          widget.newCustomizations.add(newCustom);
                          _customizationListValidate = true;
                        });
                        widget.addEditChoiceOption(widget.restaurantData);
                        // To close the dialog
                        Navigator.of(context).pop();
                      }
                      else{
                        setState(() {
                          _customizationListValidate = false;
                        });
                      }



                    },
                  ),
                ],
              )
            ],
          ),
        ),
      ),
    );
  }
}

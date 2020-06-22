import 'package:flutter/material.dart';
import 'package:manager_app/constants.dart';
import 'package:manager_app/data.dart';
import 'package:manager_app/fetchData/configureRestaurantData.dart';
import 'package:provider/provider.dart';

class NewCustomization extends StatefulWidget {
  List<Customization> newCustomizations;

  NewCustomization({
    @required this.newCustomizations,
  });

  @override
  _NewCustomizationState createState() => _NewCustomizationState();
}

class _NewCustomizationState extends State<NewCustomization> {
  final nameController = TextEditingController();

  String customizationType = 'add_ons';

  String optional = 'yes';

  Widget optionalLayout() {
    return Column(
      children: <Widget>[
        Container(
          padding: EdgeInsets.symmetric(vertical: 16),
          child: Text(
            "Is this Optional to select ?",
            style: kTitleStyle,
          ),
        ),
        Row(
          children: <Widget>[
            Expanded(
              child: RadioListTile(
                groupValue: optional,
                title: Text(
                  'Yes',
                  style: kTitleStyle,
                ),
                value: 'yes',
                onChanged: (val) {
                  setState(() {
                    optional = val;
                    customizationType = 'add_ons';
                  });
                },
              ),
            ),
            Expanded(
              child: RadioListTile(
                groupValue: optional,
                title: Text(
                  'No',
                  style: kTitleStyle,
                ),
                value: 'no',
                onChanged: (val) {
                  setState(() {
                    optional = val;
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
    RestaurantData restaurantData = Provider.of<RestaurantData>(context);
    return AlertDialog(
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(20),
      ),
      title: Text(
        "New customization",
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
                      autofocus: true,
                    ),
                  ),
                ],
              ),
              optionalLayout(),
              optional == 'no'
                  ? Container(
                      width: 350,
                      child: Column(
                        children: <Widget>[
                          Container(
                            padding: EdgeInsets.symmetric(vertical: 16),
                            child: Text(
                              "Extra Chargeable ?",
                              style: kTitleStyle,
                            ),
                          ),
                          Row(
                            children: <Widget>[
                              Expanded(
                                child: RadioListTile(
                                  groupValue: customizationType,
                                  title: Text(
                                    'Yes',
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
                                    'No',
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

                      var temp = {
                        "name": nameController.text,
                        "customization_type": customizationType,
                        "less_more": 0,
                        "that_number": 2,
                      };

                      Customization newCustom = new Customization.fromJson(
                          temp, restaurantData.restaurant.addOnsMenu);
                      setState(() {
                        widget.newCustomizations.add(newCustom);
                      });

                      Navigator.of(context).pop(); // To close the dialog
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

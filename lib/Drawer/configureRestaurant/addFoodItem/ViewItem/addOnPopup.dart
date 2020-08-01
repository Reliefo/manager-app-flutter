import 'package:flutter/material.dart';
import 'package:manager_app/constants.dart';
import 'package:manager_app/data.dart';
import 'package:manager_app/fetchData/configureRestaurantData.dart';
import 'package:manager_app/Drawer/configureRestaurant/addOns.dart';

class AddOnPopup extends StatefulWidget {
  final List<MenuFoodItem> availableAddOns;
  final Map<String, bool> availableAddOnsValues;
  final addOns;
  final Function sendAdonsData;
  final RestaurantData restaurantData;
  AddOnPopup({
    @required this.restaurantData,
    @required this.availableAddOns,
    @required this.availableAddOnsValues,
    @required this.addOns,
    @required this.sendAdonsData,
  });
  @override
  _AddOnPopupState createState() => _AddOnPopupState();
}

class _AddOnPopupState extends State<AddOnPopup> {
  List<String> selectedAddOns = [];
  getSelectedAddOns() {
    widget.availableAddOnsValues.forEach((addOnId, val) {
      if (val == true) {
        widget.availableAddOns.forEach((element) {
          if (element.oid == addOnId) {
            print("adding add-on");
            setState(() {
              widget.addOns.add(element);
            });

            print("added");
          }
        });
      }
    });
  }

  @override
  Widget build(BuildContext context) {
//    RestaurantData restaurantData = Provider.of<RestaurantData>(context);
    print("add ons");
    print(widget.addOns);

    return Dialog(

      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(20),
      ),

      child: Container(
        width :500,
        child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: <Widget>[
            Padding(
              padding: const EdgeInsets.fromLTRB(50.0,0,10.0,0),
              child: Row(
                mainAxisSize: MainAxisSize.min,
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: <Widget>[
                  Expanded(child:
                  Text('Add-Ons',
                    textAlign: TextAlign.left,
                    style: TextStyle(fontWeight: FontWeight.bold),
      )),
                  Expanded(
                    child: OutlineButton(
                      shape: new RoundedRectangleBorder(borderRadius: new BorderRadius.circular(10.0)),
                      child: Text(
                        "Edit",
                        //textDirection: TextDirection.rtl,
                        style: TextStyle(color: Colors.grey),
                      ),
                      onPressed: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => AddOnsMenu(),
                          ),
                        );
                        //Navigator.of(context).pop(); // To close the dialog
                      },
                    ),
                  ),
                ],
              ),
            ),
            Container(
              width: 300,
              height: 150,
              child: ListView.builder(
                  shrinkWrap: true,
                  itemCount: widget.availableAddOns.length,
                  itemBuilder: (context, index) {
                    return CheckboxListTile(
                        title: Text(
                          widget.availableAddOns[index].name,
                          textAlign: TextAlign.left,
                          style: kTitleStyle,
                        ),
                        value: widget.availableAddOnsValues[
                            "${widget.availableAddOns[index].oid}"],
                        onChanged: (bool val) {
                          setState(() {
                            widget.availableAddOnsValues[
                                "${widget.availableAddOns[index].oid}"] = val;
                          });
                        });
                  }),
            ),
            Row(
              //mainAxisAlignment: MainAxisAlignment.spaceAround,
              mainAxisSize: MainAxisSize.min,
              children: <Widget>[
              Expanded(
              child: FlatButton(
                          child: Text(
                            "Cancel",
                            style: TextStyle(color: Colors.red),
                          ),
                          onPressed: () {
                            Navigator.of(context).pop(); // To close the dialog
                          },
                        ),
              ),
                Expanded(
                  child:FlatButton(
                  child: Text(
                    "Done",
                    style: TextStyle(color: Colors.green),
                  ),
                  onPressed: () {
                    getSelectedAddOns();
                    widget.sendAdonsData(widget.restaurantData);
                    Navigator.of(context).pop(); // To close the dialog
                  },
                ),),
              ],
            )
          ],
        ),
      ),
    );
  }
}

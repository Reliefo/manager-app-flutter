import 'package:flutter/material.dart';
import 'package:manager_app/Drawer/configureRestaurant/Kitchen/addKitchenStaff.dart';
import 'package:manager_app/Drawer/configureRestaurant/Kitchen/assignCategory.dart';
import 'package:manager_app/constants.dart';
import 'package:manager_app/data.dart';

class KitchenDetails extends StatelessWidget {
  KitchenDetails({
    @required this.kitchen,
  });
  final Kitchen kitchen;
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
          backgroundColor: kThemeColor,
          title: Text(kitchen.name),
        ),
        body: Container(
          color: Color(0xffE5EDF1),
          child: Row(
            children: <Widget>[
              Expanded(
                child: AddKitchenStaff(
                  kitchen: kitchen,
                ),
              ),
              VerticalDivider(),
              Expanded(
                child: AssignCategory(
                  kitchen: kitchen,
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}

import 'package:flutter/material.dart';
import 'package:manager_app/constants.dart';
import 'package:manager_app/data.dart';
import 'package:manager_app/fetchData/configureRestaurantData.dart';
import 'package:provider/provider.dart';

class AssignStaff extends StatefulWidget {
  @override
  _AssignStaffState createState() => _AssignStaffState();
}

class _AssignStaffState extends State<AssignStaff> {
  final myController = TextEditingController();
  Tables selectedTable;
  List<Staff> selectedStaff = [];
  Map<String, List<Staff>> dropdownStaff = {};
  Map<String, Staff> selectedStaffLabel = {};
  var _selectedTableLabel;
//  Staff selectedStaffLabel;

  sendAssignedStaff(restaurantData, tableId, staffId) {
    restaurantData.sendConfiguredDataToBackend(
        {"table_id": tableId, "assigned_staff": staffId}, "assign_staff");
  }

  filterStaff(restaurantData) {
    print("ddddd");

    restaurantData.restaurant.tables.forEach((table) {
      List<Staff> tableStaff = [];
      restaurantData.restaurant.staff.forEach((staff) {
        tableStaff.add(staff);
      });
      dropdownStaff[table.oid] = tableStaff;
    });

    restaurantData.restaurant.tables.forEach((table) {
      if (table.staff != null) {
        table.staff.forEach((staff) {
          dropdownStaff[table.oid]
              .removeWhere((element) => element.oid == staff.oid);
        });
      }
    });

    print("heskadkajla");
  }

  @override
  Widget build(BuildContext context) {
    print(selectedStaffLabel);
    print("test here");

    final RestaurantData restaurantData = Provider.of<RestaurantData>(context);
    filterStaff(restaurantData);
    print("test here");
    print(dropdownStaff);
    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
          backgroundColor: kThemeColor,
          title: Text(
            'Assign Staff',
          ),
        ),
        body: Container(
          padding: EdgeInsets.symmetric(vertical: 12, horizontal: 18),
          color: Colors.amber[100],
//          color: Color(0xffE0EAF0),
          child: Card(
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(20.0),
            ),
            color: Colors.amber[100],
//            color: Color(0xffE5EDF1),
            child: Column(
              children: <Widget>[
                Container(
                  padding: EdgeInsets.symmetric(vertical: 20, horizontal: 22),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: <Widget>[
                      Text(
                        restaurantData.restaurant.tables != null
                            ? 'No of Tables : ${restaurantData.restaurant.tables.length}'
                            : 'No of Tables : 0 ',
                        style: kTitleStyle,
                      ),
                      Text(
                        restaurantData.restaurant.staff != null
                            ? 'No of Staff : ${restaurantData.restaurant.staff.length}'
                            : 'No of Staff : 0',
                        style: kTitleStyle,
                      ),
                    ],
                  ),
                ),

                /////////////for displaying assigned staff////////////////////
                Expanded(
                  child: restaurantData.restaurant.tables != null
                      ? GridView.builder(
                          itemCount: restaurantData.restaurant.tables.length,
                          gridDelegate:
                              SliverGridDelegateWithMaxCrossAxisExtent(
                            mainAxisSpacing: 4.0,
                            crossAxisSpacing: 4.0,
                            childAspectRatio: 1,
                            maxCrossAxisExtent: 400,
                          ),
                          itemBuilder: (BuildContext context, index) {
                            return Container(
                              color: Color(0xffE5EDF1),
                              padding: EdgeInsets.symmetric(
                                  vertical: 12, horizontal: 16),
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: <Widget>[
                                  Container(
                                    padding: EdgeInsets.symmetric(vertical: 8),
                                    child: Text(
                                      restaurantData
                                          .restaurant.tables[index].name,
                                      style: homePageS1,
                                    ),
                                  ),
                                  Column(
                                    children: <Widget>[
                                      selectedStaffLabel[restaurantData
                                                  .restaurant
                                                  .tables[index]
                                                  .oid] !=
                                              null
                                          ? Row(
                                              mainAxisAlignment:
                                                  MainAxisAlignment.spaceAround,
                                              children: <Widget>[
                                                Text(
                                                  selectedStaffLabel[
                                                          restaurantData
                                                              .restaurant
                                                              .tables[index]
                                                              .oid]
                                                      .name,
                                                  style: kTitleStyle,
                                                ),
                                                MaterialButton(
//                                                  color: Colors.white,
                                                  onPressed: () {
                                                    sendAssignedStaff(
                                                        restaurantData,
                                                        restaurantData
                                                            .restaurant
                                                            .tables[index]
                                                            .oid,
                                                        selectedStaffLabel[
                                                                restaurantData
                                                                    .restaurant
                                                                    .tables[
                                                                        index]
                                                                    .oid]
                                                            .oid);
                                                    setState(() {
                                                      selectedStaffLabel.remove(
                                                          restaurantData
                                                              .restaurant
                                                              .tables[index]
                                                              .oid);
                                                    });
                                                  },
                                                  child: Text(
                                                    "assign",
                                                    style: kTitleStyle,
                                                  ),
                                                ),
                                              ],
                                            )
                                          : Container(
                                              padding: EdgeInsets.all(16),
                                              child: DropdownButton(
                                                items: dropdownStaff[
                                                            restaurantData
                                                                .restaurant
                                                                .tables[index]
                                                                .oid] !=
                                                        null
                                                    ? dropdownStaff[
                                                            restaurantData
                                                                .restaurant
                                                                .tables[index]
                                                                .oid]
                                                        .map((staff) {
                                                        return DropdownMenuItem(
                                                          value: staff,
                                                          child: Text(
                                                            staff.name,
                                                            style: kTitleStyle,
                                                          ),
                                                        );
                                                      }).toList()
                                                    : [],
                                                hint: Text(
                                                  'Select the Staff',
                                                  style: kTitleStyle,
                                                ),
                                                isExpanded: true,
                                                onChanged: (selected) {
                                                  setState(() {
                                                    print(selected);
                                                    selectedStaffLabel[
                                                        restaurantData
                                                            .restaurant
                                                            .tables[index]
                                                            .oid] = selected;
//                                              selectedStaff.add(selected);
                                                  });
                                                },
                                              ),
                                            ),
                                    ],
                                  ),
                                  restaurantData.restaurant.tables[index]
                                                  .staff !=
                                              null &&
                                          restaurantData.restaurant
                                              .tables[index].staff.isNotEmpty
                                      ? Expanded(
                                          child: ListView.builder(
                                              itemCount: restaurantData
                                                  .restaurant
                                                  .tables[index]
                                                  .staff
                                                  .length,
                                              shrinkWrap: true,
                                              primary: false,
                                              itemBuilder: (context, index2) {
                                                return ListTile(
                                                  title: Text(
                                                    restaurantData
                                                        .restaurant
                                                        .tables[index]
                                                        .staff[index2]
                                                        .name,
                                                    style: kTitleStyle,
                                                  ),
                                                  trailing: IconButton(
                                                    icon: Icon(Icons.cancel),
                                                    onPressed: () {
                                                      restaurantData
                                                          .sendConfiguredDataToBackend(
                                                              {
                                                            "table_id":
                                                                restaurantData
                                                                    .restaurant
                                                                    .tables[
                                                                        index]
                                                                    .oid,
                                                            "withdraw_staff_id":
                                                                restaurantData
                                                                    .restaurant
                                                                    .tables[
                                                                        index]
                                                                    .staff[
                                                                        index2]
                                                                    .oid
                                                          },
                                                              "withdraw_staff");
                                                    },
                                                  ),
                                                );
                                              }),
                                        )
                                      : Center(
                                          child: Text(
                                            'No Staff Assigned.',
                                            style: kSubTitleStyle,
                                          ),
                                        ),
                                ],
                              ),
                            );
                          })
                      : Text(
                          'Add tables first',
                          style: kTitleStyle,
                        ),
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}
//
//Expanded(
//child: Container(
//height: double.maxFinite,
//padding: EdgeInsets.symmetric(vertical: 12, horizontal: 18),
//color: Color(0xffE0EAF0),
//child: Card(
//color: Color(0xffE5EDF1),
//shape: RoundedRectangleBorder(
//borderRadius: BorderRadius.circular(20.0),
//),
//child: SingleChildScrollView(
//child: Column(
//mainAxisSize: MainAxisSize.min,
//crossAxisAlignment: CrossAxisAlignment.start,
//children: <Widget>[
//Container(
//padding: EdgeInsets.all(16),
//child: Text('Assign Staff To Table'),
//),
//Row(
//children: <Widget>[
//
//Expanded(
//child: Container(
//padding: EdgeInsets.all(16),
//child: DropdownButton(
//items: displayStaff != null
//? displayStaff.map((staff) {
//return DropdownMenuItem(
//value: staff,
//child: Text(staff.name),
//);
//}).toList()
//    : [],
//hint: Text('Select the Staff'),
//isExpanded: true,
//onChanged: (selected) {
//setState(() {
//_selectedStaffLabel = selected;
//selectedStaff.add(selected);
//});
//removeDisplayStaff();
//},
//),
//),
//),
//],
//),
//
//
//FlatButton(
//child: Container(
//child: Text('Confirm'),
//),
//onPressed: () {
//sendAssignedStaff(restaurantData);
//
//selectedStaff.clear();
//},
//),
//],
//),
//),
//),
//),
//),

//Container(
//padding:
//EdgeInsets.symmetric(horizontal: 8),
//child: ListView.builder(
//shrinkWrap: true,
//primary: false,
//itemCount: selectedStaff.length,
//itemBuilder: (context, index) {
//return ListTile(
//title: Text(
//selectedStaff[index].name,
//style: homePageS2,
//),
//trailing: IconButton(
//icon: Icon(Icons.cancel),
//onPressed: () {
//setState(() {
//selectedStaff
//    .removeAt(index);
//});
//},
//),
//);
//}),
//),

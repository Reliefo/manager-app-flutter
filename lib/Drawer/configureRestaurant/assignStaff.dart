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
  List<Staff> displayStaff = [];
  var _selectedTableLabel;
  var _selectedStaffLabel;

  sendAssignedStaff(restaurantData) {
    List selectedId = [];
    selectedStaff.forEach((f) {
      selectedId.add(f.oid);
    });

    restaurantData.sendConfiguredDataToBackend(
        {"table_id": selectedTable.oid, "assigned_staff": selectedId},
        "assign_staff");
  }

  getStaff(restaurantData) {
    displayStaff.clear();

    restaurantData.restaurant.staff.forEach((staff) {
      displayStaff.add(staff);
    });
    if (selectedStaff.isNotEmpty && selectedStaff != null) {
      selectedTable.staff.forEach((staff) {
        displayStaff.removeWhere((element) => element == staff);
      });
    }
  }

  removeDisplayStaff() {
    if (selectedStaff.isNotEmpty && selectedStaff != null) {
      selectedStaff.forEach((staff) {
        displayStaff.removeWhere((element) => element == staff);
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    print("test here");
//    print(selectedTable.staff);

    final RestaurantData restaurantData = Provider.of<RestaurantData>(context);
    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
          backgroundColor: Colors.grey,
          title: Text('Assign Staff'),
        ),
        body: Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            Expanded(
              child: Container(
                height: double.maxFinite,
                padding: EdgeInsets.symmetric(vertical: 12, horizontal: 18),
                color: Color(0xffE0EAF0),
                child: Card(
                  color: Color(0xffE5EDF1),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(20.0),
                  ),
                  child: SingleChildScrollView(
                    child: Column(
                      mainAxisSize: MainAxisSize.min,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: <Widget>[
                        Container(
                          padding: EdgeInsets.all(16),
                          child: Text('Assign Staff To Table'),
                        ),
                        Row(
                          children: <Widget>[
                            Expanded(
                              child: Container(
                                padding: EdgeInsets.all(16),
                                child: DropdownButton(
                                  value: _selectedTableLabel,
                                  items:
                                      restaurantData.restaurant.tables != null
                                          ? restaurantData.restaurant.tables
                                              .map((table) {
                                              return DropdownMenuItem(
                                                value: table,
                                                child: Text(table.name),
                                              );
                                            }).toList()
                                          : [],
                                  hint: Text('Select the Table'),
                                  isExpanded: true,
                                  onChanged: (selected) {
                                    setState(() {
                                      print(selected);
                                      _selectedTableLabel = selected;
                                      selectedTable = selected;
                                    });
                                    displayStaff.clear();
                                    selectedStaff.clear();
                                    getStaff(restaurantData);
                                  },
                                ),
                              ),
                            ),
                            Expanded(
                              child: Container(
                                padding: EdgeInsets.all(16),
                                child: DropdownButton(
                                  items: displayStaff != null
                                      ? displayStaff.map((staff) {
                                          return DropdownMenuItem(
                                            value: staff,
                                            child: Text(staff.name),
                                          );
                                        }).toList()
                                      : [],
                                  hint: Text('Select the Staff'),
                                  isExpanded: true,
                                  onChanged: (selected) {
                                    setState(() {
                                      _selectedStaffLabel = selected;
                                      selectedStaff.add(selected);
                                    });
                                    removeDisplayStaff();
                                  },
                                ),
                              ),
                            ),
                          ],
                        ),
                        Container(
                          padding: EdgeInsets.symmetric(
                              vertical: 12, horizontal: 20),
                          child: selectedTable != null
                              ? Text(
                                  'Selected Table : ${selectedTable.name}',
                                  style: homePageS1,
                                )
                              : Text(
                                  'Selected Table :',
                                  style: homePageS1,
                                ),
                        ),
                        Container(
                          padding: EdgeInsets.symmetric(
                              vertical: 12, horizontal: 20),
                          child: Text(
                            'Selected Staffs :',
                            style: homePageS1,
                          ),
                        ),
                        Container(
                          padding: EdgeInsets.symmetric(horizontal: 8),
                          child: ListView.builder(
                              shrinkWrap: true,
                              primary: false,
                              itemCount: selectedStaff.length,
                              itemBuilder: (context, index) {
                                return ListTile(
                                  title: Text(
                                    selectedStaff[index].name,
                                    style: homePageS2,
                                  ),
                                  trailing: IconButton(
                                    icon: Icon(Icons.cancel),
                                    onPressed: () {
                                      setState(() {
                                        selectedStaff.removeAt(index);
                                      });
                                    },
                                  ),
                                );
                              }),
                        ),
                        FlatButton(
                          child: Container(
                            child: Text('Confirm'),
                          ),
                          onPressed: () {
                            sendAssignedStaff(restaurantData);

                            selectedStaff.clear();
                          },
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            ),
            Expanded(
              child: Container(
                padding: EdgeInsets.symmetric(vertical: 12, horizontal: 18),
                color: Color(0xffE0EAF0),
                child: Card(
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(20.0),
                  ),
                  color: Color(0xffE5EDF1),
                  child: Column(
                    children: <Widget>[
                      Container(
                        padding:
                            EdgeInsets.symmetric(vertical: 20, horizontal: 22),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: <Widget>[
                            Text(restaurantData.restaurant.tables != null
                                ? 'No Of Tables : ${restaurantData.restaurant.tables.length}'
                                : 'No Of Tables : 0 '),
                            Text(restaurantData.restaurant.staff != null
                                ? 'No Of Staff : ${restaurantData.restaurant.staff.length}'
                                : 'No Of Staff : 0'),
                          ],
                        ),
                      ),

                      /////////////for displaying assigned staff////////////////////
                      Expanded(
                        child: restaurantData.restaurant.tables != null
                            ? GridView.builder(
                                itemCount:
                                    restaurantData.restaurant.tables.length,
                                gridDelegate:
                                    SliverGridDelegateWithFixedCrossAxisCount(
                                        crossAxisCount: 2),
                                itemBuilder: (BuildContext context, index) {
                                  return Container(
                                    padding: EdgeInsets.symmetric(
                                        vertical: 12, horizontal: 16),
                                    child: Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: <Widget>[
                                        Container(
                                          padding:
                                              EdgeInsets.symmetric(vertical: 8),
                                          child: Text(
                                            restaurantData
                                                .restaurant.tables[index].name,
                                            style: homePageS1,
                                          ),
                                        ),
                                        restaurantData.restaurant.tables[index]
                                                        .staff !=
                                                    null &&
                                                restaurantData
                                                    .restaurant
                                                    .tables[index]
                                                    .staff
                                                    .isNotEmpty
                                            ? Expanded(
                                                child: ListView.builder(
                                                    itemCount: restaurantData
                                                        .restaurant
                                                        .tables[index]
                                                        .staff
                                                        .length,
                                                    shrinkWrap: true,
                                                    primary: false,
                                                    itemBuilder:
                                                        (context, index2) {
                                                      return ListTile(
                                                        title: Text(
                                                            restaurantData
                                                                .restaurant
                                                                .tables[index]
                                                                .staff[index2]
                                                                .name),
                                                        trailing: IconButton(
                                                          icon: Icon(
                                                              Icons.cancel),
                                                          onPressed: () {
                                                            restaurantData
                                                                .sendConfiguredDataToBackend({
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
                                                            }, "withdraw_staff");
                                                          },
                                                        ),
                                                      );
                                                    }),
                                              )
                                            : Text('assign staff'),
                                      ],
                                    ),
                                  );
                                })
                            : Text('Add tables first'),
                      )
                    ],
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

import 'package:adhara_socket_io_example/constants.dart';
import 'package:adhara_socket_io_example/data.dart';
import 'package:flutter/material.dart';

class AssignStaff extends StatefulWidget {
  final Restaurant restaurant;
  final updateConfigDetailsToCloud;

  AssignStaff({
    @required this.restaurant,
    this.updateConfigDetailsToCloud,
  });

  @override
  _AssignStaffState createState() => _AssignStaffState();
}

class _AssignStaffState extends State<AssignStaff> {
  final myController = TextEditingController();
  Tables selectedTable;
  List<Staff> selectedStaff = [];

  sendAssignedStaff() {
    List selectedId = [];
    selectedStaff.forEach((f) {
      selectedId.add(f.oid);
    });

    widget.updateConfigDetailsToCloud(
        {"table_id": selectedTable.oid, "assigned_staff": selectedId},
        "assign_staff");
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
          backgroundColor: Colors.grey,
          title: Text('Assign Staff'),
        ),
        body: Row(
          children: <Widget>[
            Expanded(
              child: Container(
                padding: EdgeInsets.symmetric(vertical: 12, horizontal: 18),
                color: Color(0xffE0EAF0),
                child: Card(
                  color: Color(0xffE5EDF1),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(20.0),
                  ),
                  child: Column(
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
                                items: widget.restaurant.tables != null
                                    ? widget.restaurant.tables.map((table) {
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
                                    selectedTable = selected;
                                  });
                                },
                              ),
                            ),
                          ),
                          Expanded(
                            child: Container(
                              padding: EdgeInsets.all(16),
                              child: DropdownButton(
                                items: widget.restaurant.staff != null
                                    ? widget.restaurant.staff.map((staff) {
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
                                    selectedStaff.add(selected);
                                  });
                                },
                              ),
                            ),
                          ),
                        ],
                      ),
                      Container(
                        padding:
                            EdgeInsets.symmetric(vertical: 12, horizontal: 20),
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
                        padding:
                            EdgeInsets.symmetric(vertical: 12, horizontal: 20),
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
//                            widget.restaurant.tables.forEach((table) {
//                              if (table.oid == selectedTable.oid) {
//                                print('table matched: ${table.name}');
//                                table.addTableStaff(selectedStaff);
//                              }
//                            });
                          sendAssignedStaff();

                          selectedStaff.clear();
                        },
                      ),
                    ],
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
                            Text(widget.restaurant.tables != null
                                ? 'No Of Tables : ${widget.restaurant.tables.length}'
                                : 'No Of Tables : 0 '),
                            Text(widget.restaurant.tables != null
                                ? 'No Of Staff : ${widget.restaurant.staff.length}'
                                : 'No Of Staff : 0'),
                          ],
                        ),
                      ),

                      /////////////for displaying assigned staff////////////////////
                      Expanded(
                        child: widget.restaurant.tables != null
                            ? GridView.builder(
                                itemCount: widget.restaurant.tables.length,
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
                                            widget
                                                .restaurant.tables[index].name,
                                            style: homePageS1,
                                          ),
                                        ),
                                        widget.restaurant.tables[index].staff !=
                                                null
                                            ? Expanded(
                                                child: ListView.builder(
                                                    itemCount: widget
                                                        .restaurant
                                                        .tables[index]
                                                        .staff
                                                        .length,
                                                    shrinkWrap: true,
                                                    primary: false,
                                                    itemBuilder:
                                                        (context, index2) {
                                                      return ListTile(
                                                        title: Text(widget
                                                            .restaurant
                                                            .tables[index]
                                                            .staff[index2]
                                                            .name),
                                                        trailing: IconButton(
                                                          icon: Icon(
                                                              Icons.cancel),
                                                          onPressed: () {
                                                            widget
                                                                .updateConfigDetailsToCloud({
                                                              "table_id": widget
                                                                  .restaurant
                                                                  .tables[index]
                                                                  .oid,
                                                              "withdraw_staff_id":
                                                                  widget
                                                                      .restaurant
                                                                      .tables[
                                                                          index]
                                                                      .staff[
                                                                          index2]
                                                                      .oid
                                                            }, "withdraw_staff");

                                                            //todo:
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

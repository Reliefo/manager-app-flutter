import 'package:adhara_socket_io_example/data.dart';
import 'package:flutter/material.dart';

import 'add_Data.dart';
import 'assign_Staff.dart';

class DrawerMenu extends StatelessWidget {
  final updateTableDetails;
  final updateStaffDetails;
  final List<TableDetails> tableDetailsList;
  final List<String> staffNameList;
  DrawerMenu({
    @required this.updateTableDetails,
    this.updateStaffDetails,
    @required this.tableDetailsList,
    @required this.staffNameList,
  });
  @override
  Widget build(BuildContext context) {
    return ListView(
      children: <Widget>[
        DrawerHeader(
          child: Container(),
        ),
        GestureDetector(
          child: Container(
            padding: EdgeInsets.all(12),
            child: Text('Add Data'),
          ),
          onTap: () {
            Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) => AddData(
                  updateTableDetails: updateTableDetails,
                  updateStaffDetails: updateStaffDetails,
                  tableDetailsList: tableDetailsList,
                  staffNameList: staffNameList,
                ),
              ),
            );
          },
        ),
        Divider(),
        GestureDetector(
          child: Container(
            padding: EdgeInsets.all(12),
            child: Text('Assign Server'),
          ),
          onTap: () {
            Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) => AssignStaff(
                  tableDetailsList: tableDetailsList,
                  staffNameList: staffNameList,
                ),
              ),
            );
          },
        ),
      ],
    );
  }
}

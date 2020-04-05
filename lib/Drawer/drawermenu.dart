import 'package:adhara_socket_io_example/data.dart';
import 'package:flutter/material.dart';

import 'add_staff.dart';
import 'add_tables.dart';

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
            child: Text('Add Tables'),
          ),
          onTap: () {
            Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) => AddTableData(
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
            child: Text('Add Servers'),
          ),
          onTap: () {
            Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) => AddStaffData(
                  updateTableCount: updateTableDetails,
                ),
              ),
            );
          },
        ),
      ],
    );
  }
}

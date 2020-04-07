import 'package:adhara_socket_io_example/constants.dart';
import 'package:flutter/material.dart';

class AssignStaff extends StatefulWidget {
  final tableDetailsList;
  final staffNameList;

  AssignStaff({@required this.tableDetailsList, this.staffNameList});

  @override
  _AssignStaffState createState() => _AssignStaffState();
}

class _AssignStaffState extends State<AssignStaff> {
  final myController = TextEditingController();
  String selectedTable;

  final List<String> tableNames = [];
  final List<String> selectedStaff = [];
  createTableName(tableDetails) {
    setState(() {
      tableDetails.forEach((detail) {
        tableNames.add(detail.name.toString());
      });
    });
  }

  @override
  Widget build(BuildContext context) {
//    createTableName(widget.tableDetailsList);
//    print(widget.tableDetailsList[0].allottedServers);
//    print(selectedStaff[0].runtimeType);

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
                                items: tableNames.map<DropdownMenuItem<String>>(
                                    (String value) {
                                  return DropdownMenuItem<String>(
                                    value: value,
                                    child: Text(value),
                                  );
                                }).toList(),
                                hint: Text('Select the Table'),
                                isExpanded: true,
                                onChanged: (selected) {
                                  setState(() {
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
                                items: widget.staffNameList
                                    .map<DropdownMenuItem<String>>(
                                        (String value) {
                                  return DropdownMenuItem<String>(
                                    value: value,
                                    child: Text(value),
                                  );
                                }).toList(),
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
                        child: Text(
                          'Selected Table : $selectedTable',
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
                                  selectedStaff[index],
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
                          setState(() {
                            widget.tableDetailsList.forEach((detail) {
                              if (detail.name == selectedTable) {
                                print('table matched: ${detail.name}');
                                detail.addDetails(selectedStaff);
                              }
                            });
                          });
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
                            Text('No Of Tables : 20'),
                            Text('No Of Servers : 10'),
                          ],
                        ),
                      ),
                      Expanded(
                        child: GridView.builder(
                            itemCount: widget.tableDetailsList.length,
                            gridDelegate:
                                SliverGridDelegateWithFixedCrossAxisCount(
                                    crossAxisCount: 3),
                            itemBuilder: (BuildContext context, index) {
                              return Container(
                                padding: EdgeInsets.symmetric(
                                    vertical: 12, horizontal: 16),
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: <Widget>[
                                    Container(
                                      padding:
                                          EdgeInsets.symmetric(vertical: 8),
                                      child: Text(
                                        widget.tableDetailsList[index].name,
                                        style: homePageS1,
                                      ),
                                    ),

//                                    ListView.builder(
//                                            itemCount: widget
//                                                .tableDetailsList[index]
//                                                .allottedServers
//                                                .length,
//                                            shrinkWrap: true,
//                                            primary: false,
//                                            itemBuilder: (context, index2) {
//                                              return Container(
//                                                padding: EdgeInsets.symmetric(
//                                                    vertical: 2),
//                                                child: Text(
//                                                    'server : ${widget.tableDetailsList[index].allottedServers[index2]}'),
//                                              );
//                                            }),
                                  ],
                                ),
                              );
                            }),
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

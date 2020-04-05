import 'package:adhara_socket_io_example/data.dart';
import 'package:flutter/material.dart';

class AddTableData extends StatelessWidget {
  final updateTableDetails;
  final updateStaffDetails;
  final tableCount;
  final List<String> staffNameList;
  final List<TableDetails> tableDetailsList;
  final tableNameController = TextEditingController();
  final tableSeatController = TextEditingController();
  final staffNameController = TextEditingController();

  AddTableData({
    @required this.updateTableDetails,
    this.updateStaffDetails,
    this.tableCount,
    this.tableDetailsList,
    this.staffNameList,
  });

  @override
  Widget build(BuildContext context) {
    print(staffNameList);
    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
          backgroundColor: Colors.grey,
          title: Text('Table Data'),
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
                        child: Text('Table Details'),
                      ),
                      Row(
                        children: <Widget>[
                          Expanded(
                            flex: 4,
                            child: Container(
                              padding: EdgeInsets.all(12),
                              child: TextFormField(
                                controller: tableNameController,
                                decoration: InputDecoration(
                                  labelText: "Table Name",
                                  fillColor: Colors.white,
                                  border: OutlineInputBorder(
                                    borderRadius: BorderRadius.circular(12.0),
                                  ),
                                  //fillColor: Colors.green
                                ),
                                keyboardType: TextInputType.text,
                              ),
                            ),
                          ),
                          Expanded(
                            flex: 2,
                            child: Container(
                              padding: EdgeInsets.all(12),
                              child: TextFormField(
                                controller: tableSeatController,
                                decoration: InputDecoration(
                                  labelText: "Seats",
                                  fillColor: Colors.white,
                                  border: OutlineInputBorder(
                                    borderRadius: BorderRadius.circular(12.0),
                                  ),
                                  //fillColor: Colors.green
                                ),
                                keyboardType: TextInputType.number,
                              ),
                            ),
                          ),

                          Expanded(
                              child: Container(
                            padding: EdgeInsets.all(8),
                            child: RaisedButton(
                              color: Colors.grey,
                              child: Text('Add'),
                              onPressed: () {
                                if (tableNameController.text != null) {
                                  updateTableDetails(tableNameController.text,
                                      tableSeatController.text);
                                }
                              },
                            ),
                          )),
//
                        ],
                      ),
                      Container(
                        padding:
                            EdgeInsets.symmetric(vertical: 20, horizontal: 22),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: <Widget>[
                            Text('No Of Tables : ${tableDetailsList.length}'),
                          ],
                        ),
                      ),
                      Expanded(
                          child: ListView.builder(
                              itemCount: tableDetailsList.length,
                              shrinkWrap: true,
                              primary: false,
                              itemBuilder: (context, index) {
                                return Container(
                                  padding: EdgeInsets.symmetric(vertical: 2),
                                  child:
                                      Text('${tableDetailsList[index].name}'),
                                );
                              })),
                    ],
                  ),
                ),
              ),
            ),

            /////// second half screen
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
                        child: Text('Staff Details'),
                      ),
                      Row(
                        children: <Widget>[
                          Expanded(
                            flex: 4,
                            child: Container(
                              padding: EdgeInsets.all(12),
                              child: TextFormField(
                                controller: staffNameController,
                                decoration: InputDecoration(
                                  labelText: "Staff Name",
                                  fillColor: Colors.white,
                                  border: OutlineInputBorder(
                                    borderRadius: BorderRadius.circular(12.0),
                                  ),
                                  //fillColor: Colors.green
                                ),
                                keyboardType: TextInputType.text,
                              ),
                            ),
                          ),

                          Expanded(
                              child: Container(
                            padding: EdgeInsets.all(8),
                            child: RaisedButton(
                              color: Colors.grey,
                              child: Text('Add'),
                              onPressed: () {
                                updateStaffDetails(staffNameController.text);
                              },
                            ),
                          )),
//
                        ],
                      ),
                      Container(
                        padding:
                            EdgeInsets.symmetric(vertical: 20, horizontal: 22),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: <Widget>[
                            Text(
                                'No Of Staffs added : ${staffNameList.length}'),
                          ],
                        ),
                      ),
                      Expanded(
                          child: ListView.builder(
                              itemCount: staffNameList.length,
                              shrinkWrap: true,
                              primary: false,
                              itemBuilder: (context, index) {
                                return ListItem(
                                  staffNameList: staffNameList,
                                  index: index,
                                );
                              })),
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

class ListItem extends StatefulWidget {
  final List<String> staffNameList;
  final int index;

  ListItem({
    @required this.staffNameList,
    this.index,
  });
  @override
  _ListItemState createState() => _ListItemState();
}

class _ListItemState extends State<ListItem> {
  bool _isEditing = false;
  bool _done = true;
  final editingController = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return ListTile(
      title: _isEditing
          ? TextFormField(
              enabled: _isEditing,
              controller: editingController,
              decoration: InputDecoration(
                hintText: 'Staff Name',
              ),
            )
          : Text('${widget.staffNameList[widget.index]}'),

      // The icon button which will notify list item to change
      trailing: !_isEditing
          ? GestureDetector(
              child: Icon(
                Icons.edit,
                color: Colors.black,
              ),
              onTap: () {
                setState(() {
                  if (_isEditing == true) {
                    _isEditing = false;
                  }
                  if (_isEditing == false) {
                    _isEditing = true;
                  }
                });
              },
            )
          : GestureDetector(
              child: Icon(
                Icons.done,
                color: Colors.black,
              ),
              onTap: () {
                setState(() {
                  if (_done == true) {
                    _done = false;
                    _isEditing = false;
                  }
                  if (_done == false) {
                    _done = true;
                  }
                  widget.staffNameList
                      .insert(widget.index, editingController.text);
                  widget.staffNameList.removeAt(widget.index + 1);
                });
              },
            ),
    );
  }
}

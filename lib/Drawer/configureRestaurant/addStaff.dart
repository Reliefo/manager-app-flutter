import 'package:adhara_socket_io_example/data.dart';
import 'package:flutter/material.dart';

class AddStaff extends StatefulWidget {
  final updateConfigDetailsToCloud;

  final Restaurant restaurant;

  AddStaff({
    this.updateConfigDetailsToCloud,
    this.restaurant,
  });

  @override
  _AddDataState createState() => _AddDataState();
}

class _AddDataState extends State<AddStaff> {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  List<Map<String, String>> temporaryStaffNames = [];
  List<Map<String, String>> temporaryTables = [];
  final tableNameController = TextEditingController();

  final tableSeatController = TextEditingController();

  final staffNameController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
          backgroundColor: Colors.grey,
          title: Text('Staff Data'),
        ),
        body: Container(
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
                            if (staffNameController.text.isNotEmpty) {
                              setState(() {
                                temporaryStaffNames.add(
                                    {'staff_name': staffNameController.text});
                              });

                              staffNameController.clear();
                            }
                          },
                        ),
                      ),
                    ),
//
                  ],
                ),
                Container(
                  padding: EdgeInsets.symmetric(vertical: 20, horizontal: 22),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: <Widget>[
                      widget.restaurant.staff == null
                          ? Text('No Of Staffs :')
                          : Text(
                              'No Of Staffs : ${widget.restaurant.staff.length} '),
                    ],
                  ),
                ),

                Expanded(
                  child: ListView(
                    shrinkWrap: true,
                    children: <Widget>[
                      ListView.builder(
                          itemCount: temporaryStaffNames.length,
                          shrinkWrap: true,
                          primary: false,
                          itemBuilder: (context, index) {
                            return ListTile(
                              title: Text(
                                  'Table Name : ${temporaryStaffNames[index]['staff_name']}'),
                              trailing: IconButton(
                                icon: Icon(Icons.cancel),
                                onPressed: () {
                                  setState(() {
                                    temporaryStaffNames.removeAt(index);
                                  });
                                },
                              ),
                            );
                          }),
                      widget.restaurant.staff != null
                          ? ListView.builder(
                              itemCount: widget.restaurant.staff.length,
                              shrinkWrap: true,
                              primary: false,
                              itemBuilder: (context, index) {
                                return ListTile(
                                  title: Text(
                                      'Table Name : ${widget.restaurant.staff[index].name}'),
                                  trailing: IconButton(
                                    icon: Icon(Icons.cancel),
                                    onPressed: () {
                                      widget.updateConfigDetailsToCloud(
                                          widget.restaurant.staff[index].oid,
                                          "delete_staff");
                                    },
                                  ),
                                );
                              })
                          : Text(' '),
                    ],
                  ),
                ),

                FlatButton(
                  child: Text('Upload to Cloud'),
                  onPressed: () {
                    widget.updateConfigDetailsToCloud(
                        temporaryStaffNames, "add_staff");

                    temporaryStaffNames.clear();
                  },
                ),
//                      Expanded(
//                          child: ListView.builder(
//                              itemCount: widget.staffNameList.length,
//                              shrinkWrap: true,
//                              primary: false,
//                              itemBuilder: (context, index) {
//                                return ListItem(
//                                  staffNameList: widget.staffNameList,
//                                  index: index,
//                                );
//                              })),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

//class ListItem extends StatefulWidget {
//  final List<String> staffNameList;
//  final int index;
//
//  ListItem({
//    @required this.staffNameList,
//    this.index,
//  });
//  @override
//  _ListItemState createState() => _ListItemState();
//}
//
//class _ListItemState extends State<ListItem> {
//  bool _isEditing = false;
//  bool _done = true;
//  final editingController = TextEditingController();
//  @override
//  Widget build(BuildContext context) {
//    return ListTile(
//      title: _isEditing
//          ? TextFormField(
//              enabled: _isEditing,
//              controller: editingController,
//              decoration: InputDecoration(
//                hintText: 'Staff Name',
//              ),
//            )
//          : Text('${widget.staffNameList[widget.index]}'),
//
//      // The icon button which will notify list item to change
//      trailing: !_isEditing
//          ? GestureDetector(
//              child: Icon(
//                Icons.edit,
//                color: Colors.black,
//              ),
//              onTap: () {
//                setState(() {
//                  if (_isEditing == true) {
//                    _isEditing = false;
//                  }
//                  if (_isEditing == false) {
//                    _isEditing = true;
//                  }
//                });
//              },
//            )
//          : GestureDetector(
//              child: Icon(
//                Icons.done,
//                color: Colors.black,
//              ),
//              onTap: () {
//                setState(() {
//                  if (_done == true) {
//                    _done = false;
//                    _isEditing = false;
//                  }
//                  if (_done == false) {
//                    _done = true;
//                  }
//                  widget.staffNameList
//                      .insert(widget.index, editingController.text);
//                  widget.staffNameList.removeAt(widget.index + 1);
//                });
//              },
//            ),
//    );
//  }
//}

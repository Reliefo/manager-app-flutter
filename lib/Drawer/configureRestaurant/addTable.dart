import 'package:adhara_socket_io_example/data.dart';
import 'package:flutter/material.dart';

class AddData extends StatefulWidget {
  final updateConfigDetailsToCloud;

  final Restaurant restaurant;

  AddData({
    this.updateConfigDetailsToCloud,
    this.restaurant,
  });

  @override
  _AddDataState createState() => _AddDataState();
}

class _AddDataState extends State<AddData> {
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
          title: Text('Table Data'),
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
//                    mainAxisSize: MainAxisSize.min,
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
                          validator: (value) {
                            if (value.isEmpty) {
                              return 'Please enter table name';
                            }
                            return null;
                          },
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
                          if (tableNameController.text.isNotEmpty &&
                              tableSeatController.text.isNotEmpty) {
                            setState(() {
                              temporaryTables.add({
                                'table_name': tableNameController.text,
                                'seats': tableSeatController.text
                              });
                            });
                            tableSeatController.clear();
                            tableNameController.clear();
                          }
                        },
                      ),
                    )),
                  ],
                ),
                Container(
                  padding: EdgeInsets.symmetric(vertical: 20, horizontal: 22),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: <Widget>[
                      widget.restaurant.tables == null
                          ? Text('No Of Tables :')
                          : Text(
                              'No Of Tables : ${widget.restaurant.tables.length} '),
                    ],
                  ),
                ),
                Expanded(
                  child: ListView(
                    shrinkWrap: true,
                    children: <Widget>[
                      ListView.builder(
                          itemCount: temporaryTables.length,
                          shrinkWrap: true,
                          primary: false,
                          itemBuilder: (context, index) {
                            return ListTile(
                              title: Text(
                                  'Table Name : ${temporaryTables[index]['table_name']}'),
                              subtitle: Text(
                                  'Capacity : ${temporaryTables[index]['seats']} Seats'),
                              trailing: IconButton(
                                icon: Icon(Icons.cancel),
                                onPressed: () {
                                  setState(() {
                                    temporaryTables.removeAt(index);
                                  });
                                },
                              ),
                            );
                          }),

                      ////displaying from cloud/ real updated data
                      widget.restaurant.tables != null
                          ? ListView.builder(
                              itemCount: widget.restaurant.tables.length,
                              shrinkWrap: true,
                              primary: false,
                              itemBuilder: (context, index) {
                                return ListTile(
                                  title: Text(
                                      'Table Name : ${widget.restaurant.tables[index].name}'),
                                  subtitle: Text(
                                      'Capacity : ${widget.restaurant.tables[index].seats} Seats'),
                                  trailing: IconButton(
                                    icon: Icon(Icons.cancel),
                                    onPressed: () {
                                      widget.updateConfigDetailsToCloud(
                                          widget.restaurant.tables[index].oid,
                                          "delete_table");
//                                        setState(() {
//                                          widget.restaurant.tables
//                                              .removeAt(index);
//                                        });
                                    },
                                  ),
                                );
                              })
                          : Text(' ')
                    ],
                  ),
                ),
                FlatButton(
                  child: Text('Upload to Cloud'),
                  onPressed: () {
                    widget.updateConfigDetailsToCloud(
                        temporaryTables, "add_tables");
                    temporaryTables.clear();
                  },
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

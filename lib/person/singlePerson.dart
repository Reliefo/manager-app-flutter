import 'package:adhara_socket_io_example/constants.dart';
import 'package:adhara_socket_io_example/data.dart';
import 'package:adhara_socket_io_example/fetchData/configureRestaurantData.dart';
import 'package:adhara_socket_io_example/fetchData/fetchAssistanceData.dart';
import 'package:date_format/date_format.dart';
import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class SinglePerson extends StatelessWidget {
  final Staff staff;
//  final List<AssistanceRequest> assistanceReq;
  final List<AssistanceRequest> personAssistanceReq = [];
  final List<String> allottedTables = [];

  SinglePerson({
    this.staff,
//    this.assistanceReq,
  });

  final startTime = '4:20 PM';

  getPersonAssistance(assistanceData) {
    assistanceData.assistanceReq.forEach((request) {
      if (request.acceptedBy == staff.name) {
        personAssistanceReq.add(request);
      }
    });
  }

  getAllottedTables(restaurantData) {
    restaurantData.restaurant.tables.forEach((table) {
      table.staff.forEach((tableStaff) {
        if (tableStaff.oid == staff.oid) {
          allottedTables.add(table.name);
        }
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    final RestaurantData restaurantData = Provider.of<RestaurantData>(context);

    final AssistanceData assistanceData = Provider.of<AssistanceData>(context);

    getPersonAssistance(assistanceData);
    getAllottedTables(restaurantData);
    return SafeArea(
      child: Scaffold(
        body: Container(
          color: Colors.black54,
          child: Column(
            children: <Widget>[
              Container(
                height: 60,
                width: double.maxFinite,
                color: Colors.black12,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: <Widget>[
                    Expanded(
                      child: Container(
                        padding: EdgeInsets.symmetric(horizontal: 20),
                        child: Row(
                          children: <Widget>[
                            //todo: change logo table
                            Icon(
                              Icons.add,
                              size: 30,
                            ),
                            Text(
                              '02',
                              style: homePageS1,
                            ),
                          ],
                        ),
                      ),
                    ),
                    Expanded(
                      child: Center(
                        child: Text(
                          staff.name,
                          style: homePageS1,
                        ),
                      ),
                    ),
                    Expanded(
                      child: Container(
                        padding: EdgeInsets.symmetric(horizontal: 20),
                        child: Text(
                          startTime,
                          style: homePageS1,
                          textAlign: TextAlign.right,
                        ),
                      ),
                    ),
                  ],
                ),
              ),
              Flexible(
                child: Row(
                  children: <Widget>[
                    Expanded(
                      flex: 3,
                      child: Container(
                        padding: EdgeInsets.fromLTRB(20, 8, 8, 8),
                        color: Colors.grey,
                        child: Column(
                          children: <Widget>[
                            Container(
                              child: Container(
                                child: Text(
                                  'Table assigned',
                                  style: homePageS1,
                                ),
                              ),
                            ),
                            Expanded(
                              child: ListView.builder(
                                  itemCount: allottedTables.length,
                                  itemBuilder: (context, index) {
                                    return Container(
                                      padding: EdgeInsets.all(8),
                                      child: Text(
                                        'Table : ${allottedTables[index]}',
                                        style: homePageS2,
                                      ),
                                    );
                                  }),
                            )
                          ],
                        ),
                      ),
                    ),
                    Expanded(
                      flex: 4,
                      child: Container(
                        margin: EdgeInsets.symmetric(horizontal: 2),
                        padding: EdgeInsets.all(8),
                        color: Colors.grey,
                        child: Column(
                          children: <Widget>[
                            Container(
                              child: Text(
                                'Assistance',
                                style: homePageS1,
                              ),
                            ),
                            Container(
                              child: Row(
                                children: <Widget>[
                                  Expanded(
                                    child: Center(
                                      child: Text(
                                        'Type',
                                        style: homePageS1,
                                      ),
                                    ),
                                  ),
                                  Expanded(
                                    child: Center(
                                      child: Text(
                                        'Time',
                                        style: homePageS1,
                                      ),
                                    ),
                                  ),
                                  Expanded(
                                    child: Center(
                                      child: Text(
                                        'Status',
                                        style: homePageS1,
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                            ),
                            Expanded(
                              child: ListView.builder(
                                itemCount: personAssistanceReq.length,
                                shrinkWrap: true,
                                itemBuilder: (context, index) {
                                  return Container(
                                    margin: EdgeInsets.symmetric(vertical: 12),
                                    child: Row(
                                      children: <Widget>[
                                        Expanded(
                                          child: Center(
                                            child: Text(
                                              personAssistanceReq[index]
                                                  .assistanceType,
                                              style: homePageS2,
                                            ),
                                          ),
                                        ),
                                        Expanded(
                                          child: Center(
                                            child: Text(
                                              '${formatDate(
                                                    (personAssistanceReq[index]
                                                        .timeStamp),
                                                    [HH, ':', nn],
                                                  )}' ??
                                                  " ",
                                              style: homePageS2,
                                            ),
                                          ),
                                        ),
                                        Expanded(
                                          child: Center(
                                            child: Text(
                                              personAssistanceReq[index]
                                                  .acceptedBy,
                                              style: homePageS2,
                                            ),
                                          ),
                                        ),
                                      ],
                                    ),
                                  );
                                },
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                    Expanded(
                      flex: 3,
                      child: Container(
                        padding: EdgeInsets.fromLTRB(20, 8, 8, 8),
                        color: Colors.grey,
                        child: Column(
                          children: <Widget>[
                            Container(
                              child: Text(
                                'stats',
                                style: homePageS1,
                              ),
                            ),
                            Expanded(
                              child: PieChart(
                                PieChartData(
                                  borderData: FlBorderData(show: false),
                                  centerSpaceRadius: 50,
                                  sections: <PieChartSectionData>[
                                    PieChartSectionData(
                                      color: Colors.redAccent,
                                      value: 40,
                                      title: 'Rejected',
                                      radius: 100,
                                      titleStyle: TextStyle(
                                          fontSize: 24,
                                          fontWeight: FontWeight.bold,
                                          color: const Color(0xffffffff)),
                                    ),
                                    PieChartSectionData(
                                      color: Colors.green,
                                      value: 40,
                                      title: 'Accepted',
                                      radius: 100,
                                      titleStyle: TextStyle(
                                          fontSize: 24,
                                          fontWeight: FontWeight.bold,
                                          color: Color(0xffffffff)),
                                    ),
                                  ],
                                ),
                              ),
                            )
                          ],
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

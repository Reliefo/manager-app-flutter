import 'package:adhara_socket_io_example/constants.dart';
import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';

class SinglePerson extends StatelessWidget {
  final personName = 'Rama Krishna';
  final startTime = '4:20 PM';
  final assistanceType = 'water';
  final assistanceRequestTime = '4:40';
  final assistanceStatus = 'Pending';
  final orderItem = 'Tandoori chicken';
  final itemQty = '01';
  final itemPrice = '349';
  final itemEta = '20';
  final itemStatus = 'Pending';
  @override
  Widget build(BuildContext context) {
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
                          personName,
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
                                  itemCount: 4,
                                  itemBuilder: (context, index) {
                                    return Container(
                                      padding: EdgeInsets.all(8),
                                      child: Text(
                                        'Table : no $index',
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
                                itemCount: 10,
                                shrinkWrap: true,
                                itemBuilder: (context, index) {
                                  return Container(
                                    margin: EdgeInsets.symmetric(vertical: 12),
                                    child: Row(
                                      children: <Widget>[
                                        Expanded(
                                          child: Center(
                                            child: Text(
                                              assistanceType,
                                              style: homePageS2,
                                            ),
                                          ),
                                        ),
                                        Expanded(
                                          child: Center(
                                            child: Text(
                                              assistanceRequestTime,
                                              style: homePageS2,
                                            ),
                                          ),
                                        ),
                                        Expanded(
                                          child: Center(
                                            child: Text(
                                              assistanceStatus,
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
                                      value: 4,
                                      title: 'Rejected',
                                      radius: 100,
                                      titleStyle: TextStyle(
                                          fontSize: 24,
                                          fontWeight: FontWeight.bold,
                                          color: const Color(0xffffffff)),
                                    ),
                                    PieChartSectionData(
                                      color: Colors.green,
                                      value: 8,
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

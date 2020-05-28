import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';
import 'package:manager_app/Home/assistanceReqBuilder.dart';
import 'package:manager_app/constants.dart';
import 'package:manager_app/data.dart';
import 'package:manager_app/fetchData/configureRestaurantData.dart';
import 'package:provider/provider.dart';

class SinglePerson extends StatelessWidget {
  final Staff staff;

  final List<AssistanceRequest> personRequest = [];
  final List<StaffOrderHistory> personOrders = [];
  final List<String> allottedTables = [];

  SinglePerson({
    this.staff,
  });

  final startTime = '4:20 PM';

  getPersonRequest(restaurantData) {
    if (restaurantData.restaurant.assistanceRequests != null) {
      restaurantData.restaurant.assistanceRequests.forEach((request) {
        if (request.acceptedBy == staff.name) {
          personRequest.add(request);
        }
      });
    }

    if (restaurantData.restaurant.staff != null) {
      restaurantData.restaurant.staff.forEach((restStaff) {
        if (restStaff.oid == staff.oid) {
          if (restStaff.orderHistory != null) {
            restStaff.orderHistory.forEach((order) {
              personOrders.add(order);
            });
          }
        }
      });
    }
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

    getPersonRequest(restaurantData);
    getAllottedTables(restaurantData);
    return SafeArea(
      child: Scaffold(
        body: Container(
          child: Column(
            children: <Widget>[
              Container(
                height: 60,
                color: kThemeColor,
                width: double.maxFinite,
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
                        color: Colors.grey[50],
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
                    VerticalDivider(),
                    Expanded(
                      flex: 4,
                      child: Container(
                        margin: EdgeInsets.symmetric(horizontal: 2),
                        padding: EdgeInsets.all(8),
                        color: Colors.grey[50],
                        child: Column(
                          children: <Widget>[
                            Container(
                              child: Text(
                                'Assistance',
                                style: homePageS1,
                              ),
                            ),
                            Expanded(
                              child: AssistanceRequestBuilder(
                                requestList: personRequest,
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                    VerticalDivider(),
                    Expanded(
                      flex: 3,
                      child: Container(
                        padding: EdgeInsets.fromLTRB(20, 8, 8, 8),
                        color: Colors.grey[50],
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

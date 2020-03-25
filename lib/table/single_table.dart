import 'package:adhara_socket_io_example/constants.dart';
import 'package:flutter/material.dart';

class SingleTable extends StatelessWidget {
  final tableNo = '03';
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
                            Icon(
                              Icons.account_box,
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
                          'TABLE : $tableNo',
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
                      flex: 2,
                      child: Container(
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
                        margin: EdgeInsets.only(left: 2),
                        padding: EdgeInsets.fromLTRB(20, 8, 8, 8),
                        color: Colors.grey,
                        child: Column(
                          children: <Widget>[
//                            Container(
//                              child: Text(
//                                'Assistance',
//                                style: homePageS1,
//                              ),
//                            ),
                            Container(
                              child: Row(
                                children: <Widget>[
                                  Expanded(
                                    flex: 2,
                                    child: Text(
                                      'ITEM',
                                      style: homePageS1,
                                    ),
                                  ),
                                  Expanded(
                                    child: Center(
                                      child: Text(
                                        'QTY',
                                        style: homePageS1,
                                      ),
                                    ),
                                  ),
                                  Expanded(
                                    child: Center(
                                      child: Text(
                                        'PRICE',
                                        style: homePageS1,
                                      ),
                                    ),
                                  ),
                                  Expanded(
                                    child: Center(
                                      child: Text(
                                        'ETA',
                                        style: homePageS1,
                                      ),
                                    ),
                                  ),
                                  Expanded(
                                    child: Center(
                                      child: Text(
                                        'STATUS',
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
                                          flex: 2,
                                          child: Text(
                                            orderItem,
                                            style: homePageS2,
                                          ),
                                        ),
                                        Expanded(
                                          child: Center(
                                            child: Text(
                                              itemQty,
                                              style: homePageS2,
                                            ),
                                          ),
                                        ),
                                        Expanded(
                                          child: Center(
                                            child: Text(
                                              itemPrice,
                                              style: homePageS2,
                                            ),
                                          ),
                                        ),
                                        Expanded(
                                          child: Center(
                                            child: Text(
                                              itemEta,
                                              style: homePageS2,
                                            ),
                                          ),
                                        ),
                                        Expanded(
                                          child: Center(
                                            child: Text(
                                              itemStatus,
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

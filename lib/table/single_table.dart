import 'package:adhara_socket_io_example/constants.dart';
import 'package:adhara_socket_io_example/data.dart';
import 'package:date_format/date_format.dart';
import 'package:flutter/material.dart';

class SingleTable extends StatelessWidget {
  final List<AssistanceRequest> assistanceReq;
  final List<TableOrder> queueOrders;
  final List<TableOrder> cookingOrders;
  final List<AssistanceRequest> tableAssistanceReq = [];
  final List<TableOrder> tableOrders = [];
  final tableNo;
  SingleTable(
      {@required this.assistanceReq,
      @required this.queueOrders,
      @required this.cookingOrders,
      this.tableNo});

  getTableAssistanceReq() {
    for (var i = 0; i < assistanceReq.length; ++i) {
      if (tableNo.toString() == assistanceReq[i].table) {
        tableAssistanceReq.add(assistanceReq[i]);
      }
    }
  }

  getTableOrders() {
    for (var i = 0; i < cookingOrders.length; ++i) {
      if (tableNo.toString() == cookingOrders[i].table) {
        tableOrders.add(cookingOrders[i]);
      }
    }
    for (var i = 0; i < queueOrders.length; ++i) {
      if (tableNo.toString() == queueOrders[i].table) {
        tableOrders.add(queueOrders[i]);
      }
    }
  }

  final startTime = '4:20 PM';

  final assistanceStatus = 'Pending';
  final orderItem = 'Tandoori chicken';
  final itemQty = '01';
  final itemPrice = '349';
  final itemEta = '20';
  final itemStatus = 'Pending';
  @override
  Widget build(BuildContext context) {
    getTableAssistanceReq();
    getTableOrders();
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
                          'TABLE : $tableNo' ?? " ",
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

                            //to check if there is any assistance request for this table or not
                            tableAssistanceReq.length > 0
                                ? Expanded(
                                    child: ListView.builder(
                                      itemCount: tableAssistanceReq.length,
                                      shrinkWrap: true,
                                      itemBuilder: (context, index) {
                                        return Container(
                                          margin: EdgeInsets.symmetric(
                                              vertical: 12),
                                          child: Row(
                                            children: <Widget>[
                                              Expanded(
                                                child: Center(
                                                  child: Text(
                                                    tableAssistanceReq[index]
                                                            .assistanceType ??
                                                        " ",
                                                    style: homePageS2,
                                                  ),
                                                ),
                                              ),
                                              Expanded(
                                                child: Center(
                                                  child: Text(
                                                    '${formatDate(
                                                          (tableAssistanceReq[
                                                                  index]
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
                                                    tableAssistanceReq[index]
                                                            .acceptedBy ??
                                                        "Pending",
                                                    style: homePageS2,
                                                  ),
                                                ),
                                              ),
                                            ],
                                          ),
                                        );
                                      },
                                    ),
                                  )
                                //if there is no assistance request for this table
                                : Expanded(
                                    child: Text('no assistance requests'),
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
                            Container(
                              child: Text(
                                'Orders',
                                style: homePageS1,
                              ),
                            ),
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
                            //to check if there is any orders for this table or not
                            tableOrders.length > 0
                                ? Expanded(
                                    child: ListView.builder(
                                        shrinkWrap: true,
                                        itemCount: tableOrders.length,
                                        itemBuilder: (context, index) {
                                          return ListView.builder(
                                              primary: false,
                                              shrinkWrap: true,
                                              itemCount: tableOrders[index]
                                                  .orders
                                                  .length,
                                              itemBuilder: (context, index2) {
                                                return ListView.builder(
                                                  itemCount: tableOrders[index]
                                                      .orders[index2]
                                                      .foodlist
                                                      .length,
                                                  primary: false,
                                                  shrinkWrap: true,
                                                  itemBuilder:
                                                      (context, index3) {
                                                    return Container(
                                                      margin:
                                                          EdgeInsets.symmetric(
                                                              vertical: 12),
                                                      child: Row(
                                                        children: <Widget>[
                                                          Expanded(
                                                            flex: 2,
                                                            child: Text(
                                                              tableOrders[index]
                                                                      .orders[
                                                                          index2]
                                                                      .foodlist[
                                                                          index3]
                                                                      .name ??
                                                                  " ",
                                                              style: homePageS2,
                                                            ),
                                                          ),
                                                          Expanded(
                                                            child: Center(
                                                              child: Text(
                                                                '${tableOrders[index].orders[index2].foodlist[index3].quantity}' ??
                                                                    " ",
                                                                style:
                                                                    homePageS2,
                                                              ),
                                                            ),
                                                          ),
                                                          Expanded(
                                                            child: Center(
                                                              child: Text(
                                                                tableOrders[index]
                                                                        .orders[
                                                                            index2]
                                                                        .foodlist[
                                                                            index3]
                                                                        .price ??
                                                                    " ",
                                                                style:
                                                                    homePageS2,
                                                              ),
                                                            ),
                                                          ),
                                                          Expanded(
                                                            child: Center(
                                                              child: Text(
                                                                '${formatDate(
                                                                      (tableOrders[
                                                                              index]
                                                                          .timeStamp),
                                                                      [
                                                                        HH,
                                                                        ':',
                                                                        nn
                                                                      ],
                                                                    )}' ??
                                                                    " ",
                                                                style:
                                                                    homePageS2,
                                                              ),
                                                            ),
                                                          ),
                                                          Expanded(
                                                            child: Center(
                                                              child: Text(
                                                                tableOrders[index]
                                                                        .orders[
                                                                            index2]
                                                                        .foodlist[
                                                                            index3]
                                                                        .status ??
                                                                    " ",
                                                                style:
                                                                    homePageS2,
                                                              ),
                                                            ),
                                                          ),
                                                        ],
                                                      ),
                                                    );
                                                  },
                                                );
                                              });
                                        }),
                                  )
                                //if there is no orders for this table
                                : Expanded(
                                    child: Container(
                                      width: double.maxFinite,
                                      child: Column(
                                        children: <Widget>[
                                          Expanded(
                                            child: Padding(
                                              padding:
                                                  const EdgeInsets.all(20.0),
                                              child: Image.asset(
                                                'assets/icons/plate.png',
                                              ),
                                            ),
                                          ),
                                          Expanded(
                                            child: Center(
                                              child: Text(
                                                'No Orders Yet',
                                                style: homePageS4,
                                              ),
                                            ),
                                          ),
                                        ],
                                      ),
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

import 'package:date_format/date_format.dart';
import 'package:flutter/material.dart';
import 'package:manager_app/Home/assistanceReqBuilder.dart';
import 'package:manager_app/constants.dart';
import 'package:manager_app/data.dart';
import 'package:manager_app/fetchData/configureRestaurantData.dart';
import 'package:manager_app/fetchData/fetchOrderData.dart';
import 'package:provider/provider.dart';

class SingleTable extends StatelessWidget {
  final List<AssistanceRequest> tableAssistanceReq = [];
  final List<TableOrder> tableOrders = [];
  final List<TableOrder> tableCompletedOrders = [];

  final Tables table;
  final bill;
  SingleTable({
    this.table,
    this.bill,
  });

  getTableAssistanceReq(assistanceList) {
    if (assistanceList != null) {
      assistanceList.forEach((request) {
        if (request.table == table.name) {
          tableAssistanceReq.add(request);
        }
      });
    }
  }

  getTableOrders(orderData) {
    orderData.queueOrders.forEach((orders) {
      if (orders.table == table.name) {
        tableOrders.add(orders);
      }
    });

    orderData.cookingOrders.forEach((orders) {
      if (orders.table == table.name) {
        tableOrders.add(orders);
      }
    });

    orderData.completedOrders.forEach((orders) {
      if (orders.table == table.name) {
        tableCompletedOrders.add(orders);
      }
    });
  }

  requestBilling(context) {
    if (tableOrders.length == 0) {
      bill({"table_id": table.oid});
    } else if (tableOrders.length != 0) {
      showDialog(
        context: context,
        builder: (BuildContext context) {
          // return object of type Dialog
          return AlertDialog(
            title: Text("Order is not Completed"),
            content: Text("Try to bill after order is completed"),
            actions: <Widget>[
//              FlatButton(
//                child: new Text("Delete"),
//                onPressed: () {
//                  restaurantData.sendConfiguredDataToBackend(
//                      restaurantData.restaurant.barMenu[index].oid,
//                      "delete_bar_category");
//
//                  Navigator.of(context).pop();
//                },
//              ),
              // usually buttons at the bottom of the dialog
              FlatButton(
                child: Text("Back"),
                onPressed: () {
                  Navigator.of(context).pop();
                },
              ),
            ],
          );
        },
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    final OrderData orderData = Provider.of<OrderData>(context);
    final RestaurantData restaurantData = Provider.of<RestaurantData>(context);
    getTableAssistanceReq(restaurantData.restaurant.assistanceRequests);
    getTableOrders(orderData);

//    print(orderData.cookingOrders[1].table);
    return SafeArea(
      child: Scaffold(
        body: Container(
          child: Column(
            children: <Widget>[
              Container(
                color: kThemeColor,
                height: 60,
                width: double.maxFinite,
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
                          'TABLE : ${table.name}' ?? " ",
                          style: homePageS1,
                        ),
                      ),
                    ),
                    Expanded(
                      child: Container(
                          padding: EdgeInsets.symmetric(horizontal: 20),
                          child: RaisedButton(
                            onPressed: () {
                              requestBilling(context);
                            },
                            child: Text(
                              "Bill",
                              style: homePageS1,
                              textAlign: TextAlign.right,
                            ),
                          )),
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
                        child: Column(
                          children: <Widget>[
                            Container(
                              child: Text(
                                'Assistance',
                                style: homePageS1,
                              ),
                            ),
                            tableAssistanceReq.length > 0
                                ? Expanded(
                                    child: AssistanceRequestBuilder(
                                      requestList: tableAssistanceReq,
                                    ),
                                  )
                                //if there is no assistance request for this table
                                : Text('no assistance requests'),
                          ],
                        ),
                      ),
                    ),
                    VerticalDivider(),
                    Expanded(
                      flex: 3,
                      child: Container(
                        margin: EdgeInsets.only(left: 2),
                        padding: EdgeInsets.fromLTRB(20, 8, 8, 8),
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
                            tableOrders != null
                                ? Expanded(
                                    child: SingleChildScrollView(
                                      child: Column(
                                        children: <Widget>[
                                          ListView.builder(
                                              primary: false,
                                              shrinkWrap: true,
                                              itemCount: tableOrders.length,
                                              itemBuilder: (context, index) {
                                                return ListView.builder(
                                                    primary: false,
                                                    shrinkWrap: true,
                                                    itemCount:
                                                        tableOrders[index]
                                                            .orders
                                                            .length,
                                                    itemBuilder:
                                                        (context, index2) {
                                                      return ListView.builder(
                                                        itemCount:
                                                            tableOrders[index]
                                                                .orders[index2]
                                                                .foodList
                                                                .length,
                                                        primary: false,
                                                        shrinkWrap: true,
                                                        itemBuilder:
                                                            (context, index3) {
                                                          return Container(
                                                            margin: EdgeInsets
                                                                .symmetric(
                                                                    vertical:
                                                                        12),
                                                            child: Row(
                                                              children: <
                                                                  Widget>[
                                                                Expanded(
                                                                  flex: 2,
                                                                  child: Text(
                                                                    tableOrders[index]
                                                                            .orders[index2]
                                                                            .foodList[index3]
                                                                            .name ??
                                                                        " ",
                                                                    style:
                                                                        homePageS2,
                                                                  ),
                                                                ),
                                                                Expanded(
                                                                  child: Center(
                                                                    child: Text(
                                                                      '${tableOrders[index].orders[index2].foodList[index3].quantity}' ??
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
                                                                              .orders[index2]
                                                                              .foodList[index3]
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
                                                                            (tableOrders[index].timeStamp),
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
                                                                              .orders[index2]
                                                                              .foodList[index3]
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
                                          ListView.builder(
                                              primary: false,
                                              shrinkWrap: true,
                                              itemCount:
                                                  tableCompletedOrders.length,
                                              itemBuilder: (context, index) {
                                                return ListView.builder(
                                                    primary: false,
                                                    shrinkWrap: true,
                                                    itemCount:
                                                        tableCompletedOrders[
                                                                index]
                                                            .orders
                                                            .length,
                                                    itemBuilder:
                                                        (context, index2) {
                                                      return ListView.builder(
                                                        itemCount:
                                                            tableCompletedOrders[
                                                                    index]
                                                                .orders[index2]
                                                                .foodList
                                                                .length,
                                                        primary: false,
                                                        shrinkWrap: true,
                                                        itemBuilder:
                                                            (context, index3) {
                                                          return Container(
                                                            margin: EdgeInsets
                                                                .symmetric(
                                                                    vertical:
                                                                        12),
                                                            child: Row(
                                                              children: <
                                                                  Widget>[
                                                                Expanded(
                                                                  flex: 2,
                                                                  child: Text(
                                                                    tableCompletedOrders[index]
                                                                            .orders[index2]
                                                                            .foodList[index3]
                                                                            .name ??
                                                                        " ",
                                                                    style:
                                                                        homePageS2,
                                                                  ),
                                                                ),
                                                                Expanded(
                                                                  child: Center(
                                                                    child: Text(
                                                                      '${tableCompletedOrders[index].orders[index2].foodList[index3].quantity}' ??
                                                                          " ",
                                                                      style:
                                                                          homePageS2,
                                                                    ),
                                                                  ),
                                                                ),
                                                                Expanded(
                                                                  child: Center(
                                                                    child: Text(
                                                                      tableCompletedOrders[index]
                                                                              .orders[index2]
                                                                              .foodList[index3]
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
                                                                            (tableCompletedOrders[index].timeStamp),
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
                                                                      tableCompletedOrders[index]
                                                                              .orders[index2]
                                                                              .foodList[index3]
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
                                        ],
                                      ),
                                    ),
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

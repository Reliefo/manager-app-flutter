import 'package:date_format/date_format.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:manager_app/Home/assistanceReqBuilder.dart';
import 'package:manager_app/Home/orderItemBuilder.dart';
import 'package:manager_app/constants.dart';
import 'package:manager_app/data.dart';
import 'package:manager_app/fetchData/configureRestaurantData.dart';
import 'package:provider/provider.dart';

class OrderHistoryPage extends StatefulWidget {
  @override
  _OrderHistoryPageState createState() => _OrderHistoryPageState();
}

class _OrderHistoryPageState extends State<OrderHistoryPage> {
  int _selectedIndex;

  RestaurantOrderHistory selectedOrder;

  _onSelected(int index, restaurantData) {
    setState(() {
      _selectedIndex = index;

      selectedOrder = restaurantData.restaurant.orderHistory[index];
    });
  }

  @override
  Widget build(BuildContext context) {
    final RestaurantData restaurantData = Provider.of<RestaurantData>(context);
    return SafeArea(
      child: Scaffold(
        body: Container(
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              Expanded(
                flex: 2,
                child: Container(
                    color: Colors.amber[100],
                    child: Column(
                      children: <Widget>[
                        Container(
                          child: Text(
                            "Order headers",
                            style: kHeaderStyleSmall,
                          ),
                        ),
                        ListView.builder(
                          reverse: true,
                          shrinkWrap: true,
                          itemCount: restaurantData.restaurant.orderHistory !=
                                  null
                              ? restaurantData.restaurant.orderHistory.length
                              : 0,
                          itemBuilder: (context, index) {
                            return Container(
                              color: _selectedIndex != null &&
                                      _selectedIndex == index
                                  ? Colors.black12
                                  : Colors.transparent,
                              child: ListTile(
                                title: Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceAround,
                                  children: <Widget>[
                                    Text(
                                        "Sl.No ${restaurantData.restaurant.orderHistory.length - index}"),
                                    Text(restaurantData
                                        .restaurant.orderHistory[index].table),
                                    Text(
                                      formatDate(
                                            (restaurantData.restaurant
                                                .orderHistory[index].timeStamp),
                                            [HH, ':', nn],
                                          ) ??
                                          " ",
                                    ),
                                  ],
                                ),
                                onTap: () {
                                  _onSelected(index, restaurantData);
                                },
                              ),
                            );
                          },
                        ),
                      ],
                    )),
              ),
              Expanded(
                flex: 3,
                child: selectedOrder != null
                    ? Container(
                        child: Row(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: <Widget>[
                            Expanded(
                              child: SingleChildScrollView(
                                child: Column(
                                  children: <Widget>[
                                    OrderItemBuilder(
                                        orderList: selectedOrder.personalOrder),
                                    OrderItemBuilder(
                                        orderList: selectedOrder.tableOrder),
                                  ],
                                ),
                              ),
                            ),
                            Expanded(
                              child: SingleChildScrollView(
                                child: Column(
                                  children: <Widget>[
                                    Container(
                                      child: ListView.builder(
                                        itemCount: selectedOrder.users.length,
                                        shrinkWrap: true,
                                        itemBuilder: (context, index) {
                                          return Container(
                                            padding: EdgeInsets.all(8),
                                            child: Text(
                                              selectedOrder.users[index]
                                                  ["name"],
                                              style: kTitleStyle,
                                            ),
                                          );
                                        },
                                      ),
                                    ),
                                    Container(
                                      child: AssistanceRequestBuilder(
                                        requestList:
                                            selectedOrder.assistanceReq,
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            ),
                          ],
                        ),
                      )
                    : Center(
                        child: Text(
                          "select the order.! \n  To view details ",
                          style: kHeaderStyleSmall,
                        ),
                      ),
              )
            ],
          ),
        ),
      ),
    );
  }
}

import 'package:date_format/date_format.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter_plugin_pdf_viewer/flutter_plugin_pdf_viewer.dart';
import 'package:manager_app/constants.dart';
import 'package:manager_app/data.dart';
import 'package:manager_app/fetchData/configureRestaurantData.dart';
import 'package:provider/provider.dart';

class OrderHistoryPage extends StatefulWidget {
  @override
  _OrderHistoryPageState createState() => _OrderHistoryPageState();
}

class _OrderHistoryPageState extends State<OrderHistoryPage> {
  PDFDocument doc;

  bool _isLoading = true;
  int _selectedIndex;
  RestaurantOrderHistory selectedOrder;

  _onSelected(int index, restaurantData) {
    setState(() {
      _selectedIndex = index;

      selectedOrder = restaurantData.restaurant.orderHistory[index];
    });
  }

  void loadFromUrl() async {
    setState(() {
      _isLoading = true;
    });
    doc = await PDFDocument.fromURL(
        'https://liqr-restaurants.s3.ap-south-1.amazonaws.com/BNGKOR001/bills/5ed0a0f1f466d5287c8c9e15.pdf');
    setState(() {
      _isLoading = false;
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
                child: restaurantData.restaurant.orderHistory != null
                    ? Container(
                        color: Colors.amber[100],
                        child: Column(
                          children: <Widget>[
                            Container(
                              child: Text(
                                "Orders",
                                style: kHeaderStyleSmall,
                              ),
                            ),
                            Expanded(
                              child: Scrollbar(
                                child: SingleChildScrollView(
                                  child: ListView.builder(
                                    reverse: true,
                                    shrinkWrap: true,
                                    primary: false,
                                    itemCount: restaurantData
                                                .restaurant.orderHistory !=
                                            null
                                        ? restaurantData
                                            .restaurant.orderHistory.length
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
                                                MainAxisAlignment.spaceEvenly,
                                            children: <Widget>[
                                              Expanded(
                                                child: Text(
                                                  "Sl.No ${restaurantData.restaurant.orderHistory.length - index}",
                                                  textAlign: TextAlign.left,
                                                ),
                                              ),
                                              Expanded(
                                                child: Text(
                                                  restaurantData
                                                      .restaurant
                                                      .orderHistory[index]
                                                      .table,
                                                  textAlign: TextAlign.left,
                                                ),
                                              ),
                                              Expanded(
                                                child: Text(
                                                  formatDate(
                                                        (restaurantData
                                                            .restaurant
                                                            .orderHistory[index]
                                                            .timeStamp),
                                                        [HH, ':', nn],
                                                      ) ??
                                                      " ",
                                                  textAlign: TextAlign.left,
                                                ),
                                              ),
                                              Expanded(
                                                child: Text(
                                                  "₹ ${restaurantData.restaurant.orderHistory[index].bill.totalAmount.toString()}",
                                                  textAlign: TextAlign.right,
                                                ),
                                              ),
                                            ],
                                          ),
                                          onTap: () {
                                            _onSelected(index, restaurantData);
                                            loadFromUrl();
                                          },
                                        ),
                                      );
                                    },
                                  ),
                                ),
                              ),
                            ),
                          ],
                        ),
                      )
                    : Center(
                        child: Text(
                          "No Billed Order History",
                          style: kHeaderStyleSmall,
                        ),
                      ),
              ),
              Expanded(
                flex: 3,
                child: selectedOrder != null
                    ? PDFViewer(
                        showPicker: false,
                        document: doc,
                      )
                    : Center(
                        child: Text(
                          "Select the order\nTo view Bill Details ",
                          textAlign: TextAlign.center,
                          style: kHeaderStyleSmall,
                        ),
                      ),
              )
//              Expanded(
//                flex: 3,
//                child: selectedOrder != null
//                    ? Container(
//                        child: Row(
//                          crossAxisAlignment: CrossAxisAlignment.start,
//                          children: <Widget>[
//                            Expanded(
//                              child: SingleChildScrollView(
//                                child: Column(
//                                  children: <Widget>[
//                                    OrderItemBuilder(
//                                      reverseOrder: false,
//                                      orderList: selectedOrder.tableOrder,
//                                    ),
//                                  ],
//                                ),
//                              ),
//                            ),
//                            Expanded(
//                              child: SingleChildScrollView(
//                                child: Column(
//                                  children: <Widget>[
//                                    Container(
//                                      child: ListView.builder(
//                                        itemCount: selectedOrder.users.length,
//                                        shrinkWrap: true,
//                                        itemBuilder: (context, index) {
//                                          return Container(
//                                            padding: EdgeInsets.all(8),
//                                            child: Text(
//                                              selectedOrder.users[index]
//                                                  ["name"],
//                                              style: kTitleStyle,
//                                            ),
//                                          );
//                                        },
//                                      ),
//                                    ),
//                                    Container(
//                                      child: AssistanceRequestBuilder(
//                                        requestList:
//                                            selectedOrder.assistanceReq,
//                                      ),
//                                    ),
//                                  ],
//                                ),
//                              ),
//                            ),
//                          ],
//                        ),
//                      )
//                    : Center(
//                        child: Text(
//                          "select the order.! \n  To view details ",
//                          style: kHeaderStyleSmall,
//                        ),
//                      ),
//              )
            ],
          ),
        ),
      ),
    );
  }
}

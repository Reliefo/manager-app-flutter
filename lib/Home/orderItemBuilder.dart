import 'package:date_format/date_format.dart';
import 'package:flutter/material.dart';
import 'package:manager_app/constants.dart';
import 'package:manager_app/data.dart';

class OrderItemBuilder extends StatelessWidget {
  final List<TableOrder> orderList;
  final bool reverseOrder;

  OrderItemBuilder({
    @required this.orderList,
    @required this.reverseOrder,
  });
  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      reverse: reverseOrder,
      primary: false,
      shrinkWrap: true,
      itemCount: orderList.length,
      itemBuilder: (context, index) {
        return Container(
          decoration: BoxDecoration(
            color: kLightThemeColor,
            borderRadius: BorderRadius.all(
              Radius.circular(10.0),
            ),
          ),
          margin: EdgeInsets.all(12),
          padding: EdgeInsets.symmetric(horizontal: 8, vertical: 8),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: <Widget>[
                  Flexible(
                    child: Container(
                      padding: EdgeInsets.symmetric(horizontal: 8),
                      child: Text(
                        orderList[index].table ?? " ",
                        style: kHeaderStyleSmall,
                        textAlign: TextAlign.start,
                      ),
                    ),
                  ),
                  Flexible(
                    child: Container(
                      padding: EdgeInsets.symmetric(horizontal: 8),
                      child: Text(
//
                        formatDate(
                              (orderList[index].timeStamp),
                              [HH, ':', nn],
                            ) ??
                            " ",
                        style: kHeaderStyleSmall,
                        textAlign: TextAlign.end,
                      ),
                    ),
                  ),
                ],
              ),
              ListView.builder(
                reverse: reverseOrder,
                primary: false,
                itemCount: orderList[index].orders.length,
                shrinkWrap: true,
                itemBuilder: (context, index2) {
                  return Column(
                    children: <Widget>[
                      Container(
                        padding:
                            EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                        child: Row(
                          children: <Widget>[
                            Text(
                              orderList[index].orders[index2].placedBy['name'],
                              style: kTitleStyle,
                            ),
                            Text(
                              orderList[index].personalOrder == true
                                  ? " (Personal) "
                                  : "",
                              style: kSubTitleStyle,
                            ),
                          ],
                        ),
                      ),
                      ListView.builder(
                          reverse: reverseOrder,
                          primary: false,
                          shrinkWrap: true,
                          itemCount:
                              orderList[index].orders[index2].foodList.length,
                          itemBuilder: (context, index3) {
                            return Container(
                              decoration: BoxDecoration(
                                color: Color(0xffEFEEEF),
                                borderRadius: BorderRadius.all(
                                  Radius.circular(6.0),
                                ),
                              ),
                              margin: EdgeInsets.symmetric(vertical: 4),
                              padding: EdgeInsets.all(8),
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: <Widget>[
                                  Text(
                                    '${orderList[index].orders[index2].foodList[index3].name} x ${orderList[index].orders[index2].foodList[index3].quantity}' ??
                                        " ",
                                    style: kTitleStyle,
                                  ),
                                  orderList[index]
                                              .orders[index2]
                                              .foodList[index3]
                                              .foodOption !=
                                          null
                                      ? ListView.builder(
                                          shrinkWrap: true,
                                          primary: false,
                                          itemCount: orderList[index]
                                              .orders[index2]
                                              .foodList[index3]
                                              .foodOption
                                              .options
                                              .length,
                                          itemBuilder: (context, index4) {
                                            return Text(
                                              '${orderList[index].orders[index2].foodList[index3].foodOption.options[index4]['option_name']}' ??
                                                  " ",
                                            );
                                          },
                                        )
                                      : Container(width: 0, height: 0),
                                  orderList[index]
                                              .orders[index2]
                                              .foodList[index3]
                                              .foodOption !=
                                          null
                                      ? ListView.builder(
                                          shrinkWrap: true,
                                          primary: false,
                                          itemCount: orderList[index]
                                              .orders[index2]
                                              .foodList[index3]
                                              .foodOption
                                              .choices
                                              .length,
                                          itemBuilder: (context, index4) {
                                            return Text(
                                              '${orderList[index].orders[index2].foodList[index3].foodOption.choices[index4]}' ??
                                                  " ",
                                            );
                                          },
                                        )
                                      : Container(width: 0, height: 0),
                                  orderList[index]
                                              .orders[index2]
                                              .foodList[index3]
                                              .instructions ==
                                          null
                                      ? Container(width: 0, height: 0)
                                      : Text(
                                          orderList[index]
                                                  .orders[index2]
                                                  .foodList[index3]
                                                  .instructions ??
                                              " ",
                                          style: kSubTitleStyle,
                                        ),
                                ],
                              ),
                            );
                          }),
                    ],
                  );
                },
              ),
            ],
          ),
        );
      },
    );
  }
}

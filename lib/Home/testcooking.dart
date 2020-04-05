import 'package:adhara_socket_io_example/constants.dart';
import 'package:flutter/material.dart';

class TestCooking extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(8),
      color: Colors.blueGrey,
      child: Column(
        children: <Widget>[
          Container(
            child: Text(
              'Cooking',
              style: homePageS4,
            ),
          ),

          //to check if there is orders in queue or not
//          cookingOrders.length > 0
//              ?
          Expanded(
            child: Container(
              width: double.maxFinite,
              child: ListView.builder(
                primary: false,
                shrinkWrap: true,
                itemCount: 3,
                itemBuilder: (context, index) {
                  return Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: <Widget>[
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: <Widget>[
                          Container(
                            padding: EdgeInsets.symmetric(
                                vertical: 8, horizontal: 12),
                            child: Text(
                              'Table : $index',
                              style: homePageS1,
                            ),
                          ),
                          Container(
                            padding: EdgeInsets.symmetric(
                                vertical: 2, horizontal: 12),
                            child: Text(
//
                              'Arrival Time 2:40',
                              style: homePageS3,
                            ),
                          ),
                        ],
                      ),
                      ListView.builder(
                        primary: false,
                        itemCount: 4,
                        shrinkWrap: true,
                        itemBuilder: (context, index2) {
                          return ListView.builder(
                              primary: false,
                              shrinkWrap: true,
                              itemCount: 4,
                              itemBuilder: (context, index3) {
                                return Container(
                                    padding: EdgeInsets.symmetric(
                                        vertical: 8, horizontal: 12),
                                    child: Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: <Widget>[
                                        Text(
                                          "somthing ",
//
                                          style: homePageS3,
                                        ),
                                      ],
                                    ));
                              });
                        },
                      ),
                      Divider(
                        thickness: 2,
                      ),
                    ],
                  );
                },
              ),
            ),
          )

          // display when there in nothing in the queue
//              : Expanded(
//            child: Container(
//              child: Column(
//                children: <Widget>[
//                  Expanded(
//                    child: Padding(
//                      padding: const EdgeInsets.all(20.0),
//                      child: Image.asset(
//                        'assets/icons/plate.png',
//                      ),
//                    ),
//                  ),
//                  Expanded(
//                    child: Center(
//                      child: Text(
//                        'No Orders Yet',
//                        style: homePageS4,
//                      ),
//                    ),
//                  ),
//                ],
//              ),
//            ),
//          ),
        ],
      ),
    );
  }
}

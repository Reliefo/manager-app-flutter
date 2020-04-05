import 'package:adhara_socket_io_example/constants.dart';
import 'package:adhara_socket_io_example/data.dart';
import 'package:date_format/date_format.dart';
import 'package:flutter/material.dart';

class Assistance extends StatelessWidget {
  final List<AssistanceRequest> assistanceReq;
  Assistance({@required this.assistanceReq});
  @override
  Widget build(BuildContext context) {
    return Container(
      color: Colors.blueGrey,
      child: Column(
        children: <Widget>[
          Container(
            color: Colors.black26,
            width: double.maxFinite,
            child: Center(
              child: Text(
                'Assistance',
                style: homePageS4,
              ),
            ),
          ),
          Container(
            padding: EdgeInsets.symmetric(vertical: 8),
            child: Row(
              children: <Widget>[
                Expanded(
                  child: Container(
                    padding: EdgeInsets.only(left: 20),
                    child: Text(
                      'Table',
                      style: homePageS1,
                    ),
                  ),
                ),
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

          //Todo: change it to actual data length
          assistanceReq.length > 0
              ? Expanded(
                  child: ListView.builder(
                    itemCount: assistanceReq.length,
                    shrinkWrap: true,
                    itemBuilder: (context, index) {
                      return Container(
                        margin: EdgeInsets.symmetric(vertical: 12),
                        child: Row(
                          children: <Widget>[
                            Expanded(
                              child: Container(
                                padding: EdgeInsets.only(left: 20),
                                child: Text(
                                  'Table : ${assistanceReq[index].table}' ??
                                      " ",
                                  style: homePageS2,
                                  textAlign: TextAlign.left,
                                ),
                              ),
                            ),
                            Expanded(
                              child: Center(
                                child: Text(
                                  assistanceReq[index].assistanceType ?? " ",
                                  style: homePageS2,
                                ),
                              ),
                            ),
                            Expanded(
                              child: Center(
                                child: Text(
                                  '${formatDate(
                                        (assistanceReq[index].timeStamp),
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
                                  assistanceReq[index].acceptedBy ?? "Pending",
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

              //todo: change it when you receive data
              : Expanded(
                  child: Text('say there is nothing'),
                ),
        ],
      ),
    );
  }
}

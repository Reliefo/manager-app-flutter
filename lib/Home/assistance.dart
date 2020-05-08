import 'package:adhara_socket_io_example/constants.dart';
import 'package:adhara_socket_io_example/fetchData/fetchAssistanceData.dart';
import 'package:date_format/date_format.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class Assistance extends StatelessWidget {
//  final List<AssistanceRequest> assistanceReq;
//  Assistance({@required this.assistanceReq});
  @override
  Widget build(BuildContext context) {
    final AssistanceData assistanceData = Provider.of<AssistanceData>(context);
    return Container(
//      color: Color(0xffDAE2EF),
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

          Container(
            decoration: BoxDecoration(
              color: Color(0xffECF3F9),

              borderRadius: BorderRadius.all(
                  Radius.circular(15.0)), // set rounded corner radius
            ),
            padding: EdgeInsets.symmetric(horizontal: 18.0, vertical: 14),
            margin: EdgeInsets.symmetric(horizontal: 18.0, vertical: 2),
            child: Column(
              children: <Widget>[
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: <Widget>[
                    Text("Table 12", style: homePageS2),
                    Text("2:30", style: homePageS2),
                  ],
                ),
                SizedBox(height: 8),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: <Widget>[
                    Text("Assistance : Water"),
                    Text("Accepted by Suresh"),
                  ],
                ),
              ],
            ),
          ),

          //Todo: change it to actual data length
          assistanceData.assistanceReq.length > 0
              ? Expanded(
                  child: ListView.builder(
                    itemCount: assistanceData.assistanceReq.length,
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
                                  'Table : ${assistanceData.assistanceReq[index].table}' ??
                                      " ",
                                  style: homePageS2,
                                  textAlign: TextAlign.left,
                                ),
                              ),
                            ),
                            Expanded(
                              child: Center(
                                child: Text(
                                  assistanceData.assistanceReq[index]
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
                                        (assistanceData
                                            .assistanceReq[index].timeStamp),
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
                                  assistanceData
                                          .assistanceReq[index].acceptedBy ??
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

              //todo: change it when you receive data
              : Expanded(
                  child: Text('say there is nothing'),
                ),
        ],
      ),
    );
  }
}

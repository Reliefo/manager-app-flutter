import 'package:date_format/date_format.dart';
import 'package:flutter/material.dart';
import 'package:manager_app/constants.dart';
import 'package:manager_app/data.dart';

class AssistanceRequestBuilder extends StatelessWidget {
  final List<AssistanceRequest> requestList;

  AssistanceRequestBuilder({
    this.requestList,
  });
  @override
  Widget build(BuildContext context) {
//    print("assistance");
//    print(requestList);
    return ListView.builder(
      itemCount: requestList.length,
      shrinkWrap: true,
      primary: false,
      itemBuilder: (context, index) {
        return Container(
          decoration: BoxDecoration(
            color: kLightThemeColor,

            borderRadius: BorderRadius.all(
                Radius.circular(15.0)), // set rounded corner radius
          ),
          padding: EdgeInsets.symmetric(horizontal: 18.0, vertical: 14),
          margin: EdgeInsets.symmetric(horizontal: 18.0, vertical: 4),
          child: Column(
            children: <Widget>[
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: <Widget>[
                  Text(
                    'Table : ${requestList[index].table}' ?? " ",
                    style: kTitleStyle,
                    textAlign: TextAlign.left,
                  ),
                  Text(
                    '${formatDate(
                          (requestList[index].timeStamp),
                          [HH, ':', nn],
                        )}' ??
                        " ",
                    style: kTitleStyle,
                  ),
                ],
              ),
              SizedBox(height: 8),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: <Widget>[
                  Flexible(
                    child: Text(
                      "Assistance : ${requestList[index].assistanceType}" ??
                          " ",
//                                  style: homePageS2,
                    ),
                  ),
                  Flexible(
                    child: Text(
                      requestList[index].acceptedBy == null
                          ? "Pending"
                          : "Accepted by ${requestList[index].acceptedBy['staff_name']}",
//                                  style: homePageS2,
                    ),
                  ),
                ],
              ),
            ],
          ),
        );
      },
    );
  }
}

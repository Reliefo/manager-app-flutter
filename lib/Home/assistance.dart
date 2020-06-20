import 'package:flutter/material.dart';
import 'package:manager_app/Home/assistanceReqBuilder.dart';
import 'package:manager_app/constants.dart';
import 'package:manager_app/fetchData/configureRestaurantData.dart';
import 'package:provider/provider.dart';

class Assistance extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final RestaurantData restaurantData = Provider.of<RestaurantData>(context);

    return Container(
//      color: Color(0xff9ec2e1),
      color: Colors.grey[50],
      child: Column(
        children: <Widget>[
          Container(
            color: kThemeColor,
            width: double.maxFinite,
            child: Center(
              child: Text(
                'Assistance',
                style: kHeaderStyle,
              ),
            ),
          ),
          restaurantData.restaurant.assistanceRequests != null
              ? Expanded(
                  child: AssistanceRequestBuilder(
                    requestList: restaurantData.restaurant.assistanceRequests,
                  ),
                )

              //todo: change it when you receive data
              : Container(
                  height: MediaQuery.of(context).size.height * 0.3,
                  child: Center(
                    child: Text(
                      'No Pending Requests',
                      style: kHeaderStyle,
                    ),
                  ),
                ),
        ],
      ),
    );
  }
}

import 'package:flutter/material.dart';
import 'package:manager_app/fetchData/configureRestaurantData.dart';
import 'package:provider/provider.dart';

import 'singlePerson.dart';

class PersonView extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final RestaurantData restaurantData = Provider.of<RestaurantData>(context);

    return SafeArea(
      child: Scaffold(
        body: Container(
          padding: EdgeInsets.all(10),
//          color: Colors.blueGrey,
          child: restaurantData.restaurant.staff != null
              ? GridView.builder(
                  itemCount: restaurantData.restaurant.staff.length,
                  gridDelegate: SliverGridDelegateWithMaxCrossAxisExtent(
                    mainAxisSpacing: 4.0,
                    crossAxisSpacing: 4.0,
                    childAspectRatio: 1,
                    maxCrossAxisExtent: 200,
                  ),
                  itemBuilder: (BuildContext context, int index) {
                    return GestureDetector(
                      child: Card(
                        color: Colors.amber[200],
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(15.0),
                        ),
                        child: Container(
                          padding: EdgeInsets.symmetric(vertical: 10),
                          child: Column(
                            children: <Widget>[
                              Image.asset(
                                'assets/icons/waiter.png',
                                height: 34,
                                width: 34,
                              ),
                              Text(restaurantData.restaurant.staff[index].name),
                            ],
                          ),
                        ),
                      ),
                      onTap: () {
                        showModalBottomSheet(
                          context: context,
                          builder: (context) => SinglePerson(
                            staff: restaurantData.restaurant.staff[index],
//                            assistanceReq: assistanceReq,
                          ),
                        );
                      },
                    );
                  },
                )
              : Container(
                  child: Center(
                    child: Text("go to configure rest and add Staff"),
                  ),
                ),
        ),
      ),
    );
  }
}

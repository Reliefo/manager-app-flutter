import 'package:adhara_socket_io_example/data.dart';
import 'package:flutter/material.dart';

import 'single_person.dart';

class PersonView extends StatelessWidget {
  final Restaurant restaurant;
  PersonView({@required this.restaurant});
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        body: Container(
          padding: EdgeInsets.all(10),
          color: Colors.blueGrey,
          child: restaurant.staff != null
              ? GridView.builder(
                  itemCount: restaurant.staff.length,
                  gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: 6,
                  ),
                  itemBuilder: (BuildContext context, int index) {
                    return GestureDetector(
                      child: Card(
                        color: Colors.white,
                        child: Container(
                          padding: EdgeInsets.symmetric(vertical: 10),
                          child: Column(
                            children: <Widget>[
                              Image.asset(
                                'assets/icons/waiter.png',
                                height: 34,
                                width: 34,
                              ),
                              Text(restaurant.staff[index].name),
                            ],
                          ),
                        ),
                      ),
                      onTap: () {
                        showModalBottomSheet(
                          context: context,
                          builder: (context) => SinglePerson(
                            staff: restaurant.staff[index],
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

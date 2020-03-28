import 'package:flutter/material.dart';

import 'single_person.dart';

class PersonView extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        body: Container(
          padding: EdgeInsets.all(10),
          color: Colors.blueGrey,
          child: GridView.builder(
            itemCount: 20,
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
                        Text('Person-$index'),
                      ],
                    ),
                  ),
                ),
                onTap: () {
                  showModalBottomSheet(
                    context: context,
                    builder: (context) => SinglePerson(),
                  );
                },
              );
            },
          ),
        ),
      ),
    );
  }
}

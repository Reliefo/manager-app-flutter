import 'package:flutter/material.dart';

import 'single_person.dart';

class PersonView extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        body: Container(
          color: Colors.blueGrey,
          child: Container(
              padding: EdgeInsets.all(10.0),
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
                            Icon(
                              Icons.person,
                              size: 40,
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
              )),
        ),
      ),
    );
  }
}

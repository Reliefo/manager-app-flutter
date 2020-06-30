import 'package:flutter/material.dart';

class LoadingPage extends StatelessWidget {
  @override
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        backgroundColor: Colors.black,
        body: Center(
          child: Stack(
            alignment: Alignment.bottomCenter,
            children: <Widget>[
              Image.network(
                  'https://media.giphy.com/media/cnzP4cmBsiOrccg20V/giphy.gif'
//          'https://media.giphy.com/media/58Y1tQU8AAhna/giphy.gif',
                  ),
              Text(
                "Establishing connection to the Database.",
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 24,
                  fontFamily: "Poppins",
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

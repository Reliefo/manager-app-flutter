import 'package:flutter/material.dart';

class SinglePerson extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        body: Container(
          child: Center(child: Text('landing page for person view')),
        ),
      ),
    );
  }
}

import 'package:flutter/material.dart';

class TestScreen extends StatefulWidget {
  @override
  TestScreenState createState() {
    return new TestScreenState();
  }
}

class TestScreenState extends State<TestScreen> {
  final _text = TextEditingController();
  bool _validate = false;

  @override
//  void dispose() {
//    _text.dispose();
//    super.dispose();
//  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('TextField Demo'),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Text('Error Showed if Field is Empty on Submit button Pressed'),
            TextFormField(
              controller: _text,
              decoration: InputDecoration(
                labelText: 'Enter the Value',
                errorText: _validate ? 'Value Can\'t Be Empty' : null,
              ),
            ),
            RaisedButton(
              onPressed: () {
                setState(() {
                  _text.text.isEmpty ? _validate = true : _validate = false;
                });
              },
              child: Text('Submit'),
              textColor: Colors.white,
              color: Colors.blueAccent,
            )
          ],
        ),
      ),
    );
  }
}

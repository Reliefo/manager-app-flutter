import 'package:flutter/material.dart';

class Options extends StatefulWidget {
  final foodOptionController;
  final priceController;
  final List<Map<String, dynamic>> options;
  final FocusNode foodOptionFocus;

  Options({
    @required this.foodOptionController,
    @required this.priceController,
    @required this.options,
    @required this.foodOptionFocus,
  });

  @override
  _OptionsState createState() => _OptionsState();
}

class _OptionsState extends State<Options> {
  @override
  Widget build(BuildContext context) {
    return Column(
      children: <Widget>[
        Row(children: <Widget>[
          Expanded(
            flex: 2,
            child: Container(
              padding: EdgeInsets.all(12),
              child: TextFormField(
                controller: widget.foodOptionController,
                focusNode: widget.foodOptionFocus,
                decoration: InputDecoration(
                  labelText: "option",
                  fillColor: Colors.white,
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(12.0),
                  ),
                ),
                keyboardType: TextInputType.text,
                validator: (value) {
                  if (value.isEmpty) {
                    return 'Please enter option';
                  }
                  return null;
                },
              ),
            ),
          ),
          Expanded(
            flex: 2,
            child: Container(
              padding: EdgeInsets.all(12),
              child: TextFormField(
                controller: widget.priceController,
                decoration: InputDecoration(
                  labelText: "price",
                  fillColor: Colors.white,
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(12.0),
                  ),
                  //fillColor: Colors.green
                ),
                keyboardType: TextInputType.text,
                validator: (value) {
                  if (value.isEmpty) {
                    return 'Please enter price';
                  }
                  return null;
                },
              ),
            ),
          ),
          Expanded(
            child: FlatButton(
                child: Text('add option'),
                onPressed: () {
                  setState(() {
                    widget.options.add({
                      "option_name": widget.foodOptionController.text,
                      "option_price": widget.priceController.text
                    });
                  });

                  widget.foodOptionController.clear();
                  widget.priceController.clear();
                }),
          )
        ]),
        Container(
          child: ListView.builder(
            shrinkWrap: true,
            primary: false,
            itemCount: widget.options.length,
            itemBuilder: (context, index) {
              return ListTile(
                title: Text(widget.options[index]["option_name"]),
                subtitle:
                    Text("Price : ${widget.options[index]["option_price"]}"),
                trailing: IconButton(
                  icon: Icon(
                    Icons.cancel,
                  ),
                  onPressed: () {
                    setState(() {
                      widget.options.removeAt(index);
                    });
                  },
                ),
              );
            },
          ),
        )
      ],
    );
  }
}

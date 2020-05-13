import 'package:flutter/material.dart';
import 'package:manager_app/constants.dart';
import 'package:manager_app/data.dart';

class ConfigureHappyHours extends StatefulWidget {
  final Restaurant restaurant;
  ConfigureHappyHours({
    this.restaurant,
  });
  @override
  _ConfigureHappyHoursState createState() => _ConfigureHappyHoursState();
}

class _ConfigureHappyHoursState extends State<ConfigureHappyHours> {
  Category selectedCategory;
  FoodItem selectedFood;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.grey,
        title: Text('Happy Hours'),
      ),
      body: Container(
        child: Row(
          children: <Widget>[
            Expanded(
              child: Container(
                color: Colors.green[100],
                child: Column(
                  children: <Widget>[
                    Text('Select Category'),
                    Row(
                      children: <Widget>[
                        Expanded(
                          child: Container(
                            padding: EdgeInsets.all(16),
                            child: DropdownButton(
                              items: widget.restaurant.barMenu != null
                                  ? widget.restaurant.barMenu.map((category) {
                                      return DropdownMenuItem(
                                        value: category,
                                        child: Text(category.name),
                                      );
                                    }).toList()
                                  : [],
                              hint: Text('Select Category'),
                              isExpanded: true,
                              onChanged: (selected) {
                                setState(() {
                                  print(selected.name);
                                  selectedCategory = selected;
                                });
                              },
                            ),
                          ),
                        ),
                        Expanded(
                          child: Container(
                            padding: EdgeInsets.symmetric(
                                vertical: 12, horizontal: 20),
                            child: selectedCategory != null
                                ? Text(
                                    selectedCategory.name,
                                    style: homePageS1,
                                  )
                                : Text(
                                    ' ',
                                    style: homePageS1,
                                  ),
                          ),
                        ),
                      ],
                    ),
                    Row(
                      children: <Widget>[
                        Expanded(
                          child: Container(
                            padding: EdgeInsets.all(16),
                            child: DropdownButton(
                              items: selectedCategory != null
                                  ? selectedCategory.foodList.map((food) {
                                      return DropdownMenuItem(
                                        value: food,
                                        child: Text(food.name),
                                      );
                                    }).toList()
                                  : [],
                              hint: Text('Select Drink'),
                              isExpanded: true,
                              onChanged: (selected) {
                                setState(() {
                                  print(selected.name);
                                  selectedFood = selected;
                                });
                              },
                            ),
                          ),
                        ),
                        Expanded(
                          child: Container(
                            padding: EdgeInsets.symmetric(
                                vertical: 12, horizontal: 20),
                            child: selectedFood != null
                                ? Text(
                                    selectedFood.name,
                                    style: homePageS1,
                                  )
                                : Text(
                                    ' ',
                                    style: homePageS1,
                                  ),
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ),
            Expanded(
              child: Container(
                color: Colors.red[100],
              ),
            ),
          ],
        ),
      ),
    );
  }
}

import 'package:adhara_socket_io_example/Drawer/configureRestaurant/configureHomeScreen/chefSpecial.dart';
import 'package:adhara_socket_io_example/Drawer/configureRestaurant/configureHomeScreen/happyHours.dart';
import 'package:flutter/material.dart';

class ConfigureHomeScreen extends StatelessWidget {
  final restaurant;
  ConfigureHomeScreen({
    this.restaurant,
  });
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        body: PageView(
          children: <Widget>[
            ConfigureChefSpecial(
              restaurant: restaurant,
            ),
            ConfigureHappyHours(
              restaurant: restaurant,
            ),
          ],
        ),
      ),
    );
  }
}

import 'package:flutter/material.dart';
import 'package:hello_world/layout/main_layout.dart';

class RouteOneScreen extends StatelessWidget {
  const RouteOneScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MainLayout(title: "routeOne", routes: []);
  }
}

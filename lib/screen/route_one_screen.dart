import 'package:flutter/material.dart';
import 'package:hello_world/layout/main_layout.dart';

class RouteOneScreen extends StatelessWidget {

  const RouteOneScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final String argument = ModalRoute.of(context)!.settings.arguments as String;

    return MainLayout(title: "routeOne", routes: [
      Text(argument),
      ElevatedButton(
        onPressed: () {
          Navigator.pop(context);
        },
        child: Text('Go Back'),
      ),
    ]);
  }
}

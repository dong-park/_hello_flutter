import 'package:flutter/material.dart';
import 'package:hello_world/layout/main_layout.dart';
import 'package:hello_world/screen/route_one_screen.dart';
import 'package:hello_world/screen/route_three_screen.dart';
import 'package:hello_world/screen/route_two_screen.dart';

class NavigatorTestScreen extends StatelessWidget {
  const NavigatorTestScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return MainLayout(title: "", routes: [
      ElevatedButton(
        onPressed: () {
          Navigator.pushNamed(context, '/routeOne', arguments: "routeOne");
        },
        child: Text('Route One'),
      ),
      ElevatedButton(
        onPressed: () {
          Navigator.push(
            context,
            MaterialPageRoute(
                builder: (context) => RouteTwoScreen(),
                settings: RouteSettings(
                  arguments: "two",
                )),
          );
        },
        child: Text('Route Two'),
      ),
      ElevatedButton(
        onPressed: () {
          Navigator.push(
              context,
              MaterialPageRoute(
                  builder: (context) => RouteThreeScreen(),
                  settings: RouteSettings(
                    arguments: "three",
                  )));
        },
        child: Text('Route Three'),
      ),
    ]);
  }
}

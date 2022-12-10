import 'package:flutter/material.dart';
import 'package:hello_world/screen/button_test_screen.dart';
import 'package:hello_world/screen/navigator_test_screen.dart';
import 'package:hello_world/screen/randomnum_screen.dart';
import 'package:hello_world/screen/route_one_screen.dart';

void main() {
  runApp(
    MaterialApp(
      debugShowCheckedModeBanner: false,
      initialRoute: '/',
      routes: {
        '/': (context) => const NavigatorTestScreen(),
        '/routeOne': (context) => const RouteOneScreen(),
        '/random': (context) => const HomeRandomScreen(),
        '/button': (context) => const ButtonTestScreen(),
        '/navigator': (context) => const NavigatorTestScreen(),
      }
    ),
  );
}

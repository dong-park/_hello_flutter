import 'package:flutter/material.dart';
import 'package:hello_world/screen/button_test_screen.dart';
import 'package:hello_world/screen/navigator_test_screen.dart';
import 'package:hello_world/screen/randomnum_screen.dart';
import 'package:hello_world/screen/time_screen.dart';

void main() {
  runApp(
    MaterialApp(debugShowCheckedModeBanner: false, home: NavigatorTestScreen()),
  );
}

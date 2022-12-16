import 'package:flutter/material.dart';

import 'calendar_main_screen.dart';

void main() {
  runApp(MaterialApp(
      theme: ThemeData(
        fontFamily: 'NotoSans'
      ),
      debugShowCheckedModeBanner: false,
      initialRoute: '/',
      routes: {
        '/': (context) => const CalendarMainScreen(),
      }));
}

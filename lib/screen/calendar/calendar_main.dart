import 'package:flutter/material.dart';

import 'calendar_main_screen.dart';
import 'package:intl/date_symbol_data_local.dart';
import 'package:hello_world/database/drift_database.dart';

final DEFAULT_COLORS = [
  //빨강
  'F44336',
  //분홍
  'E91E63',
  //보라
  '9C27B0',
  //남색
  '3F51B5',
  //파랑
  '2196F3',
  //청록
  '00BCD4',
];

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  await initializeDateFormatting();

  final database = LocalDatabase();

  database.getAllCategoryColors().then((value) {
    if (value.isEmpty) {
      for(String color in DEFAULT_COLORS) {
        database.createCategoryColor(CategoryColorsCompanion.insert(color: color));
      }
      print('database created');
    } else {
      print('database already exists');
    }
  });

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

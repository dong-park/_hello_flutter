import 'package:flutter/material.dart';

import 'agora_main_screen.dart';

void main() {
  runApp(
    MaterialApp(
      debugShowCheckedModeBanner: false,
      initialRoute: '/',
      routes: {
        '/': (context) => const AgoraMainScreen(),
      }
    ),
  );
}

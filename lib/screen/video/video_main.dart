import 'package:flutter/material.dart';
import 'package:hello_world/screen/video/video_main_screen.dart';
import 'package:hello_world/screen/video/video_player_screen.dart';

void main() {
  runApp(
    MaterialApp(
      debugShowCheckedModeBanner: false,
      initialRoute: '/',
      routes: {
        '/': (context) => const VideoHomeScreen(),
        // '/video': (context) => const VideoPlayerScreen(),
      }
    ),
  );
}

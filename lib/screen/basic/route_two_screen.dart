import 'package:flutter/material.dart';

import '../../layout/main_layout.dart';

class RouteTwoScreen extends StatelessWidget {
  const RouteTwoScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MainLayout(title: "routeTwo", routes: [
      ElevatedButton(
        onPressed: () {
          Navigator.of(context).pushReplacement(
            // 이전에 있던 화면을 지우고 새로운 화면을 띄운다.
            MaterialPageRoute(
              builder: (context) => RouteTwoScreen(),
              settings: RouteSettings(
                arguments: "two",
              ),
            ),
          );
        },
        child: Text('pushReplacement'),
      ),
      ElevatedButton(
        onPressed: () {
          Navigator.of(context).pushAndRemoveUntil(
            // 이전에 있던 화면을 지우고 새로운 화면을 띄운다.
            MaterialPageRoute(
              builder: (context) => RouteTwoScreen(),
              settings: RouteSettings(
                arguments: "two",
              ),
            ),
            // (route) => false, // 이전에 있던 화면을 모두 지운다.
            // (route) => true, // 이전에 있던 화면을 모두 지우지 않는다.
            (route) => route.settings.name == '/', // 홈스크린만 남기고 모두 지운다.
          );
        },
        child: Text('push And Remove Until'),
      ),
      ElevatedButton(
        onPressed: () {
          Navigator.pop(context);
        },
        child: Text('Back'),
      ),
    ]);
  }
}

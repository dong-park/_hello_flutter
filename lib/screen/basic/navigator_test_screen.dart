import 'package:flutter/material.dart';
import 'package:hello_world/layout/main_layout.dart';
import 'package:hello_world/screen/basic/route_three_screen.dart';
import 'package:hello_world/screen/basic/route_two_screen.dart';


class NavigatorTestScreen extends StatelessWidget {
  const NavigatorTestScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () async {
        return false; // 뒤로가기 버튼을 눌러도 화면이 바뀌지 않는다. 단 pop 기능을 사용하면 화면이 바뀐다.
        // return true; // 뒤로가기 버튼을 누르면 이전 화면으로 이동한다.
        // return Navigator.of(context).canPop(); // pop이 가능한 상태면 true, 아니면 false를 반환한다.
      },
      child: MainLayout(title: "", routes: [
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
        ElevatedButton(onPressed: () {
          Navigator.of(context).maybePop(); // 라우트 스택이 비어있지 않으면 이전 화면으로 이동한다.
        }, child: Text('Maybe Pop')),
      ]),
    );
  }
}

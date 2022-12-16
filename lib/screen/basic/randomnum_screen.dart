import 'dart:math';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:hello_world/component/number_row.dart';
import 'package:hello_world/screen/basic/setting_screen.dart';

import '../../constent/color.dart';

class HomeRandomScreen extends StatefulWidget {
  const HomeRandomScreen({Key? key}) : super(key: key);

  @override
  State<HomeRandomScreen> createState() => _HomeRandomScreenState();
}

class _HomeRandomScreenState extends State<HomeRandomScreen> {
  var randomNumbers = [123, 456, 789];
  var maxNumber = 10000;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: PRIMARY_COLOR,
      body: SafeArea(
        child: Padding(
          padding: EdgeInsets.symmetric(
            horizontal: 0,
            vertical: 20,
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              _Top(onPressed: onSettingPressed),
              _Body(randomNumbers: randomNumbers),
              _Footer(onPressed: onRandomChange)
            ],
          ),
        ),
      ),
    );
  }

  void onRandomChange() {
    final random = Random();
    final randomNum = List.generate(3, (idx) {
      var nextInt = random.nextInt(maxNumber);
      while (nextInt > maxNumber) {
        nextInt = random.nextInt(maxNumber);
      }
      return nextInt;
    });

    setState(() {
      randomNumbers = randomNum;
    });
  }

  void onSettingPressed() async {
    final pop = await Navigator.push(
        context,
        MaterialPageRoute(
            builder: (context) => SettingsScreen(maxNumber: maxNumber,), fullscreenDialog: true));

    if (pop != null) {
      setState(() {
        maxNumber = pop;
      });
      onRandomChange();
    }
  }
}

class _Top extends StatelessWidget {
  VoidCallback onPressed;

  _Top({required this.onPressed});

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(
          '랜덤숫자 생성기',
          style: TextStyle(
            fontSize: 30.0,
            color: Colors.white,
            fontWeight: FontWeight.bold,
          ),
        ),
        IconButton(
            onPressed: onPressed,
            icon: Icon(
              Icons.settings,
              color: RED_COLOR,
            ))
      ],
    );
  }
}

class _Body extends StatelessWidget {
  var randomNumbers = [];

  _Body({required this.randomNumbers});

  @override
  Widget build(BuildContext context) {
    return Expanded(
        child: Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: randomNumbers
          .asMap()
          .entries
          .map(
            (e) => Padding(
              padding: EdgeInsets.only(bottom: e.key == 2 ? 0 : 16.0),
              child: NumberRow(maxNumber: e.value,)
            ),
          )
          .toList(),
    ));
  }
}

class _Footer extends StatelessWidget {
  final VoidCallback onPressed;

  const _Footer({super.key, required this.onPressed});

  @override
  Widget build(BuildContext context) {
    return SizedBox(
        width: double.infinity,
        child: ElevatedButton(
            style: ElevatedButton.styleFrom(backgroundColor: RED_COLOR),
            onPressed: () => onPressed(),
            child: Text("생성하기")));
  }
}

import 'dart:math';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import '../constent/color.dart';

class HomeRandomScreen extends StatefulWidget {
  const HomeRandomScreen({Key? key}) : super(key: key);

  @override
  State<HomeRandomScreen> createState() => _HomeRandomScreenState();
}

class _HomeRandomScreenState extends State<HomeRandomScreen> {
  var randomNumbers = [123, 456, 789];

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
              const _Top(),
              _Body(randomNumbers: randomNumbers),
              _Footer(onPressed: onPressed)
            ],
          ),
        ),
      ),
    );
  }

  void onPressed() {
    final random = Random();
    final randomNum = List.generate(3, (idx) {
      var nextInt = random.nextInt(1000);
      while (nextInt < 100) {
        nextInt = random.nextInt(1000);
      }
      return nextInt;
    });

    setState(() {
      randomNumbers = randomNum;
    });
  }
}

class _Top extends StatelessWidget {
  const _Top({Key? key}) : super(key: key);

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
            onPressed: () => {},
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
              child: Row(
                  children: e.value
                      .toString()
                      .split('')
                      .map((e) => Image.asset(
                            'asset/img/$e.png',
                            width: 50,
                            height: 70,
                          ))
                      .toList()),
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

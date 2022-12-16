import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class HomeScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        // color: Colors.black,
        bottom: false,
        child: Container(
          color: Colors.black,
          // width: MediaQuery.of(context).size.width, // 100%
          // height: MediaQuery.of(context).size.height, // 100%
          child: Column(
            // MainAxisAlignment - 주축 정렬
            // start - 시작점
            // end - 끝점
            // center - 중앙
            // spaceBetween - 위젯 사이에 균등한 간격을 두고 배치
            // spaceEvenly - 끝과 끝이 위젯이 아닌 빈 간격으로 배치 나머지는 균등
            // spaceAround - spaceEvenly와 비슷하지만 위젯 사이의 간격이 더 넓음
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            // CrossAxisAlignment - 교차축 정렬
            // start - 시작점
            // end - 끝점
            // center - 중앙
            // stretch - 교차축을 꽉 채움
            crossAxisAlignment: CrossAxisAlignment.start,
            // MainAxisSize - 주축 크기
            // min - 주축의 최소 크기로 배치
            // max - 주축의 최대 크기로 배치
            // mainAxisSize: MainAxisSize.min,
            children: [
              // Expanded / Flexible
              // Expanded는 교차축을 꽉 채우고 주축을 최대 크기로 배치
              // Flexible은 교차축을 꽉 채우고 주축을 최소 크기로 배치 (남는공간처리)
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
                  Container(
                    color: Colors.red,
                    width: 50.0,
                    height: 50.0,
                  ),
                  Container(
                    color: Colors.green,
                    width: 50.0,
                    height: 50.0,
                  ),
                  Container(
                    color: Colors.blue,
                    width: 50.0,
                    height: 50.0,
                  ),
                  Container(
                    color: Colors.yellow,
                    width: 50.0,
                    height: 50.0,
                  ),
                ],
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Container(
                    color: Colors.red,
                    width: 50.0,
                    height: 50.0,
                  ),
                ],
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  Container(
                    color: Colors.red,
                    width: 50.0,
                    height: 50.0,
                  ),
                  Container(
                    color: Colors.green,
                    width: 50.0,
                    height: 50.0,
                  ),
                  Container(
                    color: Colors.blue,
                    width: 50.0,
                    height: 50.0,
                  ),
                  Container(
                    color: Colors.yellow,
                    width: 50.0,
                    height: 50.0,
                  ),
                ],
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Container(
                    color: Colors.yellow,
                    width: 50.0,
                    height: 50.0,
                  ),
                ],
              ),
            ],
          ),
        )
      ),
    );
  }
}

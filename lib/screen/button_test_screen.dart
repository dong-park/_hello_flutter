import 'package:flutter/material.dart';

class ButtonTestScreen extends StatefulWidget {
  const ButtonTestScreen({Key? key}) : super(key: key);

  @override
  State<ButtonTestScreen> createState() => _ButtonTestScreenState();
}

class _ButtonTestScreenState extends State<ButtonTestScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.symmetric(
            horizontal: 20,
          ),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              ElevatedButton(
                onPressed: () {},
                style: ButtonStyle(
                    // Material State
                    //
                    // hovered - 호버링 상태 (마우스가 위에 올라와 있는 상태)
                    // focused - 포커스 상태 (키보드로 포커스가 이동한 상태)
                    // pressed - 눌린 상태 (마우스 클릭 또는 터치)
                    // disabled - 비활성화 상태
                    // selected - 선택된 상태 (체크박스, 라디오 버튼 등)
                    // scrollUnder - 다른 컴포넌트 밑으로 스크롤 되어 있는 상태
                    // dragged - 드래그 상태 (마우스 또는 터치로 드래그 중인 상태)
                    // error - 에러 상태
                    //
                    backgroundColor: MaterialStateProperty.all(Colors.black),
                    foregroundColor:
                        MaterialStateProperty.resolveWith((states) { // Material State에 따라 다른 색상을 지정할 수 있음
                      if (states.contains(MaterialState.pressed)) {
                        return Colors.white;
                      } else {
                        return Colors.black;
                      }
                    })),
                child: const Text('ElevatedButton'),
              ),
              ElevatedButton(
                  // 3d button
                  onPressed: () => {},
                  style: ElevatedButton.styleFrom(
                    primary: Colors.red,
                    // background
                    onPrimary: Colors.white,
                    // text color
                    shadowColor: Colors.black,
                    // shadow color
                    elevation: 10,
                    // shadow depth
                    textStyle: TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 20,
                    ),
                    padding: EdgeInsets.symmetric(
                      horizontal: 20,
                      vertical: 20,
                    ),
                    side: BorderSide(
                      // border style
                      color: Colors.black,
                      width: 2,
                    ),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(10),
                    ),
                  ),
                  child: Text('ElevatedButton')),
              OutlinedButton(
                // 2d button
                onPressed: () => {},
                style: OutlinedButton.styleFrom(
                  primary: Colors.red,
                  // onPrimary 만 없다
                  backgroundColor: Colors.yellow, // background 가 primary 가 된다
                  // text color
                  side: BorderSide(
                    // border style
                    color: Colors.black,
                    width: 2,
                  ),
                  textStyle: TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 20,
                  ),
                ),
                child: Text('OutlinedButton'),
              ),
              TextButton(
                  // only text button
                  onPressed: () => {},
                  style: TextButton.styleFrom(
                    primary: Colors.white,
                    // onPrimary 만 없다
                    backgroundColor: Colors.blue,
                  ),
                  child: Text('TextButton')),
            ],
          ),
        ),
      ),
    );
  }
}

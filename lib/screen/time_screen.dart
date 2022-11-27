import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class HomeTimeScreen extends StatefulWidget {
  const HomeTimeScreen({Key? key}) : super(key: key);

  @override
  State<HomeTimeScreen> createState() => _HomeTimeScreenState();
}

class _HomeTimeScreenState extends State<HomeTimeScreen> {
  final DateTime now = DateTime.now();
  DateTime selectedDate = DateTime(
    DateTime.now().year,
    DateTime.now().month,
    DateTime.now().day,
  );

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey[500],
      body: SafeArea(
        child: Container(
          width: MediaQuery.of(context).size.width,
          child: Column(
            children: [
              Expanded(child: _TopPart(
                selectedDate: selectedDate,
                onPressed: onHeartPressed,
              )),
              Expanded(child: _BottomPart()),
            ],
          ),
        ),
      ),
    );
  }

  void onHeartPressed() {

    showCupertinoDialog(
        context: context,
        barrierDismissible: true, // 컨테이너 밖을 누르면 컨테이너를 언제든지 닫을수 있다
        builder: (context) => Align(
              alignment: Alignment.bottomCenter,
              child: Container(
                color: Colors.white,
                height: 300.0, // 특정 높이가 정렬되지 않으면 전체화면으로 실행됩니다.
                child: CupertinoDatePicker(
                    mode: CupertinoDatePickerMode.date,
                    maximumDate: DateTime.now(),
                    initialDateTime: DateTime(now.year, now.month, now.day),
                    onDateTimeChanged: (DateTime newDateTime) {
                      setState(() {
                        selectedDate = newDateTime;
                      });
                    }),
              ),
            ));
  }
}

class _BottomPart extends StatelessWidget {
  const _BottomPart({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Image.asset(
        'asset/img/middle_image.png',
      ),
    );
  }
}

class _TopPart extends StatelessWidget {
  final DateTime selectedDate;
  final VoidCallback onPressed;

  const _TopPart(
      {required this.selectedDate, required this.onPressed, Key? key})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final textThme = theme.textTheme;

    return Column(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(
          "C8",
          style: textThme.headline1,
        ),
        Column(
          children: [
            Text(
              "올해도 솔로",
              style: textThme.headline2,
            ),
            Text(
                '${selectedDate.year}년 ${selectedDate.month}월 ${selectedDate.day}일',
              style: textThme.bodyText1,
            ),
          ],
        ),
        IconButton(
            onPressed: onPressed,
            iconSize: 50.0,
            icon: Icon(Icons.favorite, color: Colors.blueGrey[200])),
        Text("D+${DateTime.now().difference(selectedDate).inDays}", style: textThme.bodyText2,)
      ],
    );
    ;
  }
}

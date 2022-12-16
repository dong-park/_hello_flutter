import 'dart:async';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class HomePhotoScreen extends StatefulWidget {
  const HomePhotoScreen({Key? key}) : super(key: key);

  @override
  State<HomePhotoScreen> createState() => _HomePhotoScreenState();
}

class _HomePhotoScreenState extends State<HomePhotoScreen> {
  Timer? _timer;
  PageController controller = PageController(
    initialPage: 0,
  );

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _timer = Timer.periodic(Duration(seconds: 4), (timer) {
      setState(() {
        int currentPage = controller.page!.toInt();
        int nextPage = currentPage + 1;
        if (nextPage > 4) {
          nextPage = 0;
        }
        controller.animateToPage(nextPage,
            duration: Duration(milliseconds: 400), curve: Curves.linear);
      });
    });
  }

  @override
  void dispose() {
    if (_timer != null) {
      _timer!.cancel(); // state가 죽을때 timer를 죽여줘야함
    }
    controller.dispose(); // controller도 죽여줘야함

    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    SystemChrome.setSystemUIOverlayStyle(SystemUiOverlayStyle(
      statusBarColor: Colors.transparent,
      statusBarIconBrightness: Brightness.dark,
    ));
    return Scaffold(
      body: PageView(
        controller: controller,
        children: [1, 2, 3, 4, 5]
            .map((e) => Image.asset(
                  'asset/img/image_$e.jpeg',
                  fit: BoxFit.cover,
                ))
            .toList(),
      ),
    );
  }
}

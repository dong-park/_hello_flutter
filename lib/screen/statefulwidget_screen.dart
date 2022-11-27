import 'package:flutter/cupertino.dart';

class HomeStatefulScreen extends StatefulWidget {
  final Color color;

  HomeStatefulScreen({required this.color, Key? key}) : super(key: key) {
    print('HomeStatefulScreen constructor');
  }

  @override
  State<HomeStatefulScreen> createState() {
    print('HomeStatefulScreen createState');
    return _HomeStatefulScreenState();
  }
}

class _HomeStatefulScreenState extends State<HomeStatefulScreen> {
  int number = 0;

  @override
  void initState() {
    // TODO: implement initState
    print('HomeStatefulScreen initState');
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    print('HomeStatefulScreen build');

    return GestureDetector(
      onTap: () {
        setState(() {
          number++;
        });
      },
      child: Container(
        width: 200,
        height: 200,
        color: widget.color,
        child: Center(
          child: Text(
            number.toString(),
            style: TextStyle(
              fontSize: 20,
            ),
          ),
        ),
      ),
    );
  }

  @override
  void didChangeDependencies() {
    // TODO: implement didChangeDependencies
    super.didChangeDependencies();
    print('HomeStatefulScreen didChangeDependencies');
  }

  @override
  void didUpdateWidget(covariant HomeStatefulScreen oldWidget) {
    // TODO: implement didUpdateWidget
    super.didUpdateWidget(oldWidget);
    print('HomeStatefulScreen didUpdateWidget');
  }

  @override
  void deactivate() {
    // TODO: implement deactivate
    super.deactivate();
    print('HomeStatefulScreen deactivate');
  }

  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();
    print('HomeStatefulScreen dispose');
  }
}


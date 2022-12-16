import 'package:flutter/material.dart';
import 'package:hello_world/component/number_row.dart';
import 'package:hello_world/constent/color.dart';

class SettingsScreen extends StatefulWidget {
  final int maxNumber;

  const SettingsScreen({Key? key, required this.maxNumber}) : super(key: key);

  @override
  State<SettingsScreen> createState() => _SettingsScreenState();
}

class _SettingsScreenState extends State<SettingsScreen> {
  double maxNumber = 10000;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();

    maxNumber = widget.maxNumber.toDouble();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: BLUE_COLOR,
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.symmetric(
            horizontal: 20,
            vertical: 0,
          ),
          child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                _Body(maxNumber: maxNumber.toInt()),
                _Footer(maxNumber: maxNumber, onPressed: onSettingPressed, onChanged: onChangedNumber,)
              ]),
        ),
      ),
    );
  }

  void onSettingPressed() {
    Navigator.pop(context, maxNumber.toInt());
  }

  void onChangedNumber(double value) {
    setState(() {
      maxNumber = value;
    });
  }
}

class _Body extends StatelessWidget {
  int maxNumber;

  _Body({Key? key, required this.maxNumber}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Expanded(
        child: NumberRow(maxNumber: maxNumber,)
    );
  }
}

class _Footer extends StatelessWidget {
  final double maxNumber;
  final ValueChanged<double> onChanged;
  final VoidCallback onPressed;

  const _Footer(
      {Key? key,
      required this.maxNumber,
      required this.onChanged,
      required this.onPressed})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(children: [
      Slider(value: maxNumber, max: 1000000, min: 10000, onChanged: onChanged),
      ElevatedButton(
          style: ElevatedButton.styleFrom(backgroundColor: RED_COLOR),
          onPressed: () => onPressed(),
          child: Text("생성하기"))
    ]);
  }
}

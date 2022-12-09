import 'package:flutter/material.dart';

class NumberRow extends StatelessWidget {
  final int maxNumber;

  const NumberRow({Key? key, required this.maxNumber}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Row(
      children: maxNumber
          .toInt()
          .toString()
          .split('')
          .map((e) => Image.asset('asset/img/$e.png', width: 50, height: 70))
          .toList(),
    );
  }
}

import 'package:flutter/material.dart';

class ScheduledBottomSheet extends StatelessWidget {
  const ScheduledBottomSheet({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final bottomInset = MediaQuery.of(context).viewInsets.bottom;

    return Container(
      height: MediaQuery.of(context).size.height * 0.5 + bottomInset,
      child: Padding(
        padding: EdgeInsets.only(bottom: bottomInset),
        child: Column(children: [
          TextField(
            decoration: InputDecoration(
              hintText: 'Title',
            ),
          ),
        ]),
      ),
    );
  }
}

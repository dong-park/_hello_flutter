import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:hello_world/constent/color.dart';

class ScheduledBottomSheet extends StatelessWidget {
  const ScheduledBottomSheet({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final bottomInset = MediaQuery.of(context).viewInsets.bottom;

    return Container(
      height: MediaQuery.of(context).size.height * 0.5 + bottomInset,
      child: Padding(
        padding: EdgeInsets.fromLTRB(15, 15, 15, 15 + bottomInset),
        child:
            Column(crossAxisAlignment: CrossAxisAlignment.stretch, children: [
          Row(
            children: [
              Expanded(child: CustomTextField(isTime: true, label: '시작시간')),
              SizedBox(
                width: 16,
              ),
              Expanded(child: CustomTextField(isTime: true, label: '마감시간')),
            ],
          ),
          SizedBox(
            height: 10,
          ),
          Expanded(child: CustomTextField(isTime: false, label: '내용')),
          SizedBox(
            height: 10,
          ),
          _ColorPicker(),
          SizedBox(
            height: 10,
          ),
          ElevatedButton(
            onPressed: () {},
            child: Text('저장'),
            style: ElevatedButton.styleFrom(backgroundColor: PRIMARY_COLOR),
          )
        ]),
      ),
    );
  }
}

class CustomTextField extends StatelessWidget {
  final String label;
  final bool isTime;

  const CustomTextField({Key? key, required this.label, required this.isTime})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          label,
          style: TextStyle(color: PRIMARY_COLOR, fontWeight: FontWeight.w500),
        ),
        if (isTime)
          _RenderingTextField(isTime: isTime)
        else
          Expanded(
              child: _RenderingTextField(
            isTime: isTime,
          )),
      ],
    );
  }
}

class _RenderingTextField extends StatelessWidget {
  final bool isTime;

  const _RenderingTextField({Key? key, required this.isTime}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return TextField(
      keyboardType: isTime ? TextInputType.number : TextInputType.multiline,
      cursorColor: Colors.grey[300],
      inputFormatters: isTime ? [FilteringTextInputFormatter.digitsOnly] : [],
      maxLines: isTime ? 1 : null,
      expands: isTime ? false : true,
      decoration: InputDecoration(
          border: InputBorder.none,
          fillColor: Colors.grey.shade300,
          filled: true),
    );
  }
}

class _ColorPicker extends StatelessWidget {
  const _ColorPicker({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Wrap(
        alignment: WrapAlignment.start,
        crossAxisAlignment: WrapCrossAlignment.center,
        spacing: 5,
        children: [
          _ColorPickerItem(color: Colors.red),
          _ColorPickerItem(color: Colors.blue),
          _ColorPickerItem(color: Colors.green),
          _ColorPickerItem(color: Colors.yellow),
          _ColorPickerItem(color: Colors.purple),
          _ColorPickerItem(color: Colors.orange),
          _ColorPickerItem(color: Colors.pink),
          _ColorPickerItem(color: Colors.brown),
          _ColorPickerItem(color: Colors.black),
        ],
      ),
    );
  }
}

class _ColorPickerItem extends StatelessWidget {
  final Color color;

  const _ColorPickerItem({Key? key, required this.color}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 25,
      height: 25,
      decoration: BoxDecoration(shape: BoxShape.circle, color: color),
    );
  }
}

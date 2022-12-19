import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:hello_world/constent/color.dart';

class ScheduledBottomSheet extends StatefulWidget {
  const ScheduledBottomSheet({Key? key}) : super(key: key);

  @override
  State<ScheduledBottomSheet> createState() => _ScheduledBottomSheetState();
}

class _ScheduledBottomSheetState extends State<ScheduledBottomSheet> {
  GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  String? content;
  String? start;
  String? end;

  @override
  Widget build(BuildContext context) {
    final bottomInset = MediaQuery.of(context).viewInsets.bottom;

    return Container(
      height: MediaQuery.of(context).size.height * 0.5 + bottomInset,
      child: Form(
        key: _formKey,
        autovalidateMode: AutovalidateMode.always,
        child: Padding(
          padding: EdgeInsets.fromLTRB(15, 15, 15, 15 + bottomInset),
          child:
              Column(crossAxisAlignment: CrossAxisAlignment.stretch, children: [
            _Date(
              startSetter: (val) => setState(() {
                start = val;
              }),
              endSetter: (val) => setState(() {
                end = val;
              }),
            ),
            _Blank(),
            _Content(
              contentSetter: (val) => setState(() {
                content = val;
              }),
            ),
            _Blank(),
            _ColorPicker(),
            _Blank(),
            _Save(
              onPressSaveButton: onPressSaveButton,
            ),
          ]),
        ),
      ),
    );
  }

  onPressSaveButton() {
    if (_formKey == null) {
      return;
    }
    if (_formKey.currentState!.validate()) {
      _formKey.currentState!.save();
    }
  }
}

class _Blank extends StatelessWidget {
  const _Blank({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 10,
    );
  }
}

class _Date extends StatelessWidget {
  final FormFieldSetter<String> startSetter;
  final FormFieldSetter<String> endSetter;

  const _Date({Key? key, required this.startSetter, required this.endSetter})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Expanded(
            child: CustomTextField(
          isTime: true,
          label: '시작시간',
          onSaved: startSetter,
        )),
        SizedBox(
          width: 16,
        ),
        Expanded(
            child: CustomTextField(
          isTime: true,
          label: '마감시간',
          onSaved: endSetter,
        )),
      ],
    );
  }
}

class _Content extends StatelessWidget {
  final FormFieldSetter<String> contentSetter;

  const _Content({Key? key, required this.contentSetter}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Expanded(
        child: CustomTextField(
      isTime: false,
      label: '내용',
      onSaved: contentSetter,
    ));
  }
}

class _Save extends StatelessWidget {
  final VoidCallback onPressSaveButton;

  const _Save({Key? key, required this.onPressSaveButton}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      onPressed: onPressSaveButton,
      child: Text('저장'),
      style: ElevatedButton.styleFrom(backgroundColor: PRIMARY_COLOR),
    );
  }
}

class CustomTextField extends StatelessWidget {
  final String label;
  final bool isTime;

  final FormFieldSetter<String> onSaved;

  const CustomTextField(
      {Key? key,
      required this.label,
      required this.isTime,
      required this.onSaved})
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
          _RenderingTextField(
            isTime: isTime,
            onSaved: onSaved,
          )
        else
          Expanded(
              child: _RenderingTextField(
            isTime: isTime,
            onSaved: onSaved,
          )),
      ],
    );
  }
}

class _RenderingTextField extends StatelessWidget {
  final bool isTime;
  final FormFieldSetter<String> onSaved;

  const _RenderingTextField(
      {Key? key, required this.isTime, required this.onSaved})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      validator: (value) {
        if (value == null || value.isEmpty) {
          return '내용을 입력해주세요';
        }

        if (isTime) {
          int time = int.parse(value);
          if (!(time < 24 && 0 < time)) {
            return '24시간 형식으로 입력해주세요';
          }
        }

        return null;
      },
      onSaved: onSaved,
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

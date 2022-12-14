import 'package:drift/drift.dart' show Value;
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get_it/get_it.dart';
import 'package:hello_world/constent/color.dart';
import 'package:hello_world/database/drift_database.dart';

import '../model/schedule_with_color.dart';

class ScheduledBottomSheet extends StatefulWidget {
  final DateTime selectedDay;
  final ScheduleWithColor? scheduleWithColor;

  const ScheduledBottomSheet({Key? key, required this.selectedDay, this.scheduleWithColor})
      : super(key: key);

  @override
  State<ScheduledBottomSheet> createState() => _ScheduledBottomSheetState();
}

class _ScheduledBottomSheetState extends State<ScheduledBottomSheet> {
  GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  String? content;
  String? start;
  String? end;
  String? selectedId;

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
              startTime: widget.scheduleWithColor?.schedule.startTime?.toString() ?? '',
              endTime: widget.scheduleWithColor?.schedule.endTime?.toString() ?? '',
              startSetter: (val) => setState(() {
                start = val;
              }),
              endSetter: (val) => setState(() {
                end = val;
              }),
            ),
            _Blank(),
            _Content(
              content: widget.scheduleWithColor?.schedule.content ?? '',
              contentSetter: (val) => setState(() {
                content = val;
              }),
            ),
            _Blank(),
            renderColorPicker(),
            _Blank(),
            _Save(
              onPressSaveButton: onPressSaveButton,
            ),
          ]),
        ),
      ),
    );
  }

  onPressSaveButton() async {
    if (_formKey == null) {
      return;
    }
    if (_formKey.currentState!.validate()) {
      _formKey.currentState!.save();

      DateTime startTime = DateTime(
        widget.selectedDay.year,
        widget.selectedDay.month,
        widget.selectedDay.day,
        int.parse(start!),
      );
      DateTime endTime = DateTime(
        widget.selectedDay.year,
        widget.selectedDay.month,
        widget.selectedDay.day,
        int.parse(end!),
      );

      Future<int> key = GetIt.I<LocalDatabase>().createSchedule(
        SchedulesCompanion(
          content: Value(content!),
          startTime: Value(startTime),
          endTime: Value(endTime),
          colorId: Value(selectedId),
          date: Value(DateTime(widget.selectedDay.year,
              widget.selectedDay.month, widget.selectedDay.day)),
        ),
      );

      Navigator.pop(context);
    }
  }

  Widget renderColorPicker() {
    return FutureBuilder<List<CategoryColor>>(
      future: GetIt.I<LocalDatabase>().getAllCategoryColors(),
      builder: (context, snapshot) {
        if (this.selectedId == null) {
          this.selectedId = snapshot.data![0].color;
        }
        if (snapshot.hasData) {
          return Wrap(
            alignment: WrapAlignment.start,
            crossAxisAlignment: WrapCrossAlignment.center,
            spacing: 5,
            children: snapshot.data!
                .map((e) => _ColorPickerItem(
                      color: Color(int.parse('FF${e.color}', radix: 16)),
                      isSelected: selectedId == e.color,
                      onTab: () {
                        setState(() {
                          this.selectedId = e.color;
                        });
                      },
                    ))
                .toList(),
          );
        } else {
          return Container();
          // return CircularProgressIndicator();
        }
      },
    );
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
  final String? startTime;
  final String? endTime;

  const _Date({Key? key, required this.startSetter, required this.endSetter, this.startTime, this.endTime })
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Expanded(
            child: CustomTextField(
          isTime: true,
          label: '????????????',
          onSaved: startSetter,
        )),
        SizedBox(
          width: 16,
        ),
        Expanded(
            child: CustomTextField(
          isTime: true,
          label: '????????????',
          onSaved: endSetter,
        )),
      ],
    );
  }
}

class _Content extends StatelessWidget {
  final FormFieldSetter<String> contentSetter;
  final String? content;

  const _Content({Key? key, required this.contentSetter, this.content}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Expanded(
        child: CustomTextField(
      isTime: false,
      label: '??????',
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
      child: Text('??????'),
      style: ElevatedButton.styleFrom(backgroundColor: PRIMARY_COLOR),
    );
  }
}

class CustomTextField extends StatelessWidget {
  final String label;
  final bool isTime;
  final String? initialValue;

  final FormFieldSetter<String> onSaved;

  const CustomTextField(
      {Key? key,
      required this.label,
      required this.isTime,
      required this.onSaved, this.initialValue})
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
          return '????????? ??????????????????';
        }

        if (isTime) {
          int time = int.parse(value);
          if (!(time < 24 && 0 < time)) {
            return '24?????? ???????????? ??????????????????';
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

class _ColorPickerItem extends StatelessWidget {
  final Color color;
  final bool isSelected;
  final BoxDecoration boxDecoration = BoxDecoration(
    shape: BoxShape.circle,
    border: Border.all(color: Colors.grey.shade300),
  );
  final VoidCallback onTab;

  _ColorPickerItem({
    Key? key,
    required this.color,
    required this.isSelected,
    required this.onTab,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTab,
      child: Container(
          width: 25,
          height: 25,
          decoration: isSelected
              ? boxDecoration.copyWith(
                  color: color,
                  border: Border.all(color: Colors.black, width: 3))
              : boxDecoration.copyWith(color: color)),
    );
  }
}

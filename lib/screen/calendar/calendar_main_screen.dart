import 'package:flutter/material.dart';
import 'package:table_calendar/table_calendar.dart';

class CalendarMainScreen extends StatefulWidget {
  const CalendarMainScreen({Key? key}) : super(key: key);

  @override
  State<CalendarMainScreen> createState() => _CalendarMainScreenState();
}

class _CalendarMainScreenState extends State<CalendarMainScreen> {
  DateTime? selectedDay;
  DateTime? focusedDay;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Calendar'),
      ),
      body: TableCalendar(
        focusedDay: DateTime.now(),
        firstDay: DateTime.utc(1000),
        lastDay: DateTime.utc(3000),
        headerStyle: HeaderStyle(
          formatButtonVisible: true,
          titleCentered: true,
          titleTextStyle: TextStyle(fontWeight: FontWeight.w700, fontSize: 16),
        ),
        onDaySelected: (DateTime selectedDay, DateTime focusedDay) {
          setState(() {
            this.selectedDay = selectedDay;
            this.focusedDay = focusedDay;
          });
        },
        selectedDayPredicate: (day) {
          if (this.selectedDay != null) {
            return day.day == this.selectedDay!.day &&
                day.month == this.selectedDay!.month &&
                day.year == this.selectedDay!.year;
          } else {
            return false;
          }
        },
      ),
    );
  }
}

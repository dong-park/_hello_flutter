import 'package:flutter/material.dart';
import 'package:get_it/get_it.dart';
import 'package:hello_world/component/scheduled_bottom_sheet.dart';
import 'package:hello_world/constent/color.dart';
import 'package:hello_world/database/drift_database.dart';
import 'package:hello_world/model/schedule_with_color.dart';
import 'package:table_calendar/table_calendar.dart';

class CalendarMainScreen extends StatefulWidget {
  const CalendarMainScreen({Key? key}) : super(key: key);

  @override
  State<CalendarMainScreen> createState() => _CalendarMainScreenState();
}

class _CalendarMainScreenState extends State<CalendarMainScreen> {
  DateTime selectedDay = DateTime.utc(
    DateTime.now().year,
    DateTime.now().month,
    DateTime.now().day,
  );
  DateTime focusedDay = DateTime.now();
  int count = 3;

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        floatingActionButton: FloatingActionButton(
            onPressed: () {
              showModalBottomSheet(
                  context: context,
                  isScrollControlled: true,
                  builder: (context) {
                    return ScheduledBottomSheet(
                      selectedDay: selectedDay,
                    );
                  });
            },
            backgroundColor: PRIMARY_COLOR,
            child: Icon(Icons.add)),
        body: Column(
          children: [
            _Calendar(
                focusedDay: focusedDay,
                selectedDay: selectedDay,
                onDaySelected: onDaySelected),
            _Banner(selectedDay: selectedDay, count: count),
            SizedBox(
              height: 14,
            ),
            Expanded(
                child: StreamBuilder<List<ScheduleWithColor>>(
              stream: GetIt.I
                  .get<LocalDatabase>()
                  .watchSelectedSchedule(selectedDay),
              builder: (context, snapshot) => ListView.separated(
                  itemCount: snapshot.data?.length ?? 0,
                  separatorBuilder: (context, index) => const SizedBox(
                        height: 16,
                      ),
                  itemBuilder: (context, index) {
                    return Dismissible(
                      key: Key(index.toString()),
                      direction: DismissDirection.endToStart,
                      onDismissed: (direction) {
                        // alert dialog
                        GetIt.I
                            .get<LocalDatabase>()
                            .deleteSchedule(
                            snapshot.data![index].schedule);
                      },
                      child: GestureDetector(
                        onTap: () {
                          showModalBottomSheet(
                              context: context,
                              isScrollControlled: true,
                              builder: (context) {
                                return ScheduledBottomSheet(
                                  selectedDay: selectedDay,
                                  scheduleWithColor: snapshot.data![index],
                                );
                              });
                        },
                        child: _ScheduledCard(
                          startDate: snapshot.data![index].schedule.startTime,
                          endDate: snapshot.data![index].schedule.endTime,
                          agenda: snapshot.data![index].schedule.content,
                          categoryColor: Color(int.parse(
                              'FF${snapshot.data![index].color.color}',
                              radix: 16)),
                          // color: snapshot.data![index].color,
                        ),
                      ),
                    );
                  }),
            )),
          ],
        ),
      ),
    );
  }

  OnDaySelected? onDaySelected(DateTime selectedDay, DateTime focusedDay) {
    setState(() {
      this.selectedDay = selectedDay;
      this.focusedDay = selectedDay;
    });
  }

  colorIdToHex(int colorId) {
    return colorId.toRadixString(16);
  }
}

class _Calendar extends StatelessWidget {
  final DateTime focusedDay, selectedDay;
  final OnDaySelected onDaySelected;

  _Calendar(
      {Key? key,
      required this.focusedDay,
      required this.selectedDay,
      required this.onDaySelected})
      : super(key: key);
  BoxDecoration defaultBoxDecoration = BoxDecoration(
    color: Colors.grey.shade200,
    borderRadius: BorderRadius.circular(6.0),
  );

  TextStyle defaultTextStyle = TextStyle(
    color: Colors.grey.shade600,
    fontWeight: FontWeight.w700,
  );

  @override
  Widget build(BuildContext context) {
    return TableCalendar(
      locale: 'ko_KR',
      focusedDay: this.focusedDay,
      firstDay: DateTime.utc(1000),
      lastDay: DateTime.utc(3000),
      headerStyle: HeaderStyle(
        formatButtonVisible: true,
        titleCentered: true,
        titleTextStyle: TextStyle(fontWeight: FontWeight.w700, fontSize: 16),
      ),
      calendarStyle: CalendarStyle(
          isTodayHighlighted: false,
          defaultDecoration: defaultBoxDecoration,
          weekendDecoration: defaultBoxDecoration,
          selectedDecoration: defaultBoxDecoration.copyWith(
              border: Border.all(width: 1, color: PRIMARY_COLOR)),
          defaultTextStyle: defaultTextStyle,
          weekendTextStyle: defaultTextStyle,
          selectedTextStyle: defaultTextStyle.copyWith(color: PRIMARY_COLOR),
          outsideDecoration: BoxDecoration(shape: BoxShape.rectangle)),
      onDaySelected: onDaySelected,
      selectedDayPredicate: (day) {
        if (this.selectedDay != null) {
          return day.day == this.selectedDay!.day &&
              day.month == this.selectedDay!.month &&
              day.year == this.selectedDay!.year;
        } else {
          return false;
        }
      },
    );
  }
}

class _Banner extends StatelessWidget {
  final DateTime selectedDay;
  final int count;
  TextStyle bannerTextStyle =
      TextStyle(fontWeight: FontWeight.w700, color: Colors.white);

  _Banner({Key? key, required this.selectedDay, required this.count})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      color: PRIMARY_COLOR,
      child: Padding(
        padding: EdgeInsets.symmetric(horizontal: 15, vertical: 10),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(
              "${selectedDay.year}년 ${selectedDay.month}월 ${selectedDay.day}일",
              style: bannerTextStyle,
            ),
            Text(
              "${count}개",
              style: bannerTextStyle,
            ),
          ],
        ),
      ),
    );
  }
}

class _ScheduledCard extends StatelessWidget {
  final DateTime startDate;
  final DateTime endDate;
  final Color categoryColor;
  final String agenda;

  TextStyle textStyle =
      TextStyle(color: PRIMARY_COLOR, fontWeight: FontWeight.w500);

  _ScheduledCard(
      {Key? key,
      required this.startDate,
      required this.endDate,
      required this.agenda,
      required this.categoryColor})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 12),
      child: Container(
        decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(6.0),
            border: Border.all(width: 1, color: PRIMARY_COLOR)),
        padding: EdgeInsets.symmetric(vertical: 8, horizontal: 12),
        child: IntrinsicHeight(
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    "${startDate.hour.toString().padLeft(2, "0")}:${startDate.minute.toString().padLeft(2, "0")}",
                    style: textStyle.copyWith(fontSize: 20),
                  ),
                  Text(
                    "${endDate.hour.toString().padLeft(2, "0")}:${endDate.minute.toString().padLeft(2, "0")}",
                    style: textStyle.copyWith(fontSize: 14),
                  ),
                ],
              ),
              Expanded(
                child: Padding(
                    padding: EdgeInsets.symmetric(horizontal: 15, vertical: 2),
                    child: Text(
                      agenda,
                      style: TextStyle(fontSize: 15.5),
                    )),
              ),
              Container(
                width: 16,
                height: 16,
                decoration:
                    BoxDecoration(color: categoryColor, shape: BoxShape.circle),
              )
            ],
          ),
        ),
      ),
    );
  }
}

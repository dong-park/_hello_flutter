import 'package:drift/drift.dart';

import 'category_color.dart';

class Schedules extends Table {

  //pk
  IntColumn get id => integer().autoIncrement()();

  //내용
  TextColumn get content => text()();

  //일정날짜
  DateTimeColumn get date => dateTime()();

  //시작시간
  DateTimeColumn get startTime => dateTime()();

  //마감시간
  DateTimeColumn get endTime => dateTime()();

  //카테고리컬러id
  TextColumn get colorId => text().nullable().references(CategoryColors, #color)();

  //생성날짜
  DateTimeColumn get createdAt => dateTime().withDefault(currentDateAndTime)();

}

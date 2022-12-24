import 'package:drift/drift.dart';

class CategoryColors extends Table {
  //pk
  IntColumn get id => integer().autoIncrement()();

  //색상
  TextColumn get color => text().unique()();

  //생성날짜
  DateTimeColumn get createdAt => dateTime().withDefault(currentDateAndTime)();
}

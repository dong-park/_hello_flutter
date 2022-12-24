import 'dart:io';

import 'package:drift/drift.dart';
import 'package:drift/native.dart';
import 'package:path/path.dart' as p;
import 'package:path_provider/path_provider.dart';

import '../model/category_color.dart';
import '../model/schedule.dart';
import '../model/schedule_with_color.dart';

part 'drift_database.g.dart';

@DriftDatabase(tables: [Schedules, CategoryColors])
class LocalDatabase extends _$LocalDatabase {
  LocalDatabase() : super(_openConnection());

  createSchedule(SchedulesCompanion schedule) => into(schedules).insert(schedule);

  createCategoryColor(CategoryColorsCompanion categoryColor) => into(categoryColors).insert(categoryColor);

  getAllSchedules() => select(schedules).get();

  getAllCategoryColors() => select(categoryColors).get();

  watchAllScheduled() => select(schedules).watch();

  @override
  int get schemaVersion => 1;

  Stream<List<ScheduleWithColor>> watchSelectedSchedule(DateTime selectedDay) {
    final query = select(schedules).join([
      innerJoin(
          categoryColors, categoryColors.color.equalsExp(schedules.colorId))
    ]);

    query.where(schedules.date.equals(DateTime(selectedDay.year, selectedDay.month, selectedDay.day)));

    final result = query.watch().map((rows) {
      return rows.map((row) {
        return ScheduleWithColor(
            schedule: row.readTable(schedules),
            color: row.readTable(categoryColors));
      }).toList();
    });

    return result;
  }

  void deleteSchedule(Schedule schedule) {
    delete(schedules).delete(schedule);
  }
}

LazyDatabase _openConnection() {
  return LazyDatabase(() async {
    final dbFolder = await getApplicationDocumentsDirectory();
    final file = File(p.join(dbFolder.path, 'db.sqlite'));
    return NativeDatabase(file);
  });
}

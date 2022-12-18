import 'dart:io';

import 'package:drift/drift.dart';
import 'package:drift/native.dart';
import 'package:path/path.dart' as p;
import 'package:path_provider/path_provider.dart';

import '../model/category_color.dart';
import '../model/schedule.dart';

part 'drift_database.g.dart';

@DriftDatabase(tables: [Schedules, CategoryColors])
class LocalDatabase extends _$LocalDatabase {
  LocalDatabase() : super(_openConnection());

  createSchedule(SchedulesCompanion schedule) => into(schedules).insert(schedule);
  createCategoryColor(CategoryColorsCompanion categoryColor) => into(categoryColors).insert(categoryColor);
  getAllSchedules() => select(schedules).get();
  getAllCategoryColors() => select(categoryColors).get();

  @override
  int get schemaVersion => 1;
}

LazyDatabase _openConnection() {
  return LazyDatabase(() async {
    final dbFolder = await getApplicationDocumentsDirectory();
    final file = File(p.join(dbFolder.path, 'db.sqlite'));
    return NativeDatabase(file);
  });
}

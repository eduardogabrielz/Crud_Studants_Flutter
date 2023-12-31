import 'package:drift/drift.dart';
import 'package:drift/wasm.dart';

part 'drift.g.dart';

@UseRowClass(Student)
class Students extends Table {
  IntColumn get id => integer().autoIncrement()();
  TextColumn get name => text()();
  TextColumn get cpf => text().withLength(min: 11, max: 11)();
  TextColumn get ra => text().withLength(min: 5, max: 5)();
  TextColumn get age => text()();
  TextColumn get avatar => text()();
  TextColumn get course => text()();
  IntColumn get collegeId => integer().references(Colleges, #id)();
}

class Student {
  final int id;
  final String name;
  final String cpf;
  final String ra;
  final String age;
  final String avatar;
  final String course;
  final int collegeId;

  Student(
      {required this.id,
      required this.name,
      required this.cpf,
      required this.ra,
      required this.age,
      required this.avatar,
      required this.course,
      required this.collegeId});
}

@UseRowClass(College)
class Colleges extends Table {
  IntColumn get id => integer().autoIncrement()();
  TextColumn get email => text()();
  TextColumn get password => text()();
}

class College {
  final int id;
  final String email;
  final String password;

  College({
    required this.id,
    required this.email,
    required this.password,
  });
}

@DriftDatabase(tables: [Students, Colleges])
class AppDatabase extends _$AppDatabase {
  AppDatabase() : super(_openConnection());

  @override
  int get schemaVersion => 1;

  Future<List<Student>> viewStudents() => select(students).get();
  Future<int> insertStudents(StudentsCompanion student) =>
      into(students).insert(student);
  Future updateStudents(StudentsCompanion student) =>
      update(students).replace(student);
  Future deleteStudents(StudentsCompanion student) =>
      delete(students).delete(student);

  Future<List<College>> viewColleges() => select(colleges).get();
  Future<int> insertCollege(CollegesCompanion college) =>
      into(colleges).insert(college);
}

DatabaseConnection _openConnection() {
  return DatabaseConnection.delayed(Future(() async {
    final db = await WasmDatabase.open(
      databaseName: 'students_list',
      sqlite3Uri: Uri.parse('sqlite3.wasm'),
      driftWorkerUri: Uri.parse('drift_worker.dart.js'),
    );

    if (db.missingFeatures.isNotEmpty) {
      print('error - missing features');
    }

    return db.resolvedExecutor;
  }));
}

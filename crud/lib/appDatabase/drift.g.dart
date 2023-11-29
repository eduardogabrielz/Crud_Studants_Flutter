// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'drift.dart';

// ignore_for_file: type=lint
class $CollegesTable extends Colleges with TableInfo<$CollegesTable, College> {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;
  $CollegesTable(this.attachedDatabase, [this._alias]);
  static const VerificationMeta _idMeta = const VerificationMeta('id');
  @override
  late final GeneratedColumn<int> id = GeneratedColumn<int>(
      'id', aliasedName, false,
      hasAutoIncrement: true,
      type: DriftSqlType.int,
      requiredDuringInsert: false,
      defaultConstraints:
          GeneratedColumn.constraintIsAlways('PRIMARY KEY AUTOINCREMENT'));
  static const VerificationMeta _emailMeta = const VerificationMeta('email');
  @override
  late final GeneratedColumn<String> email = GeneratedColumn<String>(
      'email', aliasedName, false,
      type: DriftSqlType.string, requiredDuringInsert: true);
  static const VerificationMeta _passwordMeta =
      const VerificationMeta('password');
  @override
  late final GeneratedColumn<String> password = GeneratedColumn<String>(
      'password', aliasedName, false,
      type: DriftSqlType.string, requiredDuringInsert: true);
  @override
  List<GeneratedColumn> get $columns => [id, email, password];
  @override
  String get aliasedName => _alias ?? actualTableName;
  @override
  String get actualTableName => $name;
  static const String $name = 'colleges';
  @override
  VerificationContext validateIntegrity(Insertable<College> instance,
      {bool isInserting = false}) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('id')) {
      context.handle(_idMeta, id.isAcceptableOrUnknown(data['id']!, _idMeta));
    }
    if (data.containsKey('email')) {
      context.handle(
          _emailMeta, email.isAcceptableOrUnknown(data['email']!, _emailMeta));
    } else if (isInserting) {
      context.missing(_emailMeta);
    }
    if (data.containsKey('password')) {
      context.handle(_passwordMeta,
          password.isAcceptableOrUnknown(data['password']!, _passwordMeta));
    } else if (isInserting) {
      context.missing(_passwordMeta);
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => {id};
  @override
  College map(Map<String, dynamic> data, {String? tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';
    return College(
      id: attachedDatabase.typeMapping
          .read(DriftSqlType.int, data['${effectivePrefix}id'])!,
      email: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}email'])!,
      password: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}password'])!,
    );
  }

  @override
  $CollegesTable createAlias(String alias) {
    return $CollegesTable(attachedDatabase, alias);
  }
}

class CollegesCompanion extends UpdateCompanion<College> {
  final Value<int> id;
  final Value<String> email;
  final Value<String> password;
  const CollegesCompanion({
    this.id = const Value.absent(),
    this.email = const Value.absent(),
    this.password = const Value.absent(),
  });
  CollegesCompanion.insert({
    this.id = const Value.absent(),
    required String email,
    required String password,
  })  : email = Value(email),
        password = Value(password);
  static Insertable<College> custom({
    Expression<int>? id,
    Expression<String>? email,
    Expression<String>? password,
  }) {
    return RawValuesInsertable({
      if (id != null) 'id': id,
      if (email != null) 'email': email,
      if (password != null) 'password': password,
    });
  }

  CollegesCompanion copyWith(
      {Value<int>? id, Value<String>? email, Value<String>? password}) {
    return CollegesCompanion(
      id: id ?? this.id,
      email: email ?? this.email,
      password: password ?? this.password,
    );
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (id.present) {
      map['id'] = Variable<int>(id.value);
    }
    if (email.present) {
      map['email'] = Variable<String>(email.value);
    }
    if (password.present) {
      map['password'] = Variable<String>(password.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('CollegesCompanion(')
          ..write('id: $id, ')
          ..write('email: $email, ')
          ..write('password: $password')
          ..write(')'))
        .toString();
  }
}

class $StudentsTable extends Students with TableInfo<$StudentsTable, Student> {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;
  $StudentsTable(this.attachedDatabase, [this._alias]);
  static const VerificationMeta _idMeta = const VerificationMeta('id');
  @override
  late final GeneratedColumn<int> id = GeneratedColumn<int>(
      'id', aliasedName, false,
      hasAutoIncrement: true,
      type: DriftSqlType.int,
      requiredDuringInsert: false,
      defaultConstraints:
          GeneratedColumn.constraintIsAlways('PRIMARY KEY AUTOINCREMENT'));
  static const VerificationMeta _nameMeta = const VerificationMeta('name');
  @override
  late final GeneratedColumn<String> name = GeneratedColumn<String>(
      'name', aliasedName, false,
      type: DriftSqlType.string, requiredDuringInsert: true);
  static const VerificationMeta _cpfMeta = const VerificationMeta('cpf');
  @override
  late final GeneratedColumn<String> cpf = GeneratedColumn<String>(
      'cpf', aliasedName, false,
      additionalChecks:
          GeneratedColumn.checkTextLength(minTextLength: 11, maxTextLength: 11),
      type: DriftSqlType.string,
      requiredDuringInsert: true);
  static const VerificationMeta _raMeta = const VerificationMeta('ra');
  @override
  late final GeneratedColumn<String> ra = GeneratedColumn<String>(
      'ra', aliasedName, false,
      additionalChecks:
          GeneratedColumn.checkTextLength(minTextLength: 5, maxTextLength: 5),
      type: DriftSqlType.string,
      requiredDuringInsert: true);
  static const VerificationMeta _ageMeta = const VerificationMeta('age');
  @override
  late final GeneratedColumn<String> age = GeneratedColumn<String>(
      'age', aliasedName, false,
      type: DriftSqlType.string, requiredDuringInsert: true);
  static const VerificationMeta _avatarMeta = const VerificationMeta('avatar');
  @override
  late final GeneratedColumn<String> avatar = GeneratedColumn<String>(
      'avatar', aliasedName, false,
      type: DriftSqlType.string, requiredDuringInsert: true);
  static const VerificationMeta _courseMeta = const VerificationMeta('course');
  @override
  late final GeneratedColumn<String> course = GeneratedColumn<String>(
      'course', aliasedName, false,
      type: DriftSqlType.string, requiredDuringInsert: true);
  static const VerificationMeta _collegeIdMeta =
      const VerificationMeta('collegeId');
  @override
  late final GeneratedColumn<int> collegeId = GeneratedColumn<int>(
      'college_id', aliasedName, false,
      type: DriftSqlType.int,
      requiredDuringInsert: true,
      defaultConstraints:
          GeneratedColumn.constraintIsAlways('REFERENCES colleges (id)'));
  @override
  List<GeneratedColumn> get $columns =>
      [id, name, cpf, ra, age, avatar, course, collegeId];
  @override
  String get aliasedName => _alias ?? actualTableName;
  @override
  String get actualTableName => $name;
  static const String $name = 'students';
  @override
  VerificationContext validateIntegrity(Insertable<Student> instance,
      {bool isInserting = false}) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('id')) {
      context.handle(_idMeta, id.isAcceptableOrUnknown(data['id']!, _idMeta));
    }
    if (data.containsKey('name')) {
      context.handle(
          _nameMeta, name.isAcceptableOrUnknown(data['name']!, _nameMeta));
    } else if (isInserting) {
      context.missing(_nameMeta);
    }
    if (data.containsKey('cpf')) {
      context.handle(
          _cpfMeta, cpf.isAcceptableOrUnknown(data['cpf']!, _cpfMeta));
    } else if (isInserting) {
      context.missing(_cpfMeta);
    }
    if (data.containsKey('ra')) {
      context.handle(_raMeta, ra.isAcceptableOrUnknown(data['ra']!, _raMeta));
    } else if (isInserting) {
      context.missing(_raMeta);
    }
    if (data.containsKey('age')) {
      context.handle(
          _ageMeta, age.isAcceptableOrUnknown(data['age']!, _ageMeta));
    } else if (isInserting) {
      context.missing(_ageMeta);
    }
    if (data.containsKey('avatar')) {
      context.handle(_avatarMeta,
          avatar.isAcceptableOrUnknown(data['avatar']!, _avatarMeta));
    } else if (isInserting) {
      context.missing(_avatarMeta);
    }
    if (data.containsKey('course')) {
      context.handle(_courseMeta,
          course.isAcceptableOrUnknown(data['course']!, _courseMeta));
    } else if (isInserting) {
      context.missing(_courseMeta);
    }
    if (data.containsKey('college_id')) {
      context.handle(_collegeIdMeta,
          collegeId.isAcceptableOrUnknown(data['college_id']!, _collegeIdMeta));
    } else if (isInserting) {
      context.missing(_collegeIdMeta);
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => {id};
  @override
  Student map(Map<String, dynamic> data, {String? tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';
    return Student(
      id: attachedDatabase.typeMapping
          .read(DriftSqlType.int, data['${effectivePrefix}id'])!,
      name: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}name'])!,
      cpf: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}cpf'])!,
      ra: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}ra'])!,
      age: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}age'])!,
      avatar: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}avatar'])!,
      course: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}course'])!,
      collegeId: attachedDatabase.typeMapping
          .read(DriftSqlType.int, data['${effectivePrefix}college_id'])!,
    );
  }

  @override
  $StudentsTable createAlias(String alias) {
    return $StudentsTable(attachedDatabase, alias);
  }
}

class StudentsCompanion extends UpdateCompanion<Student> {
  final Value<int> id;
  final Value<String> name;
  final Value<String> cpf;
  final Value<String> ra;
  final Value<String> age;
  final Value<String> avatar;
  final Value<String> course;
  final Value<int> collegeId;
  const StudentsCompanion({
    this.id = const Value.absent(),
    this.name = const Value.absent(),
    this.cpf = const Value.absent(),
    this.ra = const Value.absent(),
    this.age = const Value.absent(),
    this.avatar = const Value.absent(),
    this.course = const Value.absent(),
    this.collegeId = const Value.absent(),
  });
  StudentsCompanion.insert({
    this.id = const Value.absent(),
    required String name,
    required String cpf,
    required String ra,
    required String age,
    required String avatar,
    required String course,
    required int collegeId,
  })  : name = Value(name),
        cpf = Value(cpf),
        ra = Value(ra),
        age = Value(age),
        avatar = Value(avatar),
        course = Value(course),
        collegeId = Value(collegeId);
  static Insertable<Student> custom({
    Expression<int>? id,
    Expression<String>? name,
    Expression<String>? cpf,
    Expression<String>? ra,
    Expression<String>? age,
    Expression<String>? avatar,
    Expression<String>? course,
    Expression<int>? collegeId,
  }) {
    return RawValuesInsertable({
      if (id != null) 'id': id,
      if (name != null) 'name': name,
      if (cpf != null) 'cpf': cpf,
      if (ra != null) 'ra': ra,
      if (age != null) 'age': age,
      if (avatar != null) 'avatar': avatar,
      if (course != null) 'course': course,
      if (collegeId != null) 'college_id': collegeId,
    });
  }

  StudentsCompanion copyWith(
      {Value<int>? id,
      Value<String>? name,
      Value<String>? cpf,
      Value<String>? ra,
      Value<String>? age,
      Value<String>? avatar,
      Value<String>? course,
      Value<int>? collegeId}) {
    return StudentsCompanion(
      id: id ?? this.id,
      name: name ?? this.name,
      cpf: cpf ?? this.cpf,
      ra: ra ?? this.ra,
      age: age ?? this.age,
      avatar: avatar ?? this.avatar,
      course: course ?? this.course,
      collegeId: collegeId ?? this.collegeId,
    );
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (id.present) {
      map['id'] = Variable<int>(id.value);
    }
    if (name.present) {
      map['name'] = Variable<String>(name.value);
    }
    if (cpf.present) {
      map['cpf'] = Variable<String>(cpf.value);
    }
    if (ra.present) {
      map['ra'] = Variable<String>(ra.value);
    }
    if (age.present) {
      map['age'] = Variable<String>(age.value);
    }
    if (avatar.present) {
      map['avatar'] = Variable<String>(avatar.value);
    }
    if (course.present) {
      map['course'] = Variable<String>(course.value);
    }
    if (collegeId.present) {
      map['college_id'] = Variable<int>(collegeId.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('StudentsCompanion(')
          ..write('id: $id, ')
          ..write('name: $name, ')
          ..write('cpf: $cpf, ')
          ..write('ra: $ra, ')
          ..write('age: $age, ')
          ..write('avatar: $avatar, ')
          ..write('course: $course, ')
          ..write('collegeId: $collegeId')
          ..write(')'))
        .toString();
  }
}

abstract class _$AppDatabase extends GeneratedDatabase {
  _$AppDatabase(QueryExecutor e) : super(e);
  late final $CollegesTable colleges = $CollegesTable(this);
  late final $StudentsTable students = $StudentsTable(this);
  @override
  Iterable<TableInfo<Table, Object?>> get allTables =>
      allSchemaEntities.whereType<TableInfo<Table, Object?>>();
  @override
  List<DatabaseSchemaEntity> get allSchemaEntities => [colleges, students];
}

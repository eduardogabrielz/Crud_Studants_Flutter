import 'package:crud/drift.dart';
import 'package:flutter/material.dart';
import 'package:drift/drift.dart' hide Column;
import 'package:flutter/services.dart';
import 'validate.dart';
import 'updateStudent.dart';
import 'nameCourses.dart';
import 'palette.dart';

void main() {
  runApp(const MyApp());
}

final List<Student> _students = [];
final database = AppDatabase();

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Students List App',
      theme: ThemeData(primarySwatch: Colors.purple),
      home: const HomeScreen(),
    );
  }
}

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: const Text('Home Screen'),
        ),
        body: Center(
          child: ElevatedButton(
            onPressed: () {
              Navigator.of(context).push(MaterialPageRoute(
                builder: (context) => const StudentsListScreen(),
              ));
            },
            child: const Text('Start Student List'),
          ),
        ));
  }
}

class StudentsListScreen extends StatefulWidget {
  const StudentsListScreen({super.key});

  @override
  StudentsListScreenState createState() => StudentsListScreenState();
}

class StudentsListScreenState extends State<StudentsListScreen> {
  @override
  void initState() {
    super.initState();
    _loadStudents();
  }

  Future<void> _loadStudents() async {
    await database.viewStudents().then((students) {
      setState(
        () {
          _students.clear();
          _students.addAll(students);
        },
      );
    });
  }

  Future<void> _removeStudent(Student student) async {
    await database
        .deleteStudents(
          StudentsCompanion(
              id: Value(student.id),
              name: Value(student.name),
              ra: Value(student.ra),
              cpf: Value(student.cpf),
              age: Value(student.age),
              avatar: Value(student.avatar),
              course: Value(student.course)),
        )
        .then((_) => _loadStudents());
  }

  Future<void> _addStudents(String name, String ra, String cpf, String age,
      String avatar, String course) async {
    final newStudent = StudentsCompanion.insert(
        name: name, ra: ra, cpf: cpf, age: age, avatar: avatar, course: course);

    await database.insertStudents(newStudent).then((_) {
      _loadStudents();
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Students List')),
      body: Column(
        children: [
          ListView.builder(
            shrinkWrap: true,
            itemCount: _students.length,
            itemBuilder: (context, i) {
              final avatar = CircleAvatar(
                backgroundColor: ColorPalette.iconColor,
                radius: 20,
                child: CircleAvatar(
                  backgroundImage: NetworkImage(_students[i].avatar),
                  radius: 19,
                ),
              );
              return Container(
                margin: const EdgeInsets.all(5.0),
                decoration: BoxDecoration(
                  color: ColorPalette.cardColor,
                  borderRadius: BorderRadius.circular(6.0),
                  border: Border.all(
                    color: const Color(0xFF000000),
                    width: 1,
                  ),
                  boxShadow: const [
                    BoxShadow(
                      color: ColorPalette.borderColorInput,
                      blurRadius: 5,
                      offset: Offset(0, 2),
                    ),
                  ],
                ),
                child: ListTile(
                  textColor: const Color(0xFFFFFFFF),
                  leading: avatar,
                  title: Text(
                      'Name: ${_students[i].name} | Age: ${_students[i].age}'),
                  subtitle: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        'Cpf: ${_students[i].cpf} | Ra: ${_students[i].ra}',
                      ),
                      Text(
                        'Course: ${_students[i].course}',
                      ),
                    ],
                  ),
                  trailing: SizedBox(
                    width: 100,
                    child: Row(
                      children: [
                        IconButton(
                          onPressed: () async {
                            final result = await Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (context) =>
                                    EditStudentScreen(student: _students[i]),
                              ),
                            );
                            if (result != null) {
                              setState(() {
                                _students[i] = result;
                              });
                            }
                          },
                          color: ColorPalette.iconColor,
                          icon: const Icon(Icons.edit),
                        ),
                        IconButton(
                          onPressed: () {
                            _removeStudent(_students[i]);
                          },
                          color: ColorPalette.iconColor,
                          icon: const Icon(Icons.delete),
                        ),
                      ],
                    ),
                  ),
                ),
              );
            },
          ),
        ],
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          TextEditingController nameController = TextEditingController();
          TextEditingController ageController = TextEditingController();
          TextEditingController cpfController = TextEditingController();
          TextEditingController raController = TextEditingController();
          TextEditingController avatarController = TextEditingController();
          TextEditingController courseController = TextEditingController();
          showDialog(
            context: context,
            builder: (BuildContext context) => Center(
                child: SizedBox(
                    width: 450,
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: <Widget>[
                        AlertDialog(
                          title: const Text('Add Student'),
                          content: Column(children: [
                            Padding(
                              padding: const EdgeInsets.symmetric(vertical: 5),
                              child: TextField(
                                decoration: InputDecoration(
                                    labelText: 'Name',
                                    labelStyle: const TextStyle(
                                        color: ColorPalette.textColor),
                                    enabledBorder: OutlineInputBorder(
                                        borderRadius: BorderRadius.circular(21),
                                        borderSide: const BorderSide(
                                            color:
                                                ColorPalette.borderColorInput,
                                            width: 2)),
                                    focusedBorder: OutlineInputBorder(
                                      borderRadius: BorderRadius.circular(21),
                                      borderSide: const BorderSide(
                                          color: ColorPalette
                                              .borderColorInputActivate,
                                          width: 2),
                                    )),
                                controller: nameController,
                              ),
                            ),
                            Padding(
                              padding: const EdgeInsets.symmetric(vertical: 5),
                              child: TextField(
                                decoration: InputDecoration(
                                    labelText: 'Age',
                                    labelStyle: const TextStyle(
                                        color: ColorPalette.textColor),
                                    enabledBorder: OutlineInputBorder(
                                        borderRadius: BorderRadius.circular(21),
                                        borderSide: const BorderSide(
                                            color:
                                                ColorPalette.borderColorInput,
                                            width: 2)),
                                    focusedBorder: OutlineInputBorder(
                                        borderRadius: BorderRadius.circular(21),
                                        borderSide: const BorderSide(
                                            color: ColorPalette
                                                .borderColorInputActivate,
                                            width: 2))),
                                inputFormatters: [
                                  LengthLimitingTextInputFormatter(2)
                                ],
                                controller: ageController,
                              ),
                            ),
                            Padding(
                              padding: const EdgeInsets.symmetric(vertical: 5),
                              child: TextField(
                                decoration: InputDecoration(
                                    labelText: 'Cpf',
                                    labelStyle: const TextStyle(
                                        color: ColorPalette.textColor),
                                    enabledBorder: OutlineInputBorder(
                                        borderRadius: BorderRadius.circular(21),
                                        borderSide: const BorderSide(
                                            color:
                                                ColorPalette.borderColorInput,
                                            width: 2)),
                                    focusedBorder: OutlineInputBorder(
                                        borderRadius: BorderRadius.circular(21),
                                        borderSide: const BorderSide(
                                            color: ColorPalette
                                                .borderColorInputActivate,
                                            width: 2))),
                                inputFormatters: [
                                  LengthLimitingTextInputFormatter(11)
                                ],
                                controller: cpfController,
                              ),
                            ),
                            Padding(
                              padding: const EdgeInsets.all(5),
                              child: TextField(
                                decoration: InputDecoration(
                                    labelText: 'Ra',
                                    labelStyle: const TextStyle(
                                        color: ColorPalette.textColor),
                                    enabledBorder: OutlineInputBorder(
                                        borderRadius: BorderRadius.circular(21),
                                        borderSide: const BorderSide(
                                            color:
                                                ColorPalette.borderColorInput,
                                            width: 2)),
                                    focusedBorder: OutlineInputBorder(
                                        borderRadius: BorderRadius.circular(21),
                                        borderSide: const BorderSide(
                                            color: ColorPalette
                                                .borderColorInputActivate,
                                            width: 2))),
                                inputFormatters: [
                                  LengthLimitingTextInputFormatter(5)
                                ],
                                controller: raController,
                              ),
                            ),
                            Padding(
                              padding: const EdgeInsets.symmetric(vertical: 5),
                              child: DropdownButtonFormField<String>(
                                decoration: InputDecoration(
                                    labelText: 'Course',
                                    labelStyle: const TextStyle(
                                        color: ColorPalette.textColor),
                                    enabledBorder: OutlineInputBorder(
                                        borderRadius: BorderRadius.circular(21),
                                        borderSide: const BorderSide(
                                            color:
                                                ColorPalette.borderColorInput,
                                            width: 2))),
                                items: nameCourses
                                    .map<DropdownMenuItem<String>>((value) {
                                  return DropdownMenuItem<String>(
                                    value: value,
                                    child: Text(value),
                                  );
                                }).toList(),
                                onChanged: (selectedCourse) {
                                  courseController.text = selectedCourse!;
                                },
                              ),
                            ),
                            Padding(
                              padding: const EdgeInsets.symmetric(vertical: 5),
                              child: TextField(
                                decoration: InputDecoration(
                                    labelText: 'Avatar',
                                    labelStyle: const TextStyle(
                                        color: ColorPalette.textColor),
                                    enabledBorder: OutlineInputBorder(
                                        borderRadius: BorderRadius.circular(21),
                                        borderSide: const BorderSide(
                                            color:
                                                ColorPalette.borderColorInput,
                                            width: 2)),
                                    focusedBorder: OutlineInputBorder(
                                        borderRadius: BorderRadius.circular(21),
                                        borderSide: const BorderSide(
                                            color: ColorPalette
                                                .borderColorInputActivate,
                                            width: 2))),
                                controller: avatarController,
                              ),
                            ),
                          ]),
                          actions: [
                            TextButton(
                              onPressed: () {
                                Navigator.of(context).pop();
                              },
                              child: const Text('Cancel'),
                            ),
                            TextButton(
                              onPressed: () {
                                String name = nameController.text;
                                String age = ageController.text;
                                String cpf = cpfController.text;
                                String ra = raController.text;
                                String avatar = avatarController.text;
                                String course = courseController.text;
                                if (isValidName(name) ||
                                    isValidAge(age) ||
                                    isValidCpf(cpf) ||
                                    isValidRa(ra) ||
                                    isValidAvatar(avatar)) {
                                  showDialog(
                                    context: context,
                                    builder: (BuildContext context) {
                                      return AlertDialog(
                                        title: const Text("Warning"),
                                        content: const Text("Invalid student"),
                                        actions: <Widget>[
                                          TextButton(
                                            child: const Text("Exit"),
                                            onPressed: () {
                                              Navigator.of(context).pop();
                                            },
                                          ),
                                        ],
                                      );
                                    },
                                  );
                                } else {
                                  _addStudents(
                                      name, ra, cpf, age, avatar, course);
                                  Navigator.of(context).pop();
                                  nameController.clear();
                                  ageController.clear();
                                  cpfController.clear();
                                  raController.clear();
                                  avatarController.clear();
                                  courseController.clear();
                                }
                              },
                              child: const Text('Save'),
                            ),
                          ],
                        )
                      ],
                    ))),
          );
        },
        backgroundColor: const Color(0xFF522151),
        child: const Icon(Icons.add),
      ),
    );
  }
}

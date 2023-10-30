import 'package:crud/main.dart';
import 'package:crud/palette.dart';
import 'package:drift/drift.dart';
import 'package:flutter/material.dart';
import 'package:crud/drift.dart';
import 'package:crud/validate.dart';
import 'package:flutter/services.dart';
import 'nameCourses.dart';

class EditStudentScreen extends StatefulWidget {
  final Student student;

  const EditStudentScreen({Key? key, required this.student}) : super(key: key);

  @override
  EditStudentScreenState createState() => EditStudentScreenState();
}

class EditStudentScreenState extends State<EditStudentScreen> {
  final TextEditingController idController = TextEditingController();
  final TextEditingController nameControllerAlter = TextEditingController();
  final TextEditingController ageControllerAlter = TextEditingController();
  final TextEditingController cpfControllerAlter = TextEditingController();
  final TextEditingController raControllerAlter = TextEditingController();
  final TextEditingController avatarControllerAlter = TextEditingController();
  final TextEditingController courseControllerAlter = TextEditingController();

  @override
  void initState() {
    super.initState();
    idController.text = widget.student.id.toString();
    nameControllerAlter.text = widget.student.name;
    ageControllerAlter.text = widget.student.age;
    cpfControllerAlter.text = widget.student.cpf;
    raControllerAlter.text = widget.student.ra;
    avatarControllerAlter.text = widget.student.avatar;
    courseControllerAlter.text = widget.student.course;
  }

  String? initialCourseValue;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Update Student'),
      ),
      body: Center(
        child: ListView(
          children: [
            Container(
              width: 450,
              decoration: const BoxDecoration(
                color: Color(0xFF6c2d6a),
                borderRadius: BorderRadius.only(
                  bottomLeft: Radius.circular(20),
                  bottomRight: Radius.circular(20),
                ),
              ),
              child: CircleAvatar(
                radius: 100,
                backgroundColor: ColorPalette.iconColor,
                child: CircleAvatar(
                  radius: 95,
                  backgroundImage: NetworkImage(avatarControllerAlter.text),
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(5),
              child: TextField(
                decoration: InputDecoration(
                    labelText: 'Name',
                    labelStyle: const TextStyle(color: ColorPalette.textColor),
                    enabledBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(21),
                        borderSide: const BorderSide(
                            color: ColorPalette.borderColorInput, width: 2)),
                    focusedBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(21),
                        borderSide: const BorderSide(
                            color: ColorPalette.borderColorInputActivate,
                            width: 2))),
                controller: nameControllerAlter,
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(5),
              child: TextField(
                decoration: InputDecoration(
                    labelText: 'Age',
                    labelStyle: const TextStyle(color: ColorPalette.textColor),
                    enabledBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(21),
                        borderSide: const BorderSide(
                            color: ColorPalette.borderColorInput, width: 2)),
                    focusedBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(21),
                        borderSide: const BorderSide(
                            color: ColorPalette.borderColorInputActivate,
                            width: 2))),
                inputFormatters: [LengthLimitingTextInputFormatter(2)],
                controller: ageControllerAlter,
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(5),
              child: TextField(
                decoration: InputDecoration(
                    labelText: 'Cpf',
                    labelStyle: const TextStyle(color: ColorPalette.textColor),
                    enabledBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(21),
                        borderSide: const BorderSide(
                            color: ColorPalette.borderColorInput, width: 2)),
                    focusedBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(21),
                        borderSide: const BorderSide(
                            color: ColorPalette.borderColorInputActivate,
                            width: 2))),
                inputFormatters: [LengthLimitingTextInputFormatter(11)],
                controller: cpfControllerAlter,
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(5),
              child: TextField(
                decoration: InputDecoration(
                    labelText: 'Ra',
                    labelStyle: const TextStyle(color: ColorPalette.textColor),
                    enabledBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(21),
                        borderSide: const BorderSide(
                            color: ColorPalette.borderColorInput, width: 2)),
                    focusedBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(21),
                        borderSide: const BorderSide(
                            color: ColorPalette.borderColorInputActivate,
                            width: 2))),
                inputFormatters: [LengthLimitingTextInputFormatter(5)],
                controller: raControllerAlter,
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(5),
              child: DropdownButtonFormField<String>(
                value: courseControllerAlter.text,
                decoration: InputDecoration(
                    labelText: 'Course',
                    labelStyle: const TextStyle(color: ColorPalette.textColor),
                    enabledBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(21),
                        borderSide: const BorderSide(
                            color: ColorPalette.borderColorInput, width: 2))),
                items: nameCourses.map<DropdownMenuItem<String>>((value) {
                  return DropdownMenuItem<String>(
                    value: value,
                    child: Text(value),
                  );
                }).toList(),
                onChanged: (selectedCourse) {
                  courseControllerAlter.text = selectedCourse!;
                },
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(5),
              child: TextField(
                  decoration: InputDecoration(
                      labelText: 'Avatar',
                      labelStyle:
                          const TextStyle(color: ColorPalette.textColor),
                      enabledBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(21),
                          borderSide: const BorderSide(
                              color: ColorPalette.borderColorInput, width: 2)),
                      focusedBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(21),
                          borderSide: const BorderSide(
                              color: ColorPalette.borderColorInputActivate,
                              width: 2))),
                  controller: avatarControllerAlter,
                  onChanged: (avatarControllerAlter) {
                    setState(() {
                      avatarControllerAlter;
                    });
                  }),
            ),
            Center(
                child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                ElevatedButton(
                  onPressed: () async {
                    int id = int.parse(idController.text);
                    String alteredName = nameControllerAlter.text;
                    String alteredAge = ageControllerAlter.text;
                    String alteredCpf = cpfControllerAlter.text;
                    String alteredRa = raControllerAlter.text;
                    String alteredCourse = courseControllerAlter.text;
                    String alteredAvatar = avatarControllerAlter.text;

                    if (isValidName(alteredName) ||
                        isValidAge(alteredAge) ||
                        isValidCpf(alteredCpf) ||
                        isValidRa(alteredRa) ||
                        isValidAvatar(alteredAvatar)) {
                      showDialog(
                          context: context,
                          builder: (BuildContext context) {
                            return AlertDialog(
                              title: const Text('Warning'),
                              content: const Text('Invalid update student'),
                              actions: <Widget>[
                                TextButton(
                                  child: const Text("Exit"),
                                  onPressed: () {
                                    Navigator.of(context).pop();
                                  },
                                )
                              ],
                            );
                          });
                    } else {
                      database.updateStudents(
                        StudentsCompanion(
                            id: Value(id),
                            name: Value(alteredName),
                            age: Value(alteredAge),
                            cpf: Value(alteredCpf),
                            ra: Value(alteredRa),
                            avatar: Value(alteredAvatar),
                            course: Value(alteredCourse)),
                      );
                      Navigator.pop(
                          context,
                          Student(
                              id: id,
                              name: alteredName,
                              cpf: alteredCpf,
                              ra: alteredRa,
                              age: alteredAge,
                              avatar: alteredAvatar,
                              course: alteredCourse,
                              ));
                    }
                  },
                  style: ButtonStyle(
                    backgroundColor:
                        MaterialStateProperty.all(const Color(0xFF522151)),
                    shape: MaterialStateProperty.all<RoundedRectangleBorder>(
                      RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(10),
                      ),
                    ),
                  ),
                  child: const Text('Save'),
                ),
                const SizedBox(width: 15),
                ElevatedButton(
                  onPressed: () {
                    setState(() {
                      List<TextEditingController> controllersToClear = [
                        nameControllerAlter,
                        ageControllerAlter,
                        cpfControllerAlter,
                        raControllerAlter,
                        avatarControllerAlter,
                      ];

                      for (var controller in controllersToClear) {
                        controller.clear();
                      }
                    });
                  },
                  style: ButtonStyle(
                    backgroundColor: MaterialStateProperty.all(
                      const Color(0xFF8D2E8B),
                    ),
                    shape: MaterialStateProperty.all<RoundedRectangleBorder>(
                      RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(10),
                      ),
                    ),
                  ),
                  child: const Text('Clear'),
                ),
              ],
            )),
          ],
        ),
      ),
    );
  }
}

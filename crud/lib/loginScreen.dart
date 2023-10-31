import 'package:crud/drift.dart';
import 'package:crud/main.dart';
import 'package:crud/validate.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import 'palette.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({Key? key}) : super(key: key);

  @override
  LoginScreenState createState() => LoginScreenState();
}

final List<College> _colleges = [];
final database = AppDatabase();

TextEditingController emailController = TextEditingController();
TextEditingController passwordController = TextEditingController();

class LoginScreenState extends State<LoginScreen> {
  @override
  void initState() {
    super.initState();
    _loadColleges();
  }

  bool passwordObscured = true;

  Future<void> _addPersons(String email, String password) async {
    final newCollege =
        CollegesCompanion.insert(email: email, password: password);

    await database.insertCollege(newCollege).then((_) {
      _loadColleges();
    });
  }

  Future<void> _loadColleges() async {
    await database.viewColleges().then((colleges) {
      setState(
        () {
          _colleges.clear();
          _colleges.addAll(colleges);
        },
      );
    });
  }

  void registerCollege() {
    TextEditingController emailController = TextEditingController();
    TextEditingController passwordController = TextEditingController();

    showDialog(
        context: context,
        builder: (BuildContext context) => Center(
            child: SizedBox(
                width: 450,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: <Widget>[
                    AlertDialog(
                      title: const Text('Register College'),
                      content: Column(children: [
                        Padding(
                          padding: const EdgeInsets.symmetric(vertical: 5),
                          child: TextField(
                            decoration: InputDecoration(
                              labelText: 'Email',
                              labelStyle: const TextStyle(
                                  color: ColorPalette.textColor),
                              enabledBorder: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(21),
                                  borderSide: const BorderSide(
                                      color: ColorPalette.borderColorInput,
                                      width: 2)),
                              focusedBorder: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(21),
                                borderSide: const BorderSide(
                                    color:
                                        ColorPalette.borderColorInputActivate,
                                    width: 2),
                              ),
                            ),
                            controller: emailController,
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.symmetric(vertical: 5),
                          child: TextField(
                            decoration: InputDecoration(
                              labelText: 'Password',
                              hintText: 'Maximun 10 Characters',
                              labelStyle: const TextStyle(
                                  color: ColorPalette.textColor),
                              enabledBorder: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(21),
                                  borderSide: const BorderSide(
                                      color: ColorPalette.borderColorInput,
                                      width: 2)),
                              focusedBorder: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(21),
                                  borderSide: const BorderSide(
                                      color:
                                          ColorPalette.borderColorInputActivate,
                                      width: 2)),
                            ),
                            controller: passwordController,
                            inputFormatters: [
                              LengthLimitingTextInputFormatter(10)
                            ],
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
                            String email = emailController.text;
                            String password = passwordController.text;

                            if (isValidEmail(email) ||
                                isValidPassword(password)) {
                              showDialog(
                                context: context,
                                builder: (BuildContext context) {
                                  return AlertDialog(
                                    title: const Text("Warning"),
                                    content:
                                        const Text("Email Or Password Invalid"),
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
                              _addPersons(email, password);
                              Navigator.of(context).pop();
                              emailController.clear();
                              passwordController.clear();
                            }
                          },
                          child: const Text('Save'),
                        ),
                      ],
                    )
                  ],
                ))));
  }

  bool isEmailAndPasswordValid(String email, String password) {
    for (var college in _colleges) {
      if (college.email == email && college.password == password) {
        return true;
      }
    }
    return false;
  }

  int getCollegeIdIfEmailAndPasswordValid(String email, String password) {
    for (var college in _colleges) {
      if (college.email == email && college.password == password) {
        return college.id; // Suponha que 'id' seja o campo do ID do colégio.
      }
    }
    return -1; // Retorne -1 se as credenciais não forem válidas.
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Login'),
      ),
      body: Center(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Padding(
                padding: const EdgeInsets.symmetric(vertical: 5),
                child: TextField(
                  decoration: InputDecoration(
                      labelText: 'Email',
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
                  controller: emailController,
                ),
              ),
              Padding(
                padding: const EdgeInsets.symmetric(vertical: 5),
                child: TextField(
                  obscureText: passwordObscured,
                  decoration: InputDecoration(
                      labelText: 'Password',
                      hintText: 'Maximun 10 Characters',
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
                              width: 2)),
                      suffixIcon: IconButton(
                        onPressed: () {
                          setState(() {
                            passwordObscured = !passwordObscured;
                          });
                        },
                        icon: Icon(
                          passwordObscured
                              ? Icons.visibility_off
                              : Icons.visibility,
                          color: ColorPalette.iconColor,
                        ),
                      )),
                  controller: passwordController,
                  inputFormatters: [LengthLimitingTextInputFormatter(10)],
                ),
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  ElevatedButton(
                    onPressed: () {
                      registerCollege();
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
                    child: const Text('Register'),
                  ),
                  const SizedBox(width: 10),
                  ElevatedButton(
                    onPressed: () async {
                      bool isPersonFound = isEmailAndPasswordValid(
                          emailController.text, passwordController.text);
                      if (isPersonFound) {
                        int collegeId = getCollegeIdIfEmailAndPasswordValid(
                            emailController.text, passwordController.text);

                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) =>
                                StudentsListScreen(collegeId: collegeId),
                          ),
                        );

                        emailController.clear();
                        passwordController.clear();
                      } else {
                        showDialog(
                          context: context,
                          builder: (BuildContext context) {
                            return AlertDialog(
                              title: const Text("Warning"),
                              content: const Text(
                                  "Person Cannot Find It, Re-Enter The Password And Email"),
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
                      }
                    },
                    style: ButtonStyle(
                      backgroundColor:
                          MaterialStateProperty.all(const Color(0xFF7E237C)),
                      shape: MaterialStateProperty.all<RoundedRectangleBorder>(
                        RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(10),
                        ),
                      ),
                    ),
                    child: const Text('Login'),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}

import 'package:crud/mainApp/square_tile.dart';

import '/appDatabase/drift.dart';
import 'main.dart';
import 'package:crud/acceptance/validate.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import '/colorPallete/palette.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({Key? key}) : super(key: key);

  @override
  LoginScreenState createState() => LoginScreenState();
}

final List<College> _colleges = [];

TextEditingController emailController = TextEditingController();
TextEditingController passwordController = TextEditingController();

enum ValidationStatus {
  validCredentials,
  emailNotFound,
  passwordIncorrect,
  invalidInput
}

class LoginScreenState extends State<LoginScreen> {
  @override
  void initState() {
    super.initState();
    _loadColleges();
  }

  bool passwordObscured = true;

  Future<void> _addColleges(String email, String password) async {
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
                              _addColleges(email, password);
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

  ValidationStatus isEmailAndPasswordValid(String email, String password) {
    bool isEmailFound = false;
    bool isPasswordFound = false;
    if (email.isEmpty || password.isEmpty) {
      return ValidationStatus.invalidInput;
    }

    for (var college in _colleges) {
      if (college.email == email && college.password == password) {
        isEmailFound = true;
        isPasswordFound = true;
        return ValidationStatus.validCredentials;
      } else if (college.email == email) {
        isEmailFound = true;
      } else if (college.password == password) {
        isPasswordFound = true;
      }
    }

    if (!isEmailFound && isPasswordFound) {
      return ValidationStatus.emailNotFound;
    } else if (isEmailFound && !isPasswordFound) {
      return ValidationStatus.passwordIncorrect;
    } else {
      return ValidationStatus.invalidInput;
    }
  }

  int getCollegeIdIfEmailAndPasswordValid(String email, String password) {
    for (var college in _colleges) {
      if (college.email == email && college.password == password) {
        return college.id;
      }
    }
    return -1;
  }

  Future<void> _mensager(BuildContext context, String error) async {
    ScaffoldMessenger.of(context).showSnackBar(SnackBar(
      content: Container(
          padding: const EdgeInsets.all(16),
          height: 90,
          decoration: const BoxDecoration(
              color: Color(0xFFC72C41),
              borderRadius: BorderRadius.all(Radius.circular(20))),
          child: Row(
            children: [
              const SizedBox(width: 48),
              Expanded(
                  child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Text(
                    'Oh snap!',
                    style: TextStyle(fontSize: 18, color: Colors.white),
                  ),
                  Text(
                    'Incorrect $error , please try again',
                    style: const TextStyle(color: Colors.white, fontSize: 12),
                    maxLines: 12,
                    overflow: TextOverflow.ellipsis,
                  ),
                ],
              ))
            ],
          )),
      behavior: SnackBarBehavior.floating,
      backgroundColor: Colors.transparent,
      elevation: 0,
    ));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: Center(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              const Icon(
                Icons.lock,
                size: 100,
              ),
              const SizedBox(height: 10),
              const Text('Welcome back you\'we missed you!',
                  style: TextStyle(
                      color: ColorPalette.textColor,
                      fontWeight: FontWeight.w900,
                      fontSize: 20)),
              const SizedBox(height: 10),
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
                              width: 2)),
                      prefixIcon: const Icon(Icons.email_rounded)),
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
                      prefixIcon: const Icon(Icons.password),
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
              const Padding(
                padding: EdgeInsets.symmetric(horizontal: 25.0),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    Text(
                      'Forget Password?',
                      style: TextStyle(color: ColorPalette.textColor),
                    )
                  ],
                ),
              ),
              const SizedBox(height: 10),
              Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  SizedBox(
                    width: 400,
                    height: 45,
                    child: ElevatedButton(
                      onPressed: () async {
                        ValidationStatus isPersonFound =
                            isEmailAndPasswordValid(
                                emailController.text, passwordController.text);
                        switch (isPersonFound) {
                          case ValidationStatus.validCredentials:
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
                            break;
                          case ValidationStatus.passwordIncorrect:
                            _mensager(context, 'password');
                            passwordController.clear();
                            break;
                          case ValidationStatus.emailNotFound:
                            _mensager(context, 'email');
                            emailController.clear();
                            break;
                          case ValidationStatus.invalidInput:
                            _mensager(context, 'enter your email and password');
                            emailController.clear();
                            passwordController.clear();
                            break;
                        }
                      },
                      style: ButtonStyle(
                        backgroundColor:
                            MaterialStateProperty.all(const Color(0xFF7E237C)),
                        shape:
                            MaterialStateProperty.all<RoundedRectangleBorder>(
                          RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(10),
                          ),
                        ),
                      ),
                      child: const Text('Sign In'),
                    ),
                  ),
                  const SizedBox(height: 10),
                  const Row(
                    children: [
                      Expanded(
                          child: Divider(
                              thickness: 0.5,
                              color: ColorPalette.borderColorInputActivate)),
                      Text('Or continue with'),
                      Expanded(
                          child: Divider(
                              thickness: 0.5,
                              color: ColorPalette.borderColorInputActivate))
                    ],
                  ),
                  const Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      SquareTile(
                          imagePath:
                              'https://cdn-icons-png.flaticon.com/512/2875/2875331.png'),
                      SizedBox(width: 10),
                      SquareTile(
                          imagePath:
                              'https://cdn-icons-png.flaticon.com/512/0/747.png')
                    ],
                  ),
                  const SizedBox(height: 50),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      GestureDetector(
                        onTap: registerCollege,
                        child: const Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Text('not a member?'),
                            SizedBox(width: 4),
                            Text(
                              'Register now',
                              style: TextStyle(
                                color: Colors.blue,
                                fontWeight: FontWeight.bold,
                              ),
                            )
                          ],
                        ),
                      )
                    ],
                  )
                  /*
                  SizedBox(
                    width: 400,
                    height: 45,
                    child: ElevatedButton(
                      onPressed: () {
                        registerCollege();
                      },
                      style: ButtonStyle(
                        backgroundColor:
                            MaterialStateProperty.all(const Color(0xFF522151)),
                        shape:
                            MaterialStateProperty.all<RoundedRectangleBorder>(
                          RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(10),
                          ),
                        ),
                      ),
                      child: const Text('Register'),
                    ),
                  ),*/
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}

import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class LoginRegister extends StatefulWidget {
  const LoginRegister({Key? key}) : super(key: key);

  @override
  State<LoginRegister> createState() => _LoginRegisterState();
}

class _LoginRegisterState extends State<LoginRegister> {
  final TextEditingController userEmailController = TextEditingController();
  final TextEditingController regiUserEmailController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();
  final TextEditingController regiPasswordController = TextEditingController();
  final TextEditingController regiFirstNameController = TextEditingController();
  final TextEditingController regiLastNameController = TextEditingController();

  GlobalKey<FormState> loginFormKey = GlobalKey();
  GlobalKey<FormState> signupFormKey = GlobalKey();
  bool isLoginPart = true;
  bool isRememberMeTicked = false;

  List<String> userEmailList = [];
  List<String> passwordList = [];
  List<String> firstNameList = [];

  @override
  Widget build(BuildContext context) {
    double _height = MediaQuery.of(context).size.height;
    double _width = MediaQuery.of(context).size.width;
    return Scaffold(
      backgroundColor: Colors.black,
      body: Align(
        alignment: Alignment.bottomCenter,
        child: SingleChildScrollView(
          child: Container(
            width: _width,
            height: _height * 0.7,
            decoration: const BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.only(
                topLeft: Radius.circular(95),
              ),
            ),
            child: (isLoginPart == true)
                ? Form(
                    key: loginFormKey,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        const SizedBox(height: 82),
                        const Text(
                          "Login",
                          style: TextStyle(
                            fontSize: 36,
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                        const SizedBox(height: 24),
                        Container(
                          margin: const EdgeInsets.symmetric(horizontal: 12),
                          child: TextFormField(
                            controller: userEmailController,
                            validator: (val) {
                              if (val!.isEmpty) {
                                return "Please enter your email";
                              }
                              if (val.length < 5) {
                                return "Please enter valid Email address";
                              }
                              return null;
                            },
                            decoration: const InputDecoration(
                              border: OutlineInputBorder(),
                              hintText: "Email",
                              labelText: "Email",
                              enabled: true,
                            ),
                          ),
                        ),
                        const SizedBox(height: 24),
                        Container(
                          margin: const EdgeInsets.symmetric(horizontal: 12),
                          child: TextFormField(
                            controller: passwordController,
                            validator: (val) {
                              if (val!.isEmpty) {
                                return "Please enter password";
                              }

                              return null;
                            },
                            decoration: const InputDecoration(
                              border: OutlineInputBorder(),
                              hintText: "Password",
                              labelText: "Password",
                              enabled: true,
                            ),
                          ),
                        ),
                        const SizedBox(height: 24),
                        InkWell(
                          onTap: () async {
                            if (loginFormKey.currentState!.validate()) {
                              String userEmail = userEmailController.text;
                              String password = passwordController.text;

                              SharedPreferences prefs =
                                  await SharedPreferences.getInstance();

                              int? usernameListLength =
                                  prefs.getStringList('userEmailList')?.length;

                              if (userEmailList.isEmpty) {
                                ScaffoldMessenger.of(context)
                                    .showSnackBar(SnackBar(
                                  backgroundColor: Colors.red,
                                  behavior: SnackBarBehavior.floating,
                                  content: const Text(
                                    "No Users are Registered",
                                  ),
                                  action: SnackBarAction(
                                      label: "Dismiss", onPressed: () {}),
                                ));
                              }

                              for (int i = 0; i < usernameListLength!; i++) {
                                if (userEmail ==
                                        prefs.getStringList(
                                            'userEmailList')![i] &&
                                    password ==
                                        prefs.getStringList(
                                            'passwordList')![i] &&
                                    isRememberMeTicked == true) {
                                  prefs.setBool('isRemembered', true);
                                  prefs.setString('currentUser',
                                      prefs.getStringList('usernameList')![i]);

                                  Navigator.of(context)
                                      .pushReplacementNamed('homepage');
                                } else if (userEmail ==
                                        prefs.getStringList(
                                            'userEmailList')![i] &&
                                    password ==
                                        prefs.getStringList(
                                            'passwordList')![i]) {
                                  Navigator.of(context)
                                      .pushReplacementNamed('homepage');
                                } else {
                                  ScaffoldMessenger.of(context)
                                      .showSnackBar(SnackBar(
                                    backgroundColor: Colors.red,
                                    behavior: SnackBarBehavior.floating,
                                    content: const Text(
                                      "Username or Password Invalid",
                                    ),
                                    action: SnackBarAction(
                                        label: "Dismiss", onPressed: () {}),
                                  ));
                                }
                              }
                            }
                          },
                          child: Container(
                            width: _width,
                            margin: const EdgeInsets.symmetric(horizontal: 14),
                            height: 50,
                            decoration: const BoxDecoration(
                                color: Colors.black,
                                borderRadius: BorderRadius.only(
                                  topLeft: Radius.circular(10),
                                  bottomLeft: Radius.circular(10),
                                  bottomRight: Radius.circular(10),
                                ),
                                boxShadow: <BoxShadow>[
                                  BoxShadow(
                                    color: Colors.black,
                                    spreadRadius: 2,
                                    blurRadius: 1,
                                    offset: Offset(0, 0),
                                  ),
                                ]),
                            alignment: Alignment.center,
                            child: const Text(
                              "Login",
                              style: TextStyle(
                                color: Colors.white,
                                fontSize: 20,
                              ),
                            ),
                          ),
                        ),
                        const SizedBox(height: 14),
                        Row(
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            Checkbox(
                                activeColor: Colors.black,
                                onChanged: (val) {
                                  setState(() {
                                    isRememberMeTicked = val!;
                                  });
                                },
                                value: isRememberMeTicked),
                            const Text(
                              "Remember Me",
                              style: TextStyle(
                                fontWeight: FontWeight.w700,
                                fontSize: 16,
                              ),
                            ),
                          ],
                        ),
                        const Spacer(),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            const Text(
                              "Don't have an account?",
                              style: TextStyle(fontWeight: FontWeight.bold),
                            ),
                            TextButton(
                              onPressed: () {
                                setState(() {
                                  isLoginPart = !isLoginPart;
                                });
                              },
                              child: const Text("Sign Up"),
                            ),
                          ],
                        ),
                        const SizedBox(height: 14),
                      ],
                    ),
                  ) //Login Section
                : Form(
                    key: signupFormKey,
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        const SizedBox(height: 82),
                        const Text(
                          "Sign Up",
                          style: TextStyle(
                            fontSize: 36,
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                        const SizedBox(height: 24),
                        Container(
                          margin: const EdgeInsets.symmetric(horizontal: 12),
                          child: TextFormField(
                            controller: regiFirstNameController,
                            validator: (val) {
                              if (val!.isEmpty) {
                                return "Please enter first name";
                              }

                              return null;
                            },
                            decoration: const InputDecoration(
                              border: OutlineInputBorder(),
                              hintText: "First Name",
                              labelText: "First Name",
                              enabled: true,
                            ),
                          ),
                        ),
                        const SizedBox(height: 24),
                        Container(
                          margin: const EdgeInsets.symmetric(horizontal: 12),
                          child: TextFormField(
                            controller: regiLastNameController,
                            validator: (val) {
                              if (val!.isEmpty) {
                                return "Please enter your last name";
                              }

                              return null;
                            },
                            decoration: const InputDecoration(
                              border: OutlineInputBorder(),
                              hintText: "Last Name",
                              labelText: "Last Name",
                              enabled: true,
                            ),
                          ),
                        ),
                        const SizedBox(height: 24),
                        Container(
                          margin: const EdgeInsets.symmetric(horizontal: 12),
                          child: TextFormField(
                            controller: regiUserEmailController,
                            validator: (val) {
                              if (val!.isEmpty) {
                                return "Please enter your email";
                              }
                              if (val.length < 5) {
                                return "Please enter valid Email address";
                              }
                              return null;
                            },
                            decoration: const InputDecoration(
                              border: OutlineInputBorder(),
                              hintText: "Email",
                              labelText: "Email",
                              enabled: true,
                            ),
                          ),
                        ),
                        const SizedBox(height: 24),
                        Container(
                          margin: const EdgeInsets.symmetric(horizontal: 12),
                          child: TextFormField(
                            controller: regiPasswordController,
                            validator: (val) {
                              if (val!.isEmpty) {
                                return "Please enter password";
                              }

                              return null;
                            },
                            decoration: const InputDecoration(
                              border: OutlineInputBorder(),
                              hintText: "Password",
                              labelText: "Password",
                              enabled: true,
                            ),
                          ),
                        ),
                        const SizedBox(height: 24),
                        InkWell(
                          onTap: () async {
                            if (signupFormKey.currentState!.validate()) {
                              String userEmail = regiUserEmailController.text;
                              String password = regiPasswordController.text;
                              String firstName = regiFirstNameController.text;

                              SharedPreferences prefs =
                                  await SharedPreferences.getInstance();

                              userEmailList.add(userEmail);
                              passwordList.add(password);
                              firstNameList.add(firstName);

                              await prefs.setStringList(
                                  'userEmailList', userEmailList);
                              await prefs.setStringList(
                                  'passwordList', passwordList);
                              await prefs.setStringList(
                                  'usernameList', firstNameList);

                              ScaffoldMessenger.of(context).showSnackBar(
                                SnackBar(
                                  content: Text("New User Registered."),
                                  backgroundColor: Colors.green,
                                  behavior: SnackBarBehavior.floating,
                                  action: SnackBarAction(
                                      label: "Dismiss", onPressed: () {}),
                                ),
                              );
                            }

                            setState(() {
                              signupFormKey.currentState!.reset();
                              regiPasswordController.clear();
                              regiUserEmailController.clear();
                              regiFirstNameController.clear();
                              regiLastNameController.clear();
                            });
                          },
                          child: Container(
                            width: _width,
                            margin: const EdgeInsets.symmetric(horizontal: 14),
                            height: 50,
                            decoration: const BoxDecoration(
                                color: Colors.black,
                                borderRadius: BorderRadius.only(
                                  topLeft: Radius.circular(10),
                                  bottomLeft: Radius.circular(10),
                                  bottomRight: Radius.circular(10),
                                ),
                                boxShadow: <BoxShadow>[
                                  BoxShadow(
                                    color: Colors.black,
                                    spreadRadius: 2,
                                    blurRadius: 1,
                                    offset: Offset(0, 0),
                                  ),
                                ]),
                            alignment: Alignment.center,
                            child: const Text(
                              "Sign Up",
                              style: TextStyle(
                                color: Colors.white,
                                fontSize: 20,
                              ),
                            ),
                          ),
                        ),
                        const Spacer(),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            const Text(
                              "Already have an account?",
                              style: TextStyle(fontWeight: FontWeight.bold),
                            ),
                            TextButton(
                              onPressed: () {
                                setState(() {
                                  isLoginPart = !isLoginPart;
                                });
                              },
                              child: const Text("Login"),
                            ),
                          ],
                        ),
                        const SizedBox(height: 14),
                      ],
                    ),
                  ), //SignUp Section
          ),
        ),
      ),
    );
  }
}

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:my_ecommerce_app/Screen/LoginScreen.dart';
import 'package:my_ecommerce_app/Screen/UserFrom.dart';
import 'package:my_ecommerce_app/Utils/AppColor.dart';

import '../Utils/CastomButtom.dart';

class SignInScreen extends StatefulWidget {
  const SignInScreen({super.key});

  @override
  State<SignInScreen> createState() => _SignInScreenState();
}

class _SignInScreenState extends State<SignInScreen> {
  TextEditingController emailController = TextEditingController();
  TextEditingController passwordController = TextEditingController();
  TextEditingController cPasswordController = TextEditingController();
  bool isLoading = false;

  void signUp() async {
    setState(() {
      isLoading = true;
    });
    final String email = emailController.text.trim();
    final String password = passwordController.text.trim();
    final String cpassword = cPasswordController.text.trim();

    if (email == "" || password == "" || cpassword == "") {
      emailController.clear();
      passwordController.clear();
      cPasswordController.clear();
      mySnakBarr("please fill all filds", context);
    } else if (password != password) {
      mySnakBarr("Password not match", context);
    } else {
      try {
        UserCredential userCredential = await FirebaseAuth.instance
            .createUserWithEmailAndPassword(email: email, password: password);

        if (userCredential != null) {
          mySnakBarr("User cretede", context);

          Navigator.push(
              context,
              CupertinoPageRoute(
                builder: (context) => UserFrom(),
              ));
        }
      } on FirebaseAuthException catch (e) {
        mySnakBarr(e.code.toString(), context);
      }
    }
    setState(() {
      isLoading = false;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: prymariColor,
      body: Column(
        // mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            decoration: BoxDecoration(color: prymariColor),
            height: 200,
            width: double.infinity,
            child: const Align(
              alignment: Alignment.bottomLeft,
              child: Padding(
                padding: EdgeInsets.only(left: 20, bottom: 50),
                child: Text(
                  "Sign up",
                  style: TextStyle(
                      color: Colors.white,
                      fontWeight: FontWeight.bold,
                      fontSize: 30),
                ),
              ),
            ),
          ),
          Expanded(
            flex: 1,
            child: Container(
              width: double.infinity,
              decoration: const BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.only(
                  topLeft: Radius.circular(20),
                  topRight: Radius.circular(20),
                ),
              ),
              padding: const EdgeInsets.all(10),
              child: Padding(
                padding: const EdgeInsets.all(10),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  // mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    const SizedBox(
                      height: 30,
                    ),
                    Text(
                      "Welcome Back",
                      style: TextStyle(
                          color: prymariColor,
                          fontSize: 30,
                          fontWeight: FontWeight.bold),
                    ),
                    const Text(
                      "Glad to see you back my buddy.",
                      style: TextStyle(
                          fontSize: 17,
                          color: Color.fromARGB(255, 148, 146, 146),
                          fontWeight: FontWeight.bold),
                    ),
                    const SizedBox(
                      height: 30,
                    ),
                    Row(
                      crossAxisAlignment: CrossAxisAlignment.end,
                      children: [
                        Icon(
                          Icons.email,
                          size: 36,
                          color: prymariColor,
                        ),
                        SizedBox(
                          width: 10,
                        ),
                        Expanded(child: myTextFild("Email", emailController)),
                      ],
                    ),
                    SizedBox(
                      height: 20,
                    ),
                    Row(
                      crossAxisAlignment: CrossAxisAlignment.end,
                      children: [
                        Icon(
                          Icons.security,
                          size: 36,
                          color: prymariColor,
                        ),
                        SizedBox(
                          width: 10,
                        ),
                        Expanded(
                            child: myTextFild("Password", passwordController)),
                      ],
                    ),
                    SizedBox(
                      height: 20,
                    ),
                    Row(
                      crossAxisAlignment: CrossAxisAlignment.end,
                      children: [
                        Icon(
                          Icons.lock,
                          size: 36,
                          color: prymariColor,
                        ),
                        SizedBox(
                          width: 10,
                        ),
                        Expanded(
                            child: myTextFild(
                                "Confirm Password", cPasswordController)),
                      ],
                    ),
                    const SizedBox(
                      height: 20,
                    ),
                    Spacer(),
                    Center(
                      child: castomButton(isLoading, "SIGN UP", () {
                        signUp();
                      }),
                    ),
                    const SizedBox(
                      height: 10,
                    ),
                    Row(
                      // ignore: prefer_const_literals_to_create_immutables
                      children: [
                        Text(
                          "Do You Have An Account?",
                          style: TextStyle(
                              color: Color.fromARGB(255, 140, 138, 138),
                              fontSize: 13,
                              fontWeight: FontWeight.bold),
                        ),
                        const SizedBox(
                          width: 5,
                        ),
                        InkWell(
                          onTap: () {
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (context) => LoginScreen(),
                              ),
                            );
                          },
                          child: Text(
                            "Sign in",
                            style: TextStyle(
                                color: prymariColor,
                                fontSize: 16,
                                fontWeight: FontWeight.bold),
                          ),
                        ),
                      ],
                    ),
                    Spacer(),
                  ],
                ),
              ),
            ),
          )
        ],
      ),
    );
  }
}

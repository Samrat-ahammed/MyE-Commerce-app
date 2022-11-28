// ignore_for_file: prefer_const_constructors

import 'dart:developer';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:my_ecommerce_app/Screen/BtmNvmBarr.dart';
import 'package:my_ecommerce_app/Screen/BtmNvmBarr_Contrlr/Home.dart';
import 'package:my_ecommerce_app/Screen/Signin_screen.dart';
import 'package:my_ecommerce_app/Utils/AppColor.dart';
import 'package:my_ecommerce_app/Utils/CastomButtom.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  TextEditingController emailController = TextEditingController();
  TextEditingController passwordController = TextEditingController();
  bool isLoading = false;

  void login() async {
    setState(() {
      isLoading = true;
    });

    String email = emailController.text.trim();
    String password = passwordController.text.trim();
    if (email == "" || password == "") {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text("Please enter your correct Email And Password"),
          duration: Duration(seconds: 5),
          backgroundColor: Colors.red,
        ),
      );
    } else {
      try {
        UserCredential userCredential = await FirebaseAuth.instance
            .signInWithEmailAndPassword(email: email, password: password);

        if (userCredential != null) {
          String uid = userCredential.user!.uid;

          Navigator.popUntil(context, (route) => route.isFirst);
          // ignore: use_build_context_synchronously
          Navigator.pushReplacement(
            context,
            MaterialPageRoute(
              builder: (context) => BtmNvmBarr(),
            ),
          );
          ScaffoldMessenger.of(context).showSnackBar(
            const SnackBar(
              content: Text("Login Successful"),
              duration: Duration(seconds: 5),
              backgroundColor: Colors.red,
            ),
          );
        }
      } on FirebaseAuthException catch (e) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text(e.code.toString()),
            duration: const Duration(seconds: 5),
            backgroundColor: Colors.red,
          ),
        );
      }
    }
    emailController.clear();
    passwordController.clear();
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
                  "Login",
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
                    const SizedBox(
                      height: 20,
                    ),
                    Spacer(),
                    Center(
                      child: castomButton(
                        isLoading,
                        "SIGN UP",
                        () {
                          login();
                        },
                      ),
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
                                builder: (context) => SignInScreen(),
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

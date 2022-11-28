// ignore_for_file: prefer_const_constructors

import 'dart:async';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:my_ecommerce_app/Screen/LoginScreen.dart';
import 'package:my_ecommerce_app/Utils/AppColor.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  void initState() {
    Timer(
        Duration(seconds: 3),
        () => Navigator.pushReplacement(
              context,
              CupertinoPageRoute(
                builder: (context) => LoginScreen(),
              ),
            ));
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: prymariColor,
      body: SafeArea(
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            // ignore: prefer_const_literals_to_create_immutables
            children: [
              Text(
                "Ecommerce",
                style: TextStyle(
                    color: Colors.white,
                    fontSize: 30,
                    fontWeight: FontWeight.bold),
              ),
              CircularProgressIndicator(
                color: Colors.white,
              )
            ],
          ),
        ),
      ),
    );
  }
}

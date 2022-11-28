// ignore_for_file: prefer_const_constructors

import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:my_ecommerce_app/Screen/BtmNvmBarr.dart';
import 'package:my_ecommerce_app/Screen/BtmNvmBarr_Contrlr/Home.dart';
import 'package:my_ecommerce_app/Utils/AppColor.dart';
import 'package:my_ecommerce_app/Utils/CastomButtom.dart';

class UserFrom extends StatefulWidget {
  const UserFrom({
    super.key,
  });

  @override
  State<UserFrom> createState() => _UserFromState();
}

class _UserFromState extends State<UserFrom> {
  TextEditingController fullNameController = TextEditingController();
  TextEditingController phonNumberController = TextEditingController();
  TextEditingController dethOfBirthContrller = TextEditingController();
  TextEditingController ageController = TextEditingController();
  TextEditingController genderContrller = TextEditingController();
  List<String> genderDetils = ["Male", "Female", "Other"];
  bool isLoading = false;

  saveUserData() async {
    setState(() {
      isLoading = true;
    });
    final FirebaseAuth _auth = FirebaseAuth.instance;
    var currentUser = _auth.currentUser;

    CollectionReference saveUser =
        FirebaseFirestore.instance.collection("users-form-data");
    return saveUser.doc(currentUser!.email).set({
      "name": fullNameController.text,
      "phone": phonNumberController.text,
      "dob": dethOfBirthContrller.text,
      "gender": genderContrller.text,
      "age": ageController.text,
    }).then(
      (value) {
        Navigator.popUntil(context, (route) => route.isFirst);
        Navigator.pushReplacement(
          context,
          MaterialPageRoute(
            builder: (_) => BtmNvmBarr(),
          ),
        );
        setState(() {
          isLoading = false;
        });
      },
    ).catchError(
      (error) => print("something is wrong. $error"),
    );
  }

  // void saveUser() {
  //   final String fullname = fullNameController.text.trim();
  //   final String phoneNumber = phonNumberController.text.trim();
  //   final String dethBirth = dethOfBirthContrller.text.trim();
  //   final String age = ageController.text.trim();
  //   final String gender = genderContrller.text.trim();

  //   if (fullname == "" ||
  //       phoneNumber == "" ||
  //       dethBirth == "" ||
  //       age == "" ||
  //       gender == "") {
  //     mySnakBarr("please fill all box", context);
  //   } else {
  //     log("Upload Data");
  //     uploadData();
  //   }
  // }

  Future<void> _selectDateFromPicker(BuildContext context) async {
    final DateTime? picked = await showDatePicker(
      context: context,
      initialDate: DateTime(DateTime.now().year - 20),
      firstDate: DateTime(DateTime.now().year - 30),
      lastDate: DateTime(DateTime.now().year),
    );
    if (picked != null)
      setState(() {
        dethOfBirthContrller.text =
            "${picked.day}/ ${picked.month}/ ${picked.year}";
      });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.only(left: 10, right: 10, top: 20),
          child: Column(
            children: [
              Text(
                "Submit the form to continue.",
                style: TextStyle(
                    color: prymariColor,
                    fontSize: 30,
                    fontWeight: FontWeight.bold),
              ),
              const Text(
                "We will not share your information with anyone.",
                style: TextStyle(
                    color: Color.fromARGB(255, 141, 139, 139),
                    fontSize: 18,
                    fontWeight: FontWeight.bold),
              ),
              const SizedBox(
                height: 10,
              ),
              myTextFild(
                "Full Name",
                fullNameController,
              ),
              const SizedBox(
                height: 10,
              ),
              myTextFild(
                "Phone Number",
                phonNumberController,
              ),
              const SizedBox(
                height: 10,
              ),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: TextField(
                  controller: genderContrller,
                  readOnly: true,
                  decoration: InputDecoration(
                    hintText: "choose your gender",
                    hintStyle: TextStyle(fontWeight: FontWeight.bold),
                    prefixIcon: DropdownButton<String>(
                      borderRadius: BorderRadius.circular(12),
                      items: genderDetils.map(
                        (String value) {
                          return DropdownMenuItem<String>(
                            value: value,
                            child: new Text(value),
                            onTap: () {
                              setState(
                                () {
                                  genderContrller.text = value;
                                },
                              );
                            },
                          );
                        },
                      ).toList(),
                      onChanged: (_) {},
                    ),
                  ),
                ),
              ),
              const SizedBox(
                height: 10,
              ),
              TextField(
                controller: dethOfBirthContrller,
                readOnly: true,
                decoration: InputDecoration(
                  hintText: "date of birth",
                  hintStyle: TextStyle(fontWeight: FontWeight.bold),
                  suffixIcon: IconButton(
                    onPressed: () => _selectDateFromPicker(context),
                    icon: Icon(Icons.calendar_today_outlined),
                  ),
                ),
              ),
              const SizedBox(
                height: 10,
              ),
              myTextFild(
                "Age",
                ageController,
              ),
              const Spacer(),
              castomButton(isLoading, "SUBMET", () {
                saveUserData();
              }),
              const SizedBox(
                height: 100,
              ),
            ],
          ),
        ),
      ),
    );
  }
}

// ignore_for_file: prefer_const_constructors

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:my_ecommerce_app/Screen/BtmNvmBarr_Contrlr/Cart.dart';
import 'package:my_ecommerce_app/Screen/LoginScreen.dart';
import 'package:my_ecommerce_app/Utils/AppColor.dart';
import 'package:my_ecommerce_app/Utils/CastomButtom.dart';

class Profile extends StatefulWidget {
  const Profile({super.key});

  @override
  State<Profile> createState() => _ProfileState();
}

class _ProfileState extends State<Profile> {
  TextEditingController? nameController;
  TextEditingController? phonController;
  TextEditingController? ageController;
  bool isLoading = false;

  logOut() async {
    await FirebaseAuth.instance.signOut().then((value) {
      mySnakBarr("Logout", context);
    });
    Navigator.pushReplacement(
        context,
        MaterialPageRoute(
          builder: (context) => LoginScreen(),
        ));
  }

  updateData() {
    setState(() {
      isLoading = true;
    });
    CollectionReference collectionReference =
        FirebaseFirestore.instance.collection("users-form-data");
    return collectionReference
        .doc(FirebaseAuth.instance.currentUser!.email)
        .update({
      "name": nameController!.text,
      "phone": phonController!.text,
      "age": ageController!.text
    }).then((value) {
      setState(() {
        isLoading = false;
      });
      mySnakBarr("Updated Successfully", context);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body:
          //     body: SafeArea(
          //   child: StreamBuilder(
          //     stream: FirebaseFirestore.instance
          //         .collection("users-from-data")
          //         .doc(FirebaseAuth.instance.currentUser!.email)
          //         .snapshots(),
          //     builder: (context, snapshot) {
          //       if (snapshot.hasData) {
          //         var data = snapshot.data;
          //         return ListTile(title: Text(data!["name"]));
          //       } else if (snapshot.hasError) {
          //         return Text("some wrong");
          //       } else {
          //         return Text("No Data");
          //       }
          //     },
          //   ),
          // )

          SafeArea(
              child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: StreamBuilder<Object>(
            stream: FirebaseFirestore.instance
                .collection("users-form-data")
                .doc(FirebaseAuth.instance.currentUser!.email)
                .snapshots(),
            builder: (BuildContext context, AsyncSnapshot snapshot) {
              var data = snapshot.data;
              if (snapshot.hasError) {
                return Center(
                  child: CircularProgressIndicator(color: prymariColor),
                );
              }
              return Column(
                children: [
                  SizedBox(
                    height: 20,
                  ),
                  TextField(
                    style: TextStyle(
                        color: Colors.black,
                        fontSize: 20,
                        fontWeight: FontWeight.bold),
                    controller: nameController =
                        TextEditingController(text: data["name"]),
                    decoration: InputDecoration(
                        border: OutlineInputBorder(), label: Text("Name")),
                  ),
                  SizedBox(
                    height: 20,
                  ),
                  TextField(
                    style: TextStyle(
                        color: Colors.black,
                        fontSize: 20,
                        fontWeight: FontWeight.bold),
                    controller: phonController =
                        TextEditingController(text: data["phone"]),
                    decoration: InputDecoration(
                        border: OutlineInputBorder(),
                        label: Text("Phon-Number")),
                  ),
                  SizedBox(
                    height: 20,
                  ),
                  TextField(
                    style: TextStyle(
                        color: Colors.black,
                        fontSize: 20,
                        fontWeight: FontWeight.bold),
                    controller: ageController =
                        TextEditingController(text: data["age"]),
                    decoration: InputDecoration(
                        border: OutlineInputBorder(), label: Text("Age")),
                  ),
                  const SizedBox(
                    height: 20,
                  ),
                  castomButton(isLoading, "Update", () {
                    updateData();
                  }),
                  Padding(
                    padding: const EdgeInsets.all(30),
                    child: castomButton(isLoading = false, "LogOut", () {
                      logOut();
                    }),
                  ),
                ],
              );
            }),
      )),
    );
  }
}

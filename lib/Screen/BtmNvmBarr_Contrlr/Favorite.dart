import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:my_ecommerce_app/Utils/AppColor.dart';

class Favoarite extends StatefulWidget {
  const Favoarite({super.key});

  @override
  State<Favoarite> createState() => _FavoariteState();
}

class _FavoariteState extends State<Favoarite> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: StreamBuilder(
        stream: FirebaseFirestore.instance
            .collection("user-Favorite-items")
            .doc(FirebaseAuth.instance.currentUser!.email)
            .collection("items")
            .snapshots(),
        builder: (context, snapshot) {
          if (snapshot.hasError) {
            return Text("No products add");
          }
          return ListView.builder(
            itemCount: snapshot.data!.docs.length,
            itemBuilder: (context, index) {
              DocumentSnapshot documentSnapshot = snapshot.data!.docs[index];
              return Container(
                padding: EdgeInsets.all(5),
                child: Card(
                  elevation: 5,
                  shadowColor: Colors.blue,
                  color: prymariColor,
                  child: ListTile(
                    title: Text(
                      documentSnapshot["name"],
                      style: TextStyle(
                          fontSize: 20,
                          fontWeight: FontWeight.bold,
                          color: Colors.white),
                    ),
                    leading: Image.network(documentSnapshot["img"]),
                    trailing: Text(
                      documentSnapshot["price"],
                      style: TextStyle(
                          fontSize: 20,
                          fontWeight: FontWeight.bold,
                          color: Colors.white),
                    ),
                  ),
                ),
              );
            },
          );
        },
      ),
    );
  }
}

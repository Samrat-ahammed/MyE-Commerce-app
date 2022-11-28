import 'package:cached_network_image/cached_network_image.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:my_ecommerce_app/Utils/AppColor.dart';
import 'package:my_ecommerce_app/Utils/CastomButtom.dart';

class Cart extends StatefulWidget {
  const Cart({super.key});

  @override
  State<Cart> createState() => _CartState();
}

class _CartState extends State<Cart> {
  bool isLoading = false;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: StreamBuilder(
          stream: FirebaseFirestore.instance
              .collection("user-cart_item")
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
                return Card(
                  color: prymariColor,
                  child: Container(
                    padding: EdgeInsets.all(4),
                    child: ListTile(
                      dense: true,
                      title: Text(
                        documentSnapshot["price"],
                        style: TextStyle(
                            fontSize: 18,
                            fontWeight: FontWeight.bold,
                            color: Colors.white),
                      ),
                      leading: Text(
                        documentSnapshot["name"],
                        style: TextStyle(
                            fontSize: 20,
                            fontWeight: FontWeight.bold,
                            color: Colors.white),
                      ),
                      trailing: CircleAvatar(
                        backgroundColor: Colors.white,
                        radius: 50,
                        child: CircleAvatar(
                          radius: 20,
                          child: IconButton(
                            onPressed: () {
                              FirebaseFirestore.instance
                                  .collection("user-cart_item")
                                  .doc(FirebaseAuth.instance.currentUser!.email)
                                  .collection("items")
                                  .doc(documentSnapshot.id)
                                  .delete()
                                  .then((value) {
                                return mySnakBarr("delete this item", context);
                              });
                            },
                            icon: Icon(Icons.delete),
                            color: Colors.red,
                          ),
                        ),
                      ),
                      // Text(documentSnapshot["price"]),
                      // Text("\$ ${documentSnapshot["price"]}"),
                    ),
                  ),
                );
              },
            );
          },
        ),
      ),
    );
  }
}

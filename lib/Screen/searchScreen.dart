import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/container.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:my_ecommerce_app/Utils/AppColor.dart';

class Search_Screen extends StatefulWidget {
  const Search_Screen({super.key});

  @override
  State<Search_Screen> createState() => _Search_ScreenState();
}

class _Search_ScreenState extends State<Search_Screen> {
  TextEditingController searchController = TextEditingController();
  var serchText = '';
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Search Products"),
        backgroundColor: prymariColor,
      ),
      body: SafeArea(
        child: Padding(
          padding:
              const EdgeInsets.only(left: 10, right: 10, top: 20, bottom: 40),
          child: Column(children: [
            const SizedBox(
              height: 20,
            ),
            TextFormField(
              controller: searchController,
              onChanged: ((value) {
                setState(() {
                  value = serchText;
                  print(serchText);
                });
              }),
              decoration: InputDecoration(
                hintText: "Please enter your Product Name ...",
                focusedBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(8),
                  borderSide: const BorderSide(color: Colors.lightBlue),
                ),
                enabledBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(8),
                  borderSide: BorderSide(color: prymariColor),
                ),
              ),
            ),
            const SizedBox(
              height: 10,
            ),
            Expanded(
              child: Container(
                decoration: BoxDecoration(
                    color: const Color.fromARGB(255, 202, 205, 174),
                    borderRadius: BorderRadius.circular(4)),
                child: StreamBuilder(
                  stream: FirebaseFirestore.instance
                      .collection("products")
                      .where(
                        "name",
                        isGreaterThanOrEqualTo: serchText,
                      )
                      .snapshots(),
                  builder: (context, snapshot) {
                    if (snapshot.connectionState == ConnectionState.active) {
                      if (snapshot.hasData) {
                        QuerySnapshot dataSnapshot =
                            snapshot.data as QuerySnapshot;

                        return ListView(
                          children: snapshot.data!.docs
                              .map((DocumentSnapshot documentSnapshot) {
                            Map<String, dynamic> data =
                                documentSnapshot.data() as Map<String, dynamic>;

                            return Padding(
                              padding: const EdgeInsets.all(0),
                              child: Card(
                                margin: const EdgeInsets.all(5),
                                elevation: 4,
                                color: const Color.fromARGB(255, 247, 191, 191),
                                child: ListTile(
                                  title: Text(
                                    data["name"],
                                    style: const TextStyle(
                                        shadows: [
                                          Shadow(
                                              color: Colors.white,
                                              blurRadius: 10)
                                        ],
                                        fontSize: 18,
                                        fontWeight: FontWeight.bold),
                                  ),
                                  leading: Image.network(data["img"]),
                                ),
                              ),
                            );
                          }).toList(),
                        );
                      } else if (snapshot.hasError) {
                        return const Center(
                            child: Text(
                          "some wrong",
                          style: TextStyle(color: Colors.black),
                        ));
                      } else {
                        return const Center(
                          child: Text(
                            "no ruselt",
                            style: TextStyle(color: Colors.black),
                          ),
                        );
                      }
                    } else {
                      return const Center(
                        child: CircularProgressIndicator(),
                      );
                    }
                  },
                ),
              ),
            )
          ]),
        ),
      ),
    );
  }
}

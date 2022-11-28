import 'package:cached_network_image/cached_network_image.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:dots_indicator/dots_indicator.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:my_ecommerce_app/Utils/AppColor.dart';
import 'package:my_ecommerce_app/Utils/CastomButtom.dart';

class ProductsDetils extends StatefulWidget {
  var _producDetils;
  ProductsDetils(this._producDetils);

  @override
  State<ProductsDetils> createState() => _ProductsDetilsState();
}

class _ProductsDetilsState extends State<ProductsDetils> {
  bool isLoading = false;

  Future addtoCart() async {
    //add to cart funsion
    setState(() {
      isLoading = true;
    });
    final FirebaseAuth _auth = FirebaseAuth.instance;

    var currentUser = _auth.currentUser;

    CollectionReference collectionReference =
        FirebaseFirestore.instance.collection("user-cart_item");
    return collectionReference
        .doc(currentUser!.email)
        .collection("items")
        .doc()
        .set({
      "name": widget._producDetils["product-name"],
      "img": widget._producDetils["product-img"],
      "price": widget._producDetils["product-price"]
    }).then((value) {
      setState(() {
        mySnakBarr("Add to Cart", context);
        isLoading = false;
      });
    });
  }

// Add to favorite fun
  Future addtoFavorite() async {
    final FirebaseAuth _auth = FirebaseAuth.instance;

    var currentUser = _auth.currentUser;

    CollectionReference collectionReference =
        FirebaseFirestore.instance.collection("user-Favorite-items");
    return collectionReference
        .doc(currentUser!.email)
        .collection("items")
        .doc()
        .set({
      "name": widget._producDetils["product-name"],
      "img": widget._producDetils["product-img"],
      "price": widget._producDetils["product-price"]
    }).then((value) {
      mySnakBarr("Add to Favorite", context);
      setState(() {
        // isLoading = false;
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color.fromARGB(255, 230, 218, 218),
      appBar: AppBar(
        elevation: 5,
        leading: Padding(
          padding: const EdgeInsets.all(8.0),
          child: CircleAvatar(
            backgroundColor: Colors.white,
            child: IconButton(
              onPressed: () {
                Navigator.pop(context);
              },
              icon: Icon(
                Icons.arrow_back,
                color: prymariColor,
              ),
            ),
          ),
        ),
        actions: [
          StreamBuilder<QuerySnapshot>(
              stream: FirebaseFirestore.instance
                  .collection("user-Favorite-items")
                  .doc(FirebaseAuth.instance.currentUser!.email)
                  .collection("items")
                  .where("name",
                      isEqualTo: widget._producDetils["product-name"])
                  .snapshots(),
              builder: (context, snapshot) {
                if (snapshot.data == null) {
                  return Text("");
                }
                return CircleAvatar(
                  backgroundColor: Colors.white,
                  child: IconButton(
                      onPressed: () {
                        snapshot.data!.docs.length == 0
                            ? addtoFavorite()
                            : mySnakBarr("Already add", context);
                      },
                      icon: snapshot.data!.docs.length == 0
                          ? Icon(
                              Icons.favorite_border,
                              color: prymariColor,
                            )
                          : Icon(Icons.favorite)),
                );
              })
        ],
        centerTitle: true,
        backgroundColor: prymariColor,
        title: Text(
          widget._producDetils["product-name"],
          style: const TextStyle(
              color: Colors.white, fontWeight: FontWeight.bold, fontSize: 20),
        ),
      ),
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Padding(
              padding: const EdgeInsets.all(10),
              child: Container(
                decoration: BoxDecoration(),
                // child: Image.network(widget._producDetils["product-img"]),
                child: CachedNetworkImage(
                    imageUrl: widget._producDetils["product-img"]),
              ),
            ),
            const SizedBox(
              height: 20,
            ),
            Padding(
              padding: const EdgeInsets.all(10),
              child: Container(
                padding: EdgeInsets.all(10),
                decoration: BoxDecoration(
                    color: prymariColor,
                    borderRadius: BorderRadius.circular(10)),
                child: Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 15),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        widget._producDetils["product-name"],
                        style: TextStyle(
                            color: Colors.black,
                            fontWeight: FontWeight.bold,
                            fontSize: 20),
                      ),
                      const SizedBox(
                        height: 20,
                      ),
                      Padding(
                        padding: const EdgeInsets.only(left: 20),
                        child: Text(
                          widget._producDetils["product-price"],
                          style: TextStyle(
                              color: Colors.black,
                              fontWeight: FontWeight.bold,
                              fontSize: 20),
                        ),
                      ),
                      const SizedBox(
                        height: 20,
                      ),
                      Text(
                        widget._producDetils["product-description"],
                        style: TextStyle(
                          color: Colors.black,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      const SizedBox(
                        height: 20,
                      ),
                    ],
                  ),
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(10),
              child: castomButton(isLoading, "Add to Cart", () {
                //add to cart button
                addtoCart();
              }),
            ),
          ],
        ),
      ),
    );
  }
}

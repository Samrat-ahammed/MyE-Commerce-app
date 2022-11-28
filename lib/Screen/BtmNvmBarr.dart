import 'package:flutter/material.dart';
import 'package:my_ecommerce_app/Screen/BtmNvmBarr_Contrlr/Cart.dart';
import 'package:my_ecommerce_app/Screen/BtmNvmBarr_Contrlr/Favorite.dart';
import 'package:my_ecommerce_app/Screen/BtmNvmBarr_Contrlr/Home.dart';
import 'package:my_ecommerce_app/Screen/BtmNvmBarr_Contrlr/Profile.dart';
import 'package:my_ecommerce_app/Utils/AppColor.dart';

class BtmNvmBarr extends StatefulWidget {
  const BtmNvmBarr({super.key});

  @override
  State<BtmNvmBarr> createState() => _BtmNvmBarrState();
}

class _BtmNvmBarrState extends State<BtmNvmBarr> {
  var currentIndex = 0;
  final _page = [
    const Home(),
    const Favoarite(),
    const Cart(),
    const Profile()
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      bottomNavigationBar: BottomNavigationBar(
        // type: BottomNavigationBarType.fixed,
        backgroundColor: prymariColor,

        currentIndex: currentIndex,
        elevation: 5,
        selectedItemColor: Colors.lightBlue,
        unselectedItemColor: prymariColor,
        // ignore: prefer_const_literals_to_create_immutables
        items: [
          BottomNavigationBarItem(
              backgroundColor: prymariColor,
              icon: Icon(
                Icons.home,
                color: Colors.white,
              ),
              label: ""),
          BottomNavigationBarItem(
              backgroundColor: prymariColor,
              icon: Icon(
                Icons.favorite,
                color: Colors.white,
              ),
              label: ""),
          BottomNavigationBarItem(
              backgroundColor: prymariColor,
              icon: Icon(
                Icons.add_shopping_cart,
                color: Colors.white,
              ),
              label: ""),
          BottomNavigationBarItem(
            backgroundColor: prymariColor,
            label: "",
            icon: Icon(
              Icons.person,
              color: Colors.white,
            ),
          ),
        ],
        onTap: (value) {
          setState(() {
            currentIndex = value;
          });
        },
      ),
      appBar: AppBar(
        automaticallyImplyLeading: false,
        title: const Text(
          "E.Commerce",
          style: TextStyle(
            fontWeight: FontWeight.bold,
            fontSize: 25,
          ),
        ),
        backgroundColor: prymariColor,
        centerTitle: true,
      ),
      body: _page[currentIndex],
    );
  }
}

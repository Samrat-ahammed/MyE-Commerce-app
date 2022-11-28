import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:my_ecommerce_app/Screen/ProductsDetails.dart';
import 'package:my_ecommerce_app/Screen/searchScreen.dart';
import 'package:my_ecommerce_app/Utils/AppColor.dart';
import 'package:dots_indicator/dots_indicator.dart';

class Home extends StatefulWidget {
  const Home({super.key});

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
  List _carouselImages = [];
  var _dotPosition = 0;
  List _products = [];
  var _firestoreInstance = FirebaseFirestore.instance;

  void fetchCarouselImages() async {
    QuerySnapshot snapshot =
        await _firestoreInstance.collection('slider').get();
    setState(
      () {
        for (int i = 0; i < snapshot.docs.length; i++) {
          _carouselImages.add(
            snapshot.docs[i]["img"],
          );
        }
      },
    );
  }

  void fetchProducts() async {
    QuerySnapshot snapshot =
        await _firestoreInstance.collection('products').get();
    setState(
      () {
        for (int i = 0; i < snapshot.docs.length; i++) {
          _products.add(
            {
              "product-name": snapshot.docs[i]["name"],
              "product-description": snapshot.docs[i]["description"],
              "product-price": snapshot.docs[i]["price"],
              "product-img": snapshot.docs[i]["img"],
            },
          );
        }
      },
    );
  }

  @override
  void initState() {
    fetchCarouselImages();
    fetchProducts();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.only(left: 20, right: 20),
          child: Column(
            children: [
              const SizedBox(
                height: 10,
              ),
              Row(
                children: [
                  Expanded(
                    child: SizedBox(
                      height: 60,
                      child: TextFormField(
                        readOnly: true,
                        onTap: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) => Search_Screen(),
                            ),
                          );
                        },
                        decoration: InputDecoration(
                          fillColor: Colors.white,
                          focusedBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(8),
                            borderSide: BorderSide(color: prymariColor),
                          ),
                          enabledBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(8),
                            borderSide: BorderSide(color: Colors.lightBlue),
                          ),
                          hintText: "Search Products here .....",
                          hintStyle: TextStyle(
                              color: prymariColor, fontWeight: FontWeight.bold),
                        ),
                      ),
                    ),
                  ),
                  const SizedBox(
                    width: 10,
                  ),
                  GestureDetector(
                    onTap: () {
                      Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => Search_Screen(),
                          ));
                    },
                    child: Container(
                      height: 60,
                      width: 60,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(8),
                        color: prymariColor,
                      ),
                      child: const Icon(
                        Icons.search,
                        color: Colors.lightBlue,
                        size: 30,
                      ),
                    ),
                  )
                ],
              ),
              const SizedBox(
                height: 10,
              ),
              AspectRatio(
                aspectRatio: 3.0,
                child: CarouselSlider(
                  items: _carouselImages
                      .map(
                        (item) => Padding(
                          padding: const EdgeInsets.only(left: 3, right: 3),
                          child: Container(
                            decoration: BoxDecoration(
                              color: Colors.blue,
                              // image: DecorationImage(
                              //     image: NetworkImage(item),
                              //     fit: BoxFit.fitWidth),
                            ),
                            child: CachedNetworkImage(
                              imageUrl: item,
                              fit: BoxFit.fitWidth,
                              width: double.infinity,
                            ),
                          ),
                        ),
                      )
                      .toList(),
                  options: CarouselOptions(
                    autoPlayAnimationDuration: Duration(milliseconds: 250),
                    // autoPlay: true,
                    enlargeCenterPage: true,
                    viewportFraction: 0.8,
                    enlargeStrategy: CenterPageEnlargeStrategy.height,
                    onPageChanged: (val, carouselPageChangedReason) {
                      setState(
                        () {
                          _dotPosition = val;
                        },
                      );
                    },
                  ),
                ),
              ),
              const SizedBox(
                height: 10,
              ),
              DotsIndicator(
                dotsCount:
                    _carouselImages.length == 0 ? 1 : _carouselImages.length,
                position: _dotPosition.toDouble(),
                decorator: DotsDecorator(
                  activeColor: prymariColor,
                  color: prymariColor.withOpacity(0.5),
                  spacing: EdgeInsets.all(2),
                  activeSize: Size(8, 8),
                  size: Size(6, 6),
                ),
              ),
              Expanded(
                child: GridView.builder(
                  scrollDirection: Axis.horizontal,
                  gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                      crossAxisCount: 2,
                      crossAxisSpacing: 10,
                      childAspectRatio: 1),
                  itemCount: _products.length,
                  itemBuilder: (_, index) {
                    return GestureDetector(
                      onTap: () {
                        Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) =>
                                  ProductsDetils(_products[index]),
                            ));
                        print(_products[index]);
                      },
                      child: Card(
                        elevation: 5,
                        child: Column(
                          children: [
                            AspectRatio(
                              aspectRatio: 2,
                              child: CachedNetworkImage(
                                imageUrl: _products[index]["product-img"],
                                fit: BoxFit.fitWidth,
                                width: double.infinity,
                              ),
                              //  Image.network(
                              //   _products[index]["product-img"],
                              //   fit: BoxFit.cover,
                              // ),
                            ),
                            const SizedBox(
                              height: 15,
                            ),
                            Text("${_products[index]["product-name"]}"
                                .toString()),
                            Text(
                                "${_products[index]["product-price"].toString()}"),
                          ],
                        ),
                      ),
                    );
                  },
                ),
              ),
              Expanded(child: Container())
            ],
          ),
        ),
      ),
    );
  }
}

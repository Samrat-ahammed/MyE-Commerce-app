import 'dart:ffi';

import 'package:flutter/material.dart';
import 'package:my_ecommerce_app/Utils/AppColor.dart';

TextField myTextFild(
  String hintext,
  controller,
) {
  return TextField(
    controller: controller,
    decoration:
        InputDecoration(hintText: hintext, hintStyle: TextStyle(fontSize: 18)
            // border: OutlineInputBorder(),
            ),
  );
}

Widget castomButton(bool isLoading, String buttonName, onPressed) {
  return GestureDetector(
    onTap: onPressed,
    child: Container(
      height: 50,
      width: double.infinity,
      decoration: BoxDecoration(
          color: prymariColor, borderRadius: BorderRadius.circular(8)),
      child: Center(
        child: isLoading
            ? CircularProgressIndicator(
                color: Colors.white,
              )
            : Text(
                buttonName,
                style: TextStyle(
                    color: Colors.white,
                    fontSize: 18,
                    fontWeight: FontWeight.bold),
              ),
      ),
    ),
  );
}

mySnakBarr(message, context) {
  return ScaffoldMessenger.of(context).showSnackBar(
    SnackBar(
      duration: Duration(milliseconds: 250),
      behavior: SnackBarBehavior.floating,
      backgroundColor: Colors.teal,
      content: Text(
        message,
        style: TextStyle(
            color: Colors.white, fontWeight: FontWeight.bold, fontSize: 16),
      ),
    ),
  );
}

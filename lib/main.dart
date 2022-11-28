import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:my_ecommerce_app/Screen/BtmNvmBarr.dart';
import 'package:my_ecommerce_app/Screen/BtmNvmBarr_Contrlr/Home.dart';
import 'package:my_ecommerce_app/Screen/BtmNvmBarr_Contrlr/Profile.dart';
import 'package:my_ecommerce_app/Screen/LoginScreen.dart';
import 'package:my_ecommerce_app/Screen/Signin_screen.dart';
import 'package:my_ecommerce_app/Screen/Splash_Screen.dart';
import 'package:my_ecommerce_app/Screen/UserFrom.dart';
import 'package:my_ecommerce_app/firebase_options.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: (FirebaseAuth.instance.currentUser != null)
          ? SplashScreen()
          : BtmNvmBarr(),
    );
  }
}

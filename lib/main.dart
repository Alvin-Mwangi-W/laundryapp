import 'dart:async';

import 'package:flutter/material.dart';
import 'Onboarding.dart';
import 'package:get/get.dart';

import 'package:firebase_core/firebase_core.dart';
import 'firebase_options.dart';
import 'controllers/CartController.dart';

void main() async {
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  final CartController c = Get.put(CartController());

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: MyHomePage(),
    );
  }
}

class MyHomePage extends StatefulWidget {
  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    Timer(Duration(seconds: 3), openOnBoard);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        height: MediaQuery.of(context).size.height,
        width: MediaQuery.of(context).size.width,
        decoration: BoxDecoration(
            image: DecorationImage(image: AssetImage('asset/images/bg.png'))),
        child: Center(
            child: Container(
          height: 200,
          width: 200,
          decoration: BoxDecoration(
              image:
                  DecorationImage(image: AssetImage('asset/images/logo.png'))),
        )),
      ),
    );
  }

  void openOnBoard() {
    Navigator.push(
      context,
      MaterialPageRoute(builder: (context) => Onboarding()),
    );
  }
}

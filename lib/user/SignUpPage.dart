import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:laundryapp/HomePage.dart';
import 'package:laundryapp/controllers/UserController.dart';
import 'LoginPage.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:http/http.dart' as http;
import 'package:laundryapp/controllers/UserController.dart' as _userController;

class SignUpPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: signUpPage(),
    );
  }
}

class signUpPage extends StatefulWidget {
  @override
  _signUpPageState createState() => _signUpPageState();
}

class _signUpPageState extends State<signUpPage> {
  UserController userController = Get.find();

  String name = "";
  var physicalAddress = "";
  var email = "";
  var password = "";
  bool loading = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        padding: const EdgeInsets.all(20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const SizedBox(
              height: 50,
            ),
            Container(
              height: 70,
              width: 70,
              decoration: const BoxDecoration(
                  image: DecorationImage(
                      image: AssetImage('asset/images/logo.png'))),
            ),
            Expanded(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Text(
                    "Sign Up",
                    style: TextStyle(
                        color: Colors.orange,
                        fontSize: 30,
                        fontWeight: FontWeight.w700,
                        fontFamily: 'sfpro'),
                  ),
                  const SizedBox(
                    height: 10,
                  ),
                  TextField(
                    onChanged: (value) {
                      name = value;
                    },
                    decoration: InputDecoration(
                      labelText: "Name",
                    ),
                  ),
                  TextField(
                    onChanged: (value) {
                      physicalAddress = value;
                    },
                    decoration: InputDecoration(
                      labelText: "Physical Address",
                    ),
                  ),
                  TextField(
                    onChanged: (value) {
                      email = value;
                    },
                    decoration: InputDecoration(
                      labelText: "Email Address",
                    ),
                  ),
                  TextField(
                    onChanged: (value) {
                      password = value;
                    },
                    decoration: InputDecoration(
                      labelText: "Password",
                    ),
                  ),
                  const SizedBox(
                    height: 30,
                  ),
                  InkWell(
                    onTap: () {
                      RegisterUser();
                    },
                    child: Container(
                      padding: const EdgeInsets.symmetric(vertical: 20),
                      width: MediaQuery.of(context).size.width,
                      decoration: const BoxDecoration(
                          borderRadius: BorderRadius.all(Radius.circular(40)),
                          gradient: LinearGradient(
                              colors: [Color(0xfff3953b), Color(0xffe57509)],
                              stops: [0, 1],
                              begin: Alignment.topCenter)),
                      child: const Center(
                        child: Text(
                          "SIGN UP",
                          style: TextStyle(
                              color: Colors.white,
                              fontSize: 22,
                              fontWeight: FontWeight.w700,
                              fontFamily: 'sfpro'),
                        ),
                      ),
                    ),
                  ),
                  const SizedBox(
                    height: 10,
                  ),
                  const Text(
                    "By pressing signup you agree to our terms and conditions",
                    style: TextStyle(fontSize: 15),
                    textAlign: TextAlign.center,
                  )
                ],
              ),
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                const Text(
                  "Already have an account?",
                  style: TextStyle(fontSize: 16, fontFamily: 'sfpro'),
                ),
                InkWell(
                  onTap: openLoginPage,
                  child: loading
                      ? const CircularProgressIndicator()
                      : const Text(
                          "SignUp",
                          style: TextStyle(
                              fontSize: 16,
                              fontFamily: 'sfpro',
                              fontWeight: FontWeight.w700),
                        ),
                )
              ],
            ),
            const SizedBox(
              height: 10,
            )
          ],
        ),
      ),
    );
  }

  void openLoginPage() {
    Navigator.push(
        context, MaterialPageRoute(builder: (context) => LoginPage()));
  }

  void RegisterUser() {
    setState(() {
      loading = true;
    });
    print("Registering User....");
    FirebaseAuth.instance
        .createUserWithEmailAndPassword(email: email, password: password)
        .then((signedInUser) {
      print("User Registered Successfully");

      saveUserToDatabase();
    }).catchError((e) {
      setState(() {
        loading = false;
      });
      ScaffoldMessenger.of(context).showSnackBar(SnackBar(
        content: Text(e.toString()),
      ));
      print(e);
    });
  }

  void saveUserToDatabase() {
    print("Saving User to Database");
    var names = name.split(" ");
    var data = {
      "id": FirebaseAuth.instance.currentUser!.uid,
      "firstName": names[0],
      "lastName": names[1],
      "email": email,
      "address": physicalAddress,
    };

    var url = Uri.parse('http://localhost:8080/customers'); //todo: chnage this
    http
        .post(url,
            headers: {
              "Content-Type": "application/json",
              "accept": "application/json"
            },
            body: jsonEncode(data))
        .then((response) {
      var responseBody = jsonDecode(response.body);
      print("customer created");
      print(responseBody);
      userController.user.value = _userController.User(
          id: data['id']!,
          firstName: data["firstName"]!,
          lastName: data["lastName"]!,
          email: data["email"]!,
          address: data["address"]!);
      Navigator.push(
          context, MaterialPageRoute(builder: (context) => HomePage()));
    }).catchError((err) {
      setState(() {
        loading = false;
      });
      ScaffoldMessenger.of(context)
          .showSnackBar(SnackBar(content: Text(err.toString())));
      throw err;
    });
  }
}

import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:laundryapp/HomePage.dart';
import 'package:laundryapp/controllers/UserController.dart';
import 'SignUpPage.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:http/http.dart' as http;
import 'package:laundryapp/controllers/UserController.dart' as _userController;

class LoginPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: ThemeData(fontFamily: 'roboto'),
      home: loginPage(),
    );
  }
}

class loginPage extends StatefulWidget {
  @override
  _loginPageState createState() => _loginPageState();
}

class _loginPageState extends State<loginPage> {
  var email = "";
  var password = "";
  var loading = false;
  UserController userController = Get.find();

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
                    "Welcome Back!",
                    style: TextStyle(
                        color: Colors.orange,
                        fontSize: 30,
                        fontWeight: FontWeight.w700,
                        fontFamily: 'sfpro'),
                  ),
                  const Text(
                    "Please Log In to Your Account",
                    style: TextStyle(
                      color: Colors.grey,
                      fontSize: 20,
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                  const SizedBox(
                    height: 10,
                  ),
                  TextField(
                    onChanged: (value) {
                      email = value;
                    },
                    decoration: InputDecoration(
                      labelText: "Email",
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
                  Row(
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: [
                      const Text(
                        "Forgot Password?",
                        style: TextStyle(color: Colors.grey),
                      ),
                    ],
                  ),
                  const SizedBox(
                    height: 30,
                  ),
                  InkWell(
                    onTap: logIn,
                    child: Container(
                      padding: const EdgeInsets.symmetric(vertical: 20),
                      width: MediaQuery.of(context).size.width,
                      decoration: const BoxDecoration(
                          borderRadius: BorderRadius.all(Radius.circular(40)),
                          gradient: LinearGradient(
                              colors: [Color(0xfff3953b), Color(0xffe57509)],
                              stops: [0, 1],
                              begin: Alignment.topCenter)),
                      child: Center(
                        child: loading
                            ? const CircularProgressIndicator()
                            : const Text(
                                "LOGIN",
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
                    height: 20,
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Expanded(
                        child: Container(
                          height: 1,
                          color: Colors.grey,
                        ),
                      ),
                      Center(
                        child: Container(
                            padding: const EdgeInsets.all(10),
                            child: const Text("OR")),
                      ),
                      Expanded(
                        child: Container(
                          height: 1,
                          color: Colors.grey,
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(
                    height: 20,
                  ),
                  // Row(
                  //   mainAxisAlignment: MainAxisAlignment.center,
                  //   children: [
                  //     Container(
                  //       height: 60,
                  //       width: 60,
                  //       decoration: BoxDecoration(
                  //           shape: BoxShape.circle,
                  //           border:
                  //               Border.all(color: Colors.black, width: 0.5)),
                  //       child: Container(
                  //         decoration: const BoxDecoration(
                  //             image: DecorationImage(
                  //                 image: AssetImage(
                  //                     'asset/images/googleLogo.png'))),
                  //       ),
                  //     ),
                  //     const SizedBox(
                  //       width: 20,
                  //     ),
                  //     Container(
                  //       height: 60,
                  //       width: 60,
                  //       decoration: BoxDecoration(
                  //           shape: BoxShape.circle,
                  //           border:
                  //               Border.all(color: Colors.black, width: 0.5)),
                  //       child: Container(
                  //         decoration: const BoxDecoration(
                  //             image: DecorationImage(
                  //                 image:
                  //                     AssetImage('asset/images/fbLogo.png'))),
                  //       ),
                  //     )
                  //   ],
                  // )
                ],
              ),
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                const Text(
                  "Don't have an account?",
                  style: TextStyle(fontSize: 16, fontFamily: 'sfpro'),
                ),
                InkWell(
                  onTap: openSignUpPage,
                  child: const Text(
                    " SIGN UP",
                    style: TextStyle(
                        color: Colors.orange,
                        fontSize: 16,
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

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    if (FirebaseAuth.instance.currentUser != null) {
      ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
        content: Text("Already Logged In....Fetching profile"),
      ));
      fetchUser();
    }
  }

  void openSignUpPage() {
    Navigator.push(
        context, MaterialPageRoute(builder: (context) => SignUpPage()));
  }

  void logIn() {
    setState(() {
      loading = true;
    });
    print("signing in");
    FirebaseAuth.instance
        .signInWithEmailAndPassword(email: email, password: password)
        .then((value) {
      fetchUser();
    }).catchError((err) {
      setState(() {
        loading = false;
      });
      ScaffoldMessenger.of(context).showSnackBar(SnackBar(
        content: Text(err.toString()),
      ));
      print(err);
    });
  }

  void fetchUser() {
    var url = Uri.parse(
        'http://localhost:8080/customers/${FirebaseAuth.instance.currentUser!.uid}'); //todo: chnage this
    http.get(
      url,
      headers: {
        "Content-Type": "application/json",
        "accept": "application/json"
      },
    ).then((response) {
      var responseBody = jsonDecode(response.body);
      print("customer fetched");
      print(responseBody);
      userController.user.value = _userController.User(
          id: responseBody['id'],
          firstName: responseBody["firstName"]!,
          lastName: responseBody["lastName"]!,
          email: responseBody["email"]!,
          address: responseBody["address"]!);
      Navigator.push(
          context, MaterialPageRoute(builder: (context) => HomePage()));
    });
  }
}

import 'package:flutter/material.dart';
import 'package:laundryapp/HomePage.dart';
import 'LoginPage.dart';
import 'package:firebase_auth/firebase_auth.dart';

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
  var name = "";
  var phoneNumber = "";
  var email = "";
  var password = "";
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
                  const TextField(
                    onChanged: (value) {
                      name = value;
                    },
                    decoration: InputDecoration(
                      labelText: "Name",
                    ),
                  ),
                  const TextField(
                    decoration: InputDecoration(
                      onChanged: (value) {
                        phoneNumber = value;
                      },
                      labelText: "Phone Number",
                    ),
                  ),
                  const TextField(
                    decoration: InputDecoration(
                      onChanged: (value) {
                        email = value;
                      },
                      labelText: "Email Address",
                    ),
                  ),
                  const TextField(
                    decoration: InputDecoration(
                      onChanged: (value) {
                        password = value;
                      },
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
                  child: const Text(
                    " LOGIN",
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

  void openLoginPage() {
    Navigator.push(
        context, MaterialPageRoute(builder: (context) => LoginPage()));
  }

  void RegisterUser() {
    print("Registering User....");
    FirebaseAuth.instance
        .createUserWithEmailAndPassword(email: email, password: password)
        .then((signedInUser) {
      print("User Registered Successfully");
      Navigator.push(
          context, MaterialPageRoute(builder: (context) => HomePage()));
    }).catchError((e) {
      print(e);
    });
  }
}

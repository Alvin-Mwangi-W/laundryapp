import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/container.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:laundryapp/orders/OrdersList.dart';
import 'package:http/http.dart' as http;

class AdminPage extends StatefulWidget {
  AdminPage({Key? key}) : super(key: key);

  @override
  State<AdminPage> createState() => _AdminPageState();
}

class _AdminPageState extends State<AdminPage> {
  var orders = [];
  bool isAdmin = false;
  var userInput = "";
  var adminPassword = "admin";

  @override
  Widget build(BuildContext context) {
    return isAdmin
        ? OrdersList(
            isAdmin: true,
            orders: orders,
          )
        : buildAdminSignin();
  }

  Widget buildAdminSignin() {
    return Center(
      child: SizedBox(
        width: 400,
        // height: 400,
        child: Card(
          elevation: 5,
          child: Container(
            padding: const EdgeInsets.all(20),
            child: Column(
              children: [
                TextField(
                  onChanged: ((value) {
                    userInput = value;
                  }),
                  decoration:
                      const InputDecoration(hintText: "Enter Admin Password"),
                ),
                Container(
                  margin: const EdgeInsets.only(top: 20),
                  child: ElevatedButton(
                    style: ElevatedButton.styleFrom(
                      padding:
                          EdgeInsets.symmetric(vertical: 10, horizontal: 20),
                      foregroundColor: Colors.white,
                      backgroundColor: Colors.orange,
                    ),
                    onPressed: () async {
                      if (userInput == adminPassword) {
                        setState(() {
                          isAdmin = true;
                        });
                      } else {
                        ScaffoldMessenger.of(context).showSnackBar(
                            const SnackBar(content: Text("Wrong Password")));
                      }
                    },
                    child: const Text("Enter"),
                  ),
                )
              ],
            ),
          ),
        ),
      ),
    );
  }

  @override
  void initState() {
    super.initState();

    var url = Uri.parse('http://localhost:8080/orders');
    http.get(url, headers: {
      "Content-Type": "application/json",
      "accept": "application/json"
    }).then((response) {
      var responseBody = jsonDecode(response.body);
      print("orders");
      print(responseBody);
      setState(() {
        orders = responseBody;
      });
    }).catchError((err) {
      print(err);
      ScaffoldMessenger.of(context)
          .showSnackBar(SnackBar(content: Text(err.toString())));
    });
  }
}

import 'dart:convert';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:laundryapp/orders/OrdersList.dart';
import 'package:laundryapp/orders/OrdersList.dart';
import 'package:http/http.dart' as http;

class MyOrders extends StatefulWidget {
  MyOrders({Key? key}) : super(key: key);

  @override
  State<MyOrders> createState() => _MyOrdersState();
}

class _MyOrdersState extends State<MyOrders> {
  var orders = [];

  @override
  Widget build(BuildContext context) {
    return OrdersList(
      isAdmin: false,
      orders: orders,
    );
  }

  @override
  void initState() {
    super.initState();
    var customerId = FirebaseAuth.instance.currentUser!.uid;
    var url = Uri.parse(
        'http://localhost:8080/orders?customerId=${customerId}'); //todo: chnage this
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

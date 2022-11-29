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

  @override
  Widget build(BuildContext context) {
    return OrdersList(
      isAdmin: true,
      orders: orders,
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

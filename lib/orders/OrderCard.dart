// ignore_for_file: unnecessary_brace_in_string_interps

import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

class OrderCard extends StatelessWidget {
  final String orderId;
  final String orderStatus;
  final String firstName;
  final String lastName;
  final List items;
  final bool isAdmin;

  const OrderCard(
      {Key? key,
      required this.isAdmin,
      required this.firstName,
      required this.lastName,
      required this.items,
      required this.orderId,
      required this.orderStatus})
      : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Container(
      child: Card(
        elevation: 5,
        child: Column(
          children: [
            ListTile(
              leading: isAdmin
                  ? CircleAvatar(
                      backgroundColor: const Color.fromARGB(0, 131, 131, 131),
                      child: Text("${firstName[0]} ${lastName[0]}"),
                    )
                  : null,
              title: isAdmin ? Text("${firstName} ${lastName}") : null,
              subtitle: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text("Order: $orderId"),
                  Text("Status: $orderStatus"),
                  const Text("Items:"),
                  ListView.builder(
                      shrinkWrap: true,
                      itemCount: items.length,
                      itemBuilder: (context, int) {
                        var item = items[int];
                        return Text(
                            "${item["clothing"]["name"]}  x${item["quantity"]} ");
                      }),
                  isAdmin
                      ? Row(
                          mainAxisAlignment: MainAxisAlignment.start,
                          children: [
                              const Text("Update order"),
                              TextButton(
                                  onPressed: () {
                                    updateOrderStatus("WASHING",
                                        context: context);
                                  },
                                  child: const Text("Washing",
                                      style: TextStyle(color: Colors.green))),
                              TextButton(
                                  onPressed: () {
                                    updateOrderStatus("PENDING_DELIVERY",
                                        context: context);
                                  },
                                  child: const Text("Pending Delivery",
                                      style: TextStyle(color: Colors.red))),
                              TextButton(
                                  onPressed: () {
                                    updateOrderStatus("DELIVERED",
                                        context: context);
                                  },
                                  child: const Text("Delivered",
                                      style: TextStyle(color: Colors.green))),
                              TextButton(
                                  onPressed: () {
                                    updateOrderStatus("RECEIVED",
                                        context: context);
                                  },
                                  child: const Text("Received",
                                      style: TextStyle(color: Colors.red))),
                            ])
                      : Container()
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  void updateOrderStatus(String status, {required BuildContext context}) async {
    ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
      content: Text(
        "Updating order status...",
      ),
      duration: Duration(seconds: 5),
    ));
    var data = {"status": status};

    var url = Uri.parse(
        'http://localhost:8080/orders/${orderId}'); //todo: chnage this
    http
        .put(url,
            headers: {
              "Content-Type": "application/json",
              "accept": "application/json"
            },
            body: jsonEncode(data))
        .then((response) {
      var responseBody = jsonDecode(response.body);
      print("order updated");
      print(responseBody);
      ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
        content: Text("Order updated.Refresh to see changes"),
        duration: Duration(seconds: 5),
      ));
    }).catchError((err) {
      ScaffoldMessenger.of(context)
          .showSnackBar(SnackBar(content: Text(err.toString())));
      throw err;
    });
  }
}

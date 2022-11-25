import 'dart:convert';

import 'package:flutter/material.dart';

import 'package:laundryapp/orders/OrderCard.dart';

class OrdersList extends StatefulWidget {
  final bool isAdmin;
  final List orders;
  const OrdersList({super.key, this.isAdmin = false, required this.orders});

  @override
  State<OrdersList> createState() => _OrdersListState();
}

class _OrdersListState extends State<OrdersList> {
  @override
  Widget build(BuildContext context) {
    return ListView.builder(
        shrinkWrap: true,
        itemCount: widget.orders.length,
        itemBuilder: (context, index) {
          var order = widget.orders[index];
          return Container(
            margin: const EdgeInsets.symmetric(vertical: 3, horizontal: 5),
            child: OrderCard(
                isAdmin: widget.isAdmin,
                firstName: order["Customer"]["firstName"],
                lastName: order["Customer"]["lastName"],
                items: order["items"],
                orderId: order["id"].toString(),
                orderStatus: order["orderStatus"]),
          );
        });
  }
}

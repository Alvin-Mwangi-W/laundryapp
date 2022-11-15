import 'package:flutter/material.dart';
import 'package:get/get.dart';

class CartController extends GetxController {
  var cartItems = <Rx<ClothingItem>>[
    ClothingItem(name: 'trouser', price: 50, image: 'cloth1.png', quantity: 1)
        .obs,
    ClothingItem(name: 'shirt', price: 50, image: 'cloth2.png', quantity: 1)
        .obs,
    ClothingItem(name: 'hood', price: 50, image: 'cloth3.png', quantity: 1).obs,
    ClothingItem(name: 't-shirt', price: 50, image: 'cloth4.png', quantity: 1)
        .obs,
    ClothingItem(name: 'socks', price: 50, image: 'cloth5.png', quantity: 1)
        .obs,
    ClothingItem(name: 'blanket', price: 50, image: 'cloth6.png', quantity: 1)
        .obs,
    ClothingItem(name: 'short', price: 50, image: 'cloth7.png', quantity: 1).obs
  ].obs;
  var cartTotal = 0.0.obs;

  void addToCart(ClothingItem item) {
    cartItems.add(item.obs);
    cartTotal.value += item.price;
  }

  void removeFromCart(item) {
    cartItems.remove(item);
    cartTotal.value -= item.price;
  }

  void updateItem(ClothingItem item, int quantity) {
    print("try updating ${item.name} ${quantity}");
    cartItems.forEach((element) {
      // if (element.value.name == item.name) {
      //   element.value.quantity = quantity;
      //   print("${element.value.name} ${element.value.quantity}");
      //   cartTotal.value = 0;
      //   cartItems.forEach((element) {
      //     cartTotal.value += element.value.price * element.value.quantity;
      //   });
      //   print("total now = ${cartTotal.value}");
      // }
      //return element;
    });
    for (var i = 0; i < cartItems.length; i++) {
      print("${cartItems[i].value.name} ${cartItems[i].value.quantity}");
      if (cartItems[i].value.name == item.name) {
        cartItems[i].value.quantity = quantity;
        print("${cartItems[i].value.name} ${cartItems[i].value.quantity}");
        cartTotal.value = 0;
        cartItems.forEach((element) {
          cartTotal.value += element.value.price * element.value.quantity;
        });
        print("total now = ${cartTotal.value}");
      }
    }
  }
}

class ClothingItem {
  final String name;
  final double price;
  final String image;
  int quantity;

  ClothingItem(
      {required this.name,
      required this.price,
      required this.image,
      required this.quantity});
}

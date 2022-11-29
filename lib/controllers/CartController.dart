import 'package:flutter/material.dart';
import 'package:get/get.dart';

class CartController extends GetxController {
  var cartItems = <Rx<ClothingItem>>[
    ClothingItem(
            id: 1, name: 'trouser', price: 50, image: 'cloth1.png', quantity: 0)
        .obs,
    ClothingItem(
            id: 2, name: 'shirt', price: 50, image: 'cloth2.png', quantity: 0)
        .obs,
    ClothingItem(
            id: 3, name: 'hood', price: 50, image: 'cloth3.png', quantity: 0)
        .obs,
    ClothingItem(
            id: 4, name: 't-shirt', price: 50, image: 'cloth4.png', quantity: 0)
        .obs,
    ClothingItem(
            id: 5, name: 'socks', price: 50, image: 'cloth5.png', quantity: 0)
        .obs
  ].obs;
  var cartTotal = 0.0.obs;
  var clothesCount = 0.obs;

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

    for (var i = 0; i < cartItems.length; i++) {
      // print("${cartItems[i].value.name} ${cartItems[i].value.quantity}");
      if (cartItems[i].value.name == item.name) {
        cartItems[i].value.quantity = quantity;
        cartItems[i].update((item) {
          item?.quantity = quantity;
        });

        // print("${cartItems[i].value.name} ${cartItems[i].value.quantity}");
        cartTotal.value = 0;
        cartItems.forEach((element) {
          cartTotal.value += element.value.price * element.value.quantity;
        });
        //print("total now = ${cartTotal.value}");
      }
    }

    countItems();
    print("after coubnt items ${clothesCount.value}");
  }

  void countItems() {
    clothesCount.value = 0;
    cartItems.forEach((element) {
      clothesCount.value += element.value.quantity;
    });
  }
}

class ClothingItem {
  final String name;
  final double price;
  final String image;
  int quantity;
  int id;

  ClothingItem(
      {required this.id,
      required this.name,
      required this.price,
      required this.image,
      required this.quantity});
}

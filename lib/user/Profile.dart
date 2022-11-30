import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:laundryapp/controllers/UserController.dart';

class Profile extends StatelessWidget {
  Profile({Key? key}) : super(key: key);
  UserController userController = Get.find();

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        Flex(direction: Axis.vertical, children: [
          Flexible(
            flex: 3,
            child: Container(
              color: Colors.orange,
            ),
          ),
          Expanded(
            flex: 2,
            child: Container(
              padding: EdgeInsets.only(top: 40),
              color: Colors.white,
              child: Column(
                children: [
                  Container(
                    margin: const EdgeInsets.only(top: 20),
                    child: Text(
                        "${userController.user.value.firstName} ${userController.user.value.lastName}"),
                  ),
                  Container(
                      margin: const EdgeInsets.only(top: 20),
                      child: Text("Email: ${userController.user.value.email}")),
                  Container(
                      margin: const EdgeInsets.only(top: 20, bottom: 20),
                      child: Text(
                          "Address: ${userController.user.value.address}")),
                  ElevatedButton(
                      style: ButtonStyle(
                          backgroundColor:
                              MaterialStateProperty.all(Colors.orange)),
                      onPressed: () {
                        FirebaseAuth.instance.signOut();
                      },
                      child: Text("LOG OUT"))
                ],
              ),
            ),
          ),
        ]),
        Positioned.fill(
          top: MediaQuery.of(context).size.height * 0.3,
          child: Align(
            alignment: Alignment.topCenter,
            child: CircleAvatar(
                backgroundColor: Colors.grey,
                radius: 80,
                child: Text(
                  "${userController.user.value.firstName[0]} ${userController.user.value.lastName[0]}",
                  style: TextStyle(fontWeight: FontWeight.w600, fontSize: 40, color: Colors.white),
                )),
          ),
        ),
      ],
    );
  }
}

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
            flex: 2,
            child: Container(
              color: Colors.orange,
            ),
          ),
          Expanded(
            flex: 3,
            child: Container(
              color: Colors.white,
              child: Column(
                children: [
                  Text(
                      "${userController.user.value.firstName} ${userController.user.value.lastName}"),
                  Text("Email: ${userController.user.value.email}"),
                  Text("Address: ${userController.user.value.address}"),
                ],
              ),
            ),
          ),
        ]),
        Positioned(
          top: MediaQuery.of(context).size.height * 0.5,
          left: MediaQuery.of(context).size.width * 0.5,
          child: CircleAvatar(
              backgroundColor: Colors.grey,
              radius: 100,
              child: Text(
                "${userController.user.value.firstName[0]} ${userController.user.value.lastName[0]}",
                style: TextStyle(fontWeight: FontWeight.w600),
              )),
        ),
      ],
    );
  }
}

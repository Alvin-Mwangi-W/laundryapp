import 'package:get/get.dart';

class UserController extends GetxController {
  var user = User().obs;

  void updateUser(User user) {
    this.user.value = user;
  }
}

class User {
  String id;
  String firstName;
  String lastName;
  String email;
  String address;

  User(
      {this.id = "",
      this.firstName = "",
      this.lastName = "",
      this.email = "",
      this.address = ""});
}

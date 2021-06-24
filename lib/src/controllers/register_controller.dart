import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_sign_in/google_sign_in.dart';

class RegisterController extends GetxController {
  final FirebaseAuth _auth = FirebaseAuth.instance;
  final formKey = GlobalKey<FormState>();
  final emailController = TextEditingController();
  final passwordController = TextEditingController();

  bool success;
  String userEmail;

  void dispose() {
    //lipmia el controlador cuando el Widget esta dispuesto
    emailController.dispose();
    passwordController.dispose();
    super.dispose();
  }

  void register() async {
    final User user = (await _auth.createUserWithEmailAndPassword(
      email: emailController.text,
      password: passwordController.text,
    ))
        .user;
    if (user != null) {
      success = true;
      print('se registro');
      Future.delayed(
        Duration(seconds: 2),
        () {
          Get.toNamed('/HomePage');
        },
      );
      userEmail = user.email;
    } else {
      success = false;
    }
  }
}

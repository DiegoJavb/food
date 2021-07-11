import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class RegisterController extends GetxController {
  final FirebaseAuth _auth = FirebaseAuth.instance;
  final formKey = GlobalKey<FormState>();
  final emailController = TextEditingController();
  final passwordController = TextEditingController();

  late bool success;
  late String userEmail;

  void dispose() {
    //lipmia el controlador cuando el Widget esta dispuesto
    emailController.dispose();
    passwordController.dispose();
    super.dispose();
  }

  void registerUserWithEmailAndPassword() async {
    final User? user = (await _auth.createUserWithEmailAndPassword(
      email: emailController.text,
      password: passwordController.text,
    ))
        .user!;
    if (user != null) {
      Get.snackbar(
        'Hola',
        'Ha ingresado correctamente',
      );
      success = true;
      Future.delayed(
        Duration(seconds: 2),
        () {
          Get.toNamed(
            'home',
          );
        },
      );
      userEmail = user.email!;
    } else {
      success = false;
    }
  }
}

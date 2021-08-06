import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:food/src/controllers/database_evaluation.dart';
import 'package:food/src/controllers/database_user_controller.dart';
import 'package:get/get.dart';
import 'package:food/src/providers/role_pass.dart' as role;

import 'database_controller.dart';

class RegisterController extends GetxController {
  final FirebaseAuth _auth = FirebaseAuth.instance;
  GlobalKey<FormState> formKey = GlobalKey<FormState>();
  final emailController = TextEditingController();
  final passwordController = TextEditingController();

  late bool success;
  late String userEmail;

  void dispose() {
    emailController.dispose();
    passwordController.dispose();
    super.dispose();
  }

  void registerUserWithEmailAndPassword() async {
    String name = '';
    final User? user = (await _auth.createUserWithEmailAndPassword(
      email: emailController.text,
      password: passwordController.text,
    ))
        .user!;
    if (user != null) {
      print(role.rolUser);
      DatabaseUser.userUid = user.email;
      DatabaseEvaluations.userUid = user.email;
      Database.userUid = user.email;
      await DatabaseUser.addUser(
        email: user.email!,
        role: role.rolUser,
        docId: user.uid,
      );
      await DatabaseUser.addUserOnListUsers(
        email: user.email!,
        name: name,
        docId: user.uid,
      );
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

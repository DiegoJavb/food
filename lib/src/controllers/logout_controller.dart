import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';

class LogoutController extends GetxController {
  final FirebaseAuth _auth = FirebaseAuth.instance;
  GlobalKey<FormState> logoutFormKey = GlobalKey<FormState>();
//salir
  void _signOut() async {
    // ignore: await_only_futures
    await _auth.signOut;
  }

  void signOut() async {
    final User? user = _auth.currentUser;
    if (user == null) {
      Get.snackbar(
        'Salir',
        'Nadie ha salido',
        snackPosition: SnackPosition.BOTTOM,
      );
    }
    _signOut();
    final String uid = user!.email!;
    Get.snackbar(
      'Salir',
      uid + ' ha salido con exito ',
      snackPosition: SnackPosition.TOP,
    );
    Future.delayed(
      Duration(seconds: 3),
      () {
        Get.toNamed(
          '/',
        );
      },
    );
  }
}

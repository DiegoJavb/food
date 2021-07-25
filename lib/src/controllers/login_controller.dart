import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:food/src/controllers/database_controller.dart';
import 'package:food/src/controllers/database_user_controller.dart';
import 'package:get/get.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:food/src/providers/role_pass.dart' as role;

class LoginController extends GetxController {
  final FirebaseAuth _auth = FirebaseAuth.instance;
  GlobalKey<FormState> formKey = GlobalKey<FormState>();
  final emailController = TextEditingController();
  final passwordController = TextEditingController();

  //Inicio de sesion con email y passwort
  void signInWithEmailAndPassword() async {
    try {
      (await _auth.signInWithEmailAndPassword(
        email: emailController.text,
        password: passwordController.text,
      ))
          .user;
      Get.snackbar(
        'Hola',
        'Ha ingresado correctamente',
      );
      DatabaseUser.userUid = emailController.text;
      Database.userUid = emailController.text;
      Future.delayed(
        Duration(seconds: 2),
        () {
          Get.toNamed(
            'home',
          );
        },
      );
    } catch (e) {
      Get.snackbar(
        'Fallo',
        'No puede ingresar',
        snackPosition: SnackPosition.BOTTOM,
      );
    }
  }

  //Ingreso con Google
  void signInWithGoogle() async {
    try {
      UserCredential userCredential;
      final GoogleSignInAccount googleUser = (await GoogleSignIn().signIn())!;
      final GoogleSignInAuthentication googleAuth =
          await googleUser.authentication;
      final OAuthCredential googleAuthCredential =
          GoogleAuthProvider.credential(
        accessToken: googleAuth.accessToken,
        idToken: googleAuth.idToken,
      );
      userCredential = await _auth.signInWithCredential(googleAuthCredential);
      final user = userCredential.user;
      print('UID del usuario que quiere ingresar: ${user!.uid}');
      Database.userUid = user.email;
      DatabaseUser.userUid = user.email;
      await DatabaseUser.addUser(
        email: user.email!,
        role: role.rolUser,
        docId: user.uid,
      );
      await DatabaseUser.addUserOnListUsers(
        email: user.email!,
        name: user.displayName!,
        docId: user.uid,
      );
      Get.snackbar(
        'Hola',
        '${user.displayName} iniciaste sesión con Google',
      );

      print('Ingreso bien');
      Future.delayed(
        Duration(seconds: 3),
        () {
          Get.toNamed(
            'home',
          );
        },
      );
    } catch (e) {
      print(e);
      Get.snackbar(
        'Fallo',
        'No se puedo acceder con su cuenta de Google: $e',
        snackPosition: SnackPosition.BOTTOM,
      );
    }
  }

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

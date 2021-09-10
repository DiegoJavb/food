import 'package:firebase_auth/firebase_auth.dart';
import 'package:food/src/controllers/database_evaluation.dart';
import 'package:food/src/controllers/database_infoUser.dart';
import 'package:food/src/controllers/database_user_controller.dart';
import 'package:get/get.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:food/src/providers/role_pass.dart' as role;
import 'database_controller.dart';

class RegisterController extends GetxController {
  final FirebaseAuth _auth = FirebaseAuth.instance;

  late bool success;
  late String userEmail;

  void registerUserWithEmailAndPassword(String email, String password) async {
    try {
      final User? user = (await _auth.createUserWithEmailAndPassword(
        email: email,
        password: password,
      ))
          .user!;
      if (user != null) {
        print(role.rolUser);
        DatabaseUser.userUid = user.email;
        DatabaseEvaluations.userUid = user.email;
        Database.userUid = user.email;
        DatabaseUserInfo.userUid = user.email;
        await DatabaseUser.addUser(
          email: user.email!,
          role: role.rolUser,
          docId: user.uid,
        );
        guardarUsuario(user.email!);
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
    } catch (e) {
      Get.snackbar(
        'Fallo',
        '$e',
        duration: Duration(seconds: 3),
        snackPosition: SnackPosition.BOTTOM,
      );
    }
  }
}

Future<void> guardarUsuario(String email) async {
  SharedPreferences prefs = await SharedPreferences.getInstance();
  await prefs.setString('email', email);
}

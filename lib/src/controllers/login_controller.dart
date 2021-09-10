import 'package:firebase_auth/firebase_auth.dart';
import 'package:food/src/controllers/database_controller.dart';
import 'package:food/src/controllers/database_evaluation.dart';
import 'package:food/src/controllers/database_infoUser.dart';
import 'package:food/src/controllers/database_user_controller.dart';
import 'package:get/get.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:food/src/providers/role_pass.dart' as role;

class LoginController extends GetxController {
  final FirebaseAuth _auth = FirebaseAuth.instance;

  //Inicio de sesion con email y passwort
  void signInWithEmailAndPassword(String email, String password) async {
    try {
      (await _auth.signInWithEmailAndPassword(email: email, password: password))
          .user;
      Get.snackbar(
        'Hola',
        'Ha ingresado correctamente',
      );
      guardarUsuario(email);
      DatabaseUser.userUid = email;
      DatabaseUserInfo.userUid = email;
      DatabaseEvaluations.userUid = email;
      Database.userUid = email;
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
        'La combinación de usuario y contraseña no coinciden',
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
      guardarUsuario(user.email!);
      DatabaseUser.userUid = user.email;
      Database.userUid = user.email;
      DatabaseEvaluations.userUid = user.email;
      DatabaseUserInfo.userUid = user.email;
      await DatabaseUser.addUser(
        email: user.email!,
        role: role.rolUser,
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
}

Future<void> guardarUsuario(String email) async {
  SharedPreferences prefs = await SharedPreferences.getInstance();
  await prefs.setString('email', email);
}

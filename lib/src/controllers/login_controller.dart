import 'package:firebase_auth/firebase_auth.dart';
import 'package:food/src/controllers/database_controller.dart';
import 'package:food/src/controllers/database_evaluation.dart';
import 'package:food/src/controllers/database_user_controller.dart';
import 'package:get/get.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:food/src/providers/role_pass.dart' as role;

class LoginController extends GetxController {
  final FirebaseAuth _auth = FirebaseAuth.instance;
  // GlobalKey<FormState> loginFormKey = GlobalKey<FormState>();
  // final emailController = TextEditingController();
  // final passwordController = TextEditingController();
  bool _loggedIn = false;
  bool isLoggedIn() => _loggedIn;
  //Inicio de sesion con email y passwort
  void signInWithEmailAndPassword(String email, String password) async {
    try {
      (await _auth.signInWithEmailAndPassword(email: email, password: password))
          .user;
      Get.snackbar(
        'Hola',
        'Ha ingresado correctamente',
      );
      _loggedIn = true;
      DatabaseUser.userUid = email;
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
      DatabaseUser.userUid = user.email;
      Database.userUid = user.email;
      DatabaseEvaluations.userUid = user.email;
      await DatabaseUser.addUser(
        email: user.email!,
        role: role.rolUser,
        docId: user.uid,
      );
      Get.snackbar(
        'Hola',
        '${user.displayName} iniciaste sesión con Google',
      );
      _loggedIn = true;

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

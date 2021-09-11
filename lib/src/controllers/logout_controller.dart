import 'package:firebase_auth/firebase_auth.dart';
import 'package:get/get.dart';
import 'package:shared_preferences/shared_preferences.dart';

class LogoutController extends GetxController {
  final FirebaseAuth _auth = FirebaseAuth.instance;

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
      uid + ' ha salido con éxito ',
      snackPosition: SnackPosition.TOP,
    );
    borraUsuario();
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

Future<void> borraUsuario() async {
  SharedPreferences prefs = await SharedPreferences.getInstance();
  prefs.remove('email');
}

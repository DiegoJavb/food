import 'package:flutter_test/flutter_test.dart';
import 'package:food/src/controllers/login_controller.dart';

void main() {
  group('Test controlador de inicio de sesion, ', () {
    test('Existe instancia de firebase: ', () {
      final loginController = LoginController();
      expect(loginController.isLoggedIn(), true);
    });
  });
}

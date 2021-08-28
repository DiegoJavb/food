import 'package:flutter_test/flutter_test.dart';
import 'package:food/src/controllers/login_controller.dart';

void main() {
  group('login Controller test', () {
    test('Initial test is Logged out', () {
      final loginController = LoginController();
      expect(loginController.isLoggedIn(), false);
    });
  });
}

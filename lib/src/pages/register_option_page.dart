import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter_signin_button/button_list.dart';
import 'package:flutter_signin_button/button_view.dart';
import 'package:food/src/controllers/login_controller.dart';
import 'package:food/src/pages/register_page.dart';
import 'package:food/src/res/custom_colors.dart';
import 'package:get/get.dart';

class RegisterOpccionPage extends StatefulWidget {
  final String roleUser;
  RegisterOpccionPage({required this.roleUser});
  @override
  _RegisterOpccionPageState createState() => _RegisterOpccionPageState();
}

class _RegisterOpccionPageState extends State<RegisterOpccionPage> {
  final _controller = Get.put(LoginController());
  FirebaseAuth auth = FirebaseAuth.instance;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(backgroundColor: CustomColors.firebaseNavy),
      body: GetBuilder<LoginController>(
        init: LoginController(),
        builder: (_) {
          return SingleChildScrollView(
            child: Form(
              key: _controller.formKey,
              child: Column(
                children: <Widget>[
                  SizedBox(
                    height: 20.0,
                  ),
                  Container(
                    width: 250,
                    child: Image(
                      image: AssetImage('images/Healthy.png'),
                    ),
                  ),
                  //_facebookRegister(),
                  _googleRegister(_),
                  Center(child: Text('Ó')),
                  _crearCuenta(),
                ],
              ),
            ),
          );
        },
      ),
    );
  }

  Widget _facebookRegister() {
    return Container(
      padding: const EdgeInsets.all(10.0),
      child: SignInButton(
        Buttons.Facebook,
        text: 'Registrate con Facebook',
        onPressed: () async {},
      ),
    );
  }

  Widget _googleRegister(_) {
    return Container(
      padding: const EdgeInsets.all(10.0),
      child: SignInButton(
        Buttons.GoogleDark,
        text: 'Registrate con Google',
        onPressed: () async {
          _.signInWithGoogle();
        },
      ),
    );
  }

  Widget _crearCuenta() {
    return Container(
      padding: const EdgeInsets.all(10.0),
      child: SignInButton(
        Buttons.Email,
        text: 'Registrate con correo',
        onPressed: () async {
          // Get.toNamed('register');
          Get.to(
            () => RegisterPage(
              currentUser: widget.roleUser,
            ),
          );
        },
      ),
    );
  }
}
//

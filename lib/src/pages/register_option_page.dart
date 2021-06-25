import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter_signin_button/button_list.dart';
import 'package:flutter_signin_button/button_view.dart';
import 'package:food/src/controllers/login_controller.dart';
import 'package:get/get.dart';

class RegisterOpccionPage extends StatefulWidget {
  @override
  _RegisterOpccionPageState createState() => _RegisterOpccionPageState();
}

class _RegisterOpccionPageState extends State<RegisterOpccionPage> {
  final _controller = Get.put(LoginController());
  FirebaseAuth auth = FirebaseAuth.instance;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: GetBuilder<LoginController>(
        init: LoginController(),
        builder: (_) {
          return SingleChildScrollView(
            child: Form(
              key: _controller.formKey,
              child: Column(
                children: <Widget>[
                  FlutterLogo(
                    size: 100.0,
                  ),
                  _facebookRegister(),
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
          Get.toNamed('register');
        },
      ),
    );
  }
}

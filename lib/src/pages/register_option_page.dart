import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter_signin_button/button_list.dart';
import 'package:flutter_signin_button/button_view.dart';
import 'package:food/src/controllers/register_controller.dart';
import 'package:get/get.dart';

class RegisterOpccionPage extends StatefulWidget {
  @override
  _RegisterOpccionPageState createState() => _RegisterOpccionPageState();
}

class _RegisterOpccionPageState extends State<RegisterOpccionPage> {
  final _controller = Get.put(RegisterController());
  FirebaseAuth auth = FirebaseAuth.instance;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: ListView(
        padding: EdgeInsets.symmetric(horizontal: 10.0, vertical: 20.0),
        children: <Widget>[
          Icon(Icons.home),
          _facebookRegister(),
          Divider(),
          _googleRegister(),
          Divider(),
          Center(child: Text('Ó')),
          Divider(),
          _crearCuenta(),
          Divider(),
        ],
      ),
    );
  }

  Widget _facebookRegister() {
    return Container(
      padding: const EdgeInsets.all(10.0),
      child: SignInButton(
        Buttons.Facebook,
        text: 'Inicia con Facebook',
        onPressed: () async {},
      ),
    );
  }

  Widget _googleRegister() {
    return Container(
      padding: const EdgeInsets.all(10.0),
      child: SignInButton(
        Buttons.GoogleDark,
        text: 'Inicia con Google',
        onPressed: () async {},
      ),
    );
  }

  Widget _crearCuenta() {
    return FloatingActionButton.extended(
      heroTag: 'boton crear cuenta',
      label: const Text('Crear cuenta'),
      backgroundColor: Colors.pink[100],
      onPressed: () {
        Get.toNamed('register');
      },
    );
  }
}

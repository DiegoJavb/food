import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter_signin_button/button_list.dart';
import 'package:flutter_signin_button/button_view.dart';
import 'package:food/src/controllers/login_controller.dart';
import 'package:food/src/utils/database.dart';
import 'package:get/get.dart';

class LoginPage extends StatefulWidget {
  @override
  _LoginPageState createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  // final TextEditingController _uidController = TextEditingController();
  final _controller = Get.put(LoginController());
  FirebaseAuth auth = FirebaseAuth.instance;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: GetBuilder<LoginController>(
        init: LoginController(),
        //este guion bajo hara referancia a los controladores de login
        builder: (_) {
          return SingleChildScrollView(
            child: Form(
              key: _controller.formKey,
              child: Column(
                children: <Widget>[
                  _faceBookLogin(),
                  _googleLogin(_),
                  Center(
                      child: Container(
                          padding: const EdgeInsets.all(10.0),
                          child: Text('Ó'))),
                  _insertUser(),
                  _insertPassword(),
                  _loginButton(_),
                ],
              ),
            ),
            padding: EdgeInsets.symmetric(horizontal: 10.0, vertical: 20.0),
          );
        },
      ),
    );
  }

  Widget _faceBookLogin() {
    return Container(
      padding: const EdgeInsets.all(10.0),
      child: SignInButton(
        Buttons.Facebook,
        text: 'Inicia con Facebook',
        onPressed: () async {},
      ),
    );
  }

  Widget _googleLogin(_) {
    return Container(
      padding: const EdgeInsets.all(10.0),
      child: SignInButton(
        Buttons.GoogleDark,
        text: 'Inicia con Google',
        onPressed: () async {
          _.signInWithGoogle();
        },
      ),
    );
  }

  Widget _insertUser() {
    return Container(
      padding: const EdgeInsets.all(10.0),
      child: TextFormField(
        controller: _controller.emailController,
        keyboardType: TextInputType.emailAddress,
        decoration: InputDecoration(
          hintText: 'Ingresar con correo',
          icon: Icon(Icons.person),
          border: OutlineInputBorder(borderRadius: BorderRadius.circular(30.0)),
        ),
        validator: (String? value) {
          if (value != null) return 'Ingrese un correo';
          return null;
        },
        // onChanged: (value) => setState(() => _user = value),
      ),
    );
  }

  Widget _insertPassword() {
    return Container(
      padding: const EdgeInsets.all(10.0),
      child: TextFormField(
        controller: _controller.passwordController,
        obscureText: true,
        decoration: InputDecoration(
          hintText: 'Contraseña',
          icon: Icon(Icons.lock),
          border: OutlineInputBorder(borderRadius: BorderRadius.circular(30.0)),
        ),
        validator: (String? value) {
          if (value != null) return 'porfavor ingrese una contraseña';
          return null;
        },
        // onChanged: (value) => setState(() => _password = value),
      ),
    );
  }

  Widget _loginButton(_) {
    return Container(
      padding: const EdgeInsets.all(10.0),
      child: FloatingActionButton.extended(
        label: const Text('Iniciar'),
        backgroundColor: Colors.pink[100],
        onPressed: () async {
          _.signInWithEmailAndPassword();
        },
      ),
    );
  }
}

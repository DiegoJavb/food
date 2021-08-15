import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter_signin_button/button_list.dart';
import 'package:flutter_signin_button/button_view.dart';
import 'package:food/src/controllers/login_controller.dart';
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
      appBar: AppBar(
        backgroundColor: Colors.white,
        leading: IconButton(
          icon: Icon(Icons.arrow_back, color: Colors.black),
          onPressed: () => Navigator.of(context).pop(),
        ),
        title: Text("Inicio de sesión", style: TextStyle(color: Colors.black)),
        centerTitle: true,
      ),
      drawer: Drawer(),
      body: GetBuilder<LoginController>(
        init: LoginController(),
        //este guion bajo hara referancia a los controladores de login
        builder: (_) {
          return SingleChildScrollView(
            child: Form(
              key: _controller.loginFormKey,
              child: Column(
                children: <Widget>[
                  Container(
                    padding: const EdgeInsets.symmetric(
                      horizontal: 40.0,
                      vertical: 10.0,
                    ),
                    child: Image(
                      image: AssetImage('images/Healthy.png'),
                      fit: BoxFit.cover,
                    ),
                  ),
                  _googleLogin(_),
                  Center(
                      child: Container(
                          padding: const EdgeInsets.all(10.0),
                          child: Text('Ó'))),
                  _insertUser(),
                  _insertPassword(),
                  _loginButton(_),
                  _notAccount(),
                ],
              ),
            ),
            padding: EdgeInsets.symmetric(horizontal: 10.0, vertical: 20.0),
          );
        },
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
      width: 200.0,
      padding: const EdgeInsets.all(10.0),
      child: FloatingActionButton.extended(
        label: const Text(
          'Iniciar',
          style: TextStyle(
            color: Colors.black,
            fontSize: 15.0,
          ),
        ),
        backgroundColor: Colors.white,
        onPressed: () async {
          _.signInWithEmailAndPassword();
        },
      ),
    );
  }

  Widget _notAccount() {
    return Container(
      child: Row(
        mainAxisAlignment: MainAxisAlignment.end,
        children: <Widget>[
          TextButton(
            onPressed: () => Get.toNamed('welcome'),
            child: Text('No tienes una cuenta?'),
          ),
        ],
      ),
    );
  }
}

import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:food/src/controllers/register_controller.dart';
import 'package:get/get.dart';

class RegisterPage extends StatefulWidget {
  @override
  _RegisterPageState createState() => _RegisterPageState();
}

class _RegisterPageState extends State<RegisterPage> {
  final _controller = Get.put(RegisterController());
  FirebaseAuth auth = FirebaseAuth.instance;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: GetBuilder<RegisterController>(
        builder: (_) {
          return SingleChildScrollView(
            child: Form(
              key: _controller.formKey,
              child: Column(
                children: <Widget>[
                  Container(
                    padding: const EdgeInsets.all(10.0),
                    child: const Text(
                      'Registrate',
                      style: TextStyle(fontSize: 30.0),
                    ),
                  ),
                  _createUser(),
                  _createPassword(),
                  _createAccountButton(_),
                ],
              ),
            ),
          );
        },
      ),
    );
  }

  Widget _createUser() {
    return Container(
      padding: const EdgeInsets.all(10.0),
      child: TextFormField(
        controller: _controller.emailController,
        keyboardType: TextInputType.emailAddress,
        decoration: InputDecoration(
          hintText: 'Ingresa correo',
          icon: Icon(Icons.person),
          border: OutlineInputBorder(borderRadius: BorderRadius.circular(30.0)),
        ),
        validator: (value) {
          if (value.isEmpty) return 'Ingrese correo';
          return null;
        },
      ),
    );
  }

  Widget _createPassword() {
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
        validator: (value) {
          if (value.isEmpty) return 'porfavor ingrese una contraseña';
          return null;
        },
      ),
    );
  }

  Widget _createAccountButton(_) {
    return Container(
      padding: const EdgeInsets.all(10.0),
      child: FloatingActionButton.extended(
        label: const Text('Registrarse'),
        backgroundColor: Colors.pink[100],
        onPressed: () async {
          _.registerUserWithEmailAndPassword();
        },
      ),
    );
  }
}

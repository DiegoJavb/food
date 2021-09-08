import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:food/src/components/customAppBar.dart';
import 'package:food/src/controllers/register_controller.dart';
import 'package:get/get.dart';
import 'package:food/src/providers/role_pass.dart' as role;

class RegisterPage extends StatefulWidget {
  RegisterPage();

  @override
  _RegisterPageState createState() => _RegisterPageState();
}

class _RegisterPageState extends State<RegisterPage> {
  final _controller = Get.put(RegisterController());
  FirebaseAuth auth = FirebaseAuth.instance;
  bool _isObscure = true;

  @override
  void initState() {
    super.initState();
  }

  Widget build(BuildContext context) {
    print(role.rolUser);
    return Scaffold(
      appBar: CustomAppBar(
        title: '',
      ),
      body: GetBuilder<RegisterController>(
        builder: (_) {
          return SingleChildScrollView(
            child: Form(
              key: _controller.formKey,
              child: Column(
                children: <Widget>[
                  SizedBox(height: 20.0),
                  Container(
                    padding: const EdgeInsets.all(10.0),
                    child: const Text(
                      'Regístrate',
                      style: TextStyle(fontSize: 35.0),
                    ),
                  ),
                  SizedBox(height: 20.0),
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
          hintText: 'Ingrese correo',
          icon: Icon(Icons.person),
          border: OutlineInputBorder(borderRadius: BorderRadius.circular(30.0)),
        ),
        validator: (value) {
          if (value!.isEmpty) {
            return 'Este Campo es obligatorio';
          } else if (!RegExp("^[^@]+@[^@]+\.[a-zA-Z]{2,}\$").hasMatch(value)) {
            return 'correo no válido';
          }
        },
      ),
    );
  }

  Widget _createPassword() {
    return Container(
      padding: const EdgeInsets.all(10.0),
      child: TextFormField(
        controller: _controller.passwordController,
        obscureText: _isObscure,
        decoration: InputDecoration(
          hintText: 'Contraseña',
          icon: Icon(Icons.lock),
          suffixIcon: Padding(
            padding: EdgeInsets.only(right: 10.0),
            child: IconButton(
              icon: Icon(Icons.remove_red_eye),
              onPressed: () {
                setState(() {
                  _isObscure = !_isObscure;
                });
              },
            ),
          ),
          border: OutlineInputBorder(borderRadius: BorderRadius.circular(30.0)),
        ),
        validator: (value) {
          if (value!.isEmpty) {
            return 'Este Campo es obligatorio';
          } else if (value.length < 6) {
            return 'La contraseña debe tener al menos 6 \ncaracteres';
          }
        },
      ),
    );
  }

  Widget _createAccountButton(_) {
    return Container(
      width: 200.0,
      padding: const EdgeInsets.all(10.0),
      child: FloatingActionButton.extended(
        label: const Text('Registrarse',
            style: TextStyle(
              fontSize: 15.0,
              color: Colors.black,
            )),
        backgroundColor: Colors.white,
        onPressed: () async {
          _.registerUserWithEmailAndPassword();
        },
      ),
    );
  }
}

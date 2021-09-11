import 'package:flutter/material.dart';
import 'package:food/src/components/customAppBar.dart';
import 'package:food/src/controllers/register_controller.dart';
import 'package:get/get.dart';

class RegisterPage extends StatefulWidget {
  RegisterPage();

  @override
  _RegisterPageState createState() => _RegisterPageState();
}

class _RegisterPageState extends State<RegisterPage> {
  GlobalKey<FormState> registerFormKey = GlobalKey<FormState>();
  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();
  bool _isObscure = true;

  @override
  void initState() {
    super.initState();
  }

  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CustomAppBar(
        title: '',
      ),
      body: GetBuilder<RegisterController>(
        init: RegisterController(),
        builder: (_) {
          return SingleChildScrollView(
            child: Form(
              key: registerFormKey,
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
        controller: _emailController,
        keyboardType: TextInputType.emailAddress,
        decoration: InputDecoration(
          hintText: 'Ingrese correo',
          icon: Icon(Icons.person),
          border: OutlineInputBorder(borderRadius: BorderRadius.circular(30.0)),
        ),
        validator: (value) {
          if (value!.isEmpty) {
            return 'Este Campo es obligatorio';
          } else if (RegExp(
            r"^[a-zA-Z0-9.a-zA-Z0-9.!#$%&'*+-/=?^_`{|}~]+@[a-zA-Z0-9]+\.[a-zA-Z]+",
          ).hasMatch(value)) {
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
        controller: _passwordController,
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
          _.registerUserWithEmailAndPassword(
            _emailController.text,
            _passwordController.text,
          );
        },
      ),
    );
  }
}

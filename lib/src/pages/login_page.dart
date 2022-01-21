import 'package:flutter/material.dart';
import 'package:flutter_signin_button/button_list.dart';
import 'package:flutter_signin_button/button_view.dart';
import 'package:food/src/components/customAppBar.dart';
import 'package:food/src/controllers/login_controller.dart';
import 'package:get/get.dart';

class LoginPage extends StatefulWidget {
  @override
  _LoginPageState createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  GlobalKey<FormState> loginFormKey = GlobalKey<FormState>();
  final emailController = TextEditingController();
  final passwordController = TextEditingController();
  bool _isObscure = true;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CustomAppBar(title: ''),
      body: GetBuilder<LoginController>(
        init: LoginController(),
        //este guion bajo hara referancia a los controladores de login
        builder: (_) {
          return SingleChildScrollView(
            child: Form(
              key: loginFormKey,
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
                  // _googleLogin(_),
                  // Center(
                  //     child: Container(
                  //         padding: const EdgeInsets.all(10.0),
                  //         child: Text('Ó'))),
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
        controller: emailController,
        keyboardType: TextInputType.emailAddress,
        decoration: InputDecoration(
          hintText: 'Ingresar con correo',
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
        // onChanged: (value) => setState(() => _user = value),
      ),
    );
  }

  Widget _insertPassword() {
    return Container(
      padding: const EdgeInsets.all(10.0),
      child: TextFormField(
        controller: passwordController,
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
            return 'La contraseña es necesaria';
          } else if (value.length < 6) {
            return 'La contraseña debe tener al menos 6 \ncaracteres';
          }
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
          if (loginFormKey.currentState!.validate()) {
            // _.signInWithEmailAndPassword(
            //   email: emailController.text,
            //   password: passwordController.text,
            // );
            _.signInWithEmailAndPassword(
              emailController.text,
              passwordController.text,
            );
          }
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

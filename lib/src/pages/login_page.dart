import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter_signin_button/button_list.dart';
import 'package:flutter_signin_button/button_view.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:food/src/controllers/login_controller.dart';
import 'package:food/src/pages/home_page.dart';
import 'package:get/get.dart';

class LoginPage extends StatefulWidget {
  @override
  _LoginPageState createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  final _controller = Get.put(LoginController());
  String _user = '';
  String _password = '';
  FirebaseAuth auth = FirebaseAuth.instance;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: ListView(
        padding: EdgeInsets.symmetric(horizontal: 10.0, vertical: 20.0),
        children: <Widget>[
          _faceBookLogin(),
          _googleLogin(),
          Center(
              child: Container(
                  padding: const EdgeInsets.all(10.0), child: Text('Ó'))),
          _insertUser(),
          _insertPassword(),
          _loginButton(),
        ],
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

  Widget _googleLogin() {
    return Container(
      padding: const EdgeInsets.all(10.0),
      child: SignInButton(
        Buttons.GoogleDark,
        text: 'Inicia con Google',
        onPressed: () async {},
      ),
    );
  }

  Widget _insertUser() {
    return Container(
      padding: const EdgeInsets.all(10.0),
      child: TextFormField(
        autofocus: false,
        controller: _controller.emailController,
        keyboardType: TextInputType.emailAddress,
        decoration: InputDecoration(
          hintText: 'Ingresar con correo',
          icon: Icon(Icons.person),
          border: OutlineInputBorder(borderRadius: BorderRadius.circular(30.0)),
        ),
        onChanged: (value) => setState(() => _user = value),
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
        validator: (value) {
          if (value.isEmpty) return 'porfavor ingrese una contraseña';
          return null;
        },
        onChanged: (value) => setState(() => _password = value),
      ),
    );
  }

  Widget _loginButton() {
    return Container(
      padding: const EdgeInsets.all(10.0),
      child: FloatingActionButton.extended(
        label: const Text('Iniciar'),
        backgroundColor: Colors.pink[100],
        onPressed: () async {
          try {
            final user = await auth.signInWithEmailAndPassword(
                email: _user, password: _password);
            if (user != null) {
              final route = MaterialPageRoute(builder: (context) {
                return HomePage();
              });
              Navigator.push(context, route);
            }
          } catch (e) {
            Fluttertoast.showToast(
              // msg: e.toString(),
              msg: "This is Toast messaget",
              toastLength: Toast.LENGTH_SHORT,
              timeInSecForIosWeb: 6,
              gravity: ToastGravity.CENTER,
            );
          }
        },
      ),
    );
  }
}

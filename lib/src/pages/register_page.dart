import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:food/src/pages/home_page.dart';

class RegisterPage extends StatefulWidget {
  @override
  _RegisterPageState createState() => _RegisterPageState();
}

class _RegisterPageState extends State<RegisterPage> {
  String _email = '';
  String _password = '';

  FirebaseAuth auth = FirebaseAuth.instance;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: ListView(
        padding: EdgeInsets.symmetric(horizontal: 10.0, vertical: 20.0),
        children: <Widget>[
          const Text(
            'Registrate',
            style: TextStyle(fontSize: 30.0),
          ),
          Divider(
            height: 60.0,
          ),
          _createUser(),
          Divider(),
          _createPassword(),
          Divider(
            height: 30.0,
          ),
          _createAccountButton(),
        ],
      ),
    );
  }

  Widget _createUser() {
    return TextField(
      autofocus: true,
      keyboardType: TextInputType.emailAddress,
      decoration: InputDecoration(
        hintText: 'Ingresar con correo',
        icon: Icon(Icons.person),
        border: OutlineInputBorder(borderRadius: BorderRadius.circular(30.0)),
      ),
      onChanged: (value) => setState(() {
        _email = value;
      }),
    );
  }

  Widget _createPassword() {
    return TextField(
      obscureText: true,
      decoration: InputDecoration(
        hintText: 'Contraseña',
        icon: Icon(Icons.lock),
        border: OutlineInputBorder(borderRadius: BorderRadius.circular(30.0)),
      ),
      onChanged: (value) => setState(() {
        _password = value;
      }),
    );
  }

  Widget _createAccountButton() {
    return FloatingActionButton.extended(
      label: const Text('Registrarse'),
      backgroundColor: Colors.pink[100],
      onPressed: () async {
        try {
          UserCredential userCredential =
              await auth.createUserWithEmailAndPassword(
            email: _email.toString().trim(),
            password: _password.toString().trim(),
          );
          final route = MaterialPageRoute(
            builder: (context) {
              return HomePage();
            },
          );
          Navigator.push(context, route);
        } catch (e) {
          Fluttertoast.showToast(
            msg: e.toString(),
            toastLength: Toast.LENGTH_SHORT,
            timeInSecForIosWeb: 6,
            gravity: ToastGravity.CENTER,
          );
        }
      },
    );
  }
}

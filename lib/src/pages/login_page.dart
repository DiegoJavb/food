import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:food/src/pages/home_page.dart';

class LoginPage extends StatefulWidget {
  @override
  _LoginPageState createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  String _user = '';
  String _password = '';
  // TextEditingController();
  FirebaseAuth auth = FirebaseAuth.instance;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: ListView(
        padding: EdgeInsets.symmetric(horizontal: 10.0, vertical: 20.0),
        children: <Widget>[
          // _faceBookLogin(),
          Divider(),
          // _googleLogin(),
          Divider(),
          Center(child: Text('Ó')),
          Divider(),
          _insertUser(),
          Divider(),
          _insertPassword(),
          Divider(),
          _loginButton(),
        ],
      ),
    );
  }

  Widget _insertUser() {
    return TextField(
      autofocus: false,
      keyboardType: TextInputType.emailAddress,
      // textCapitalization: TextCapitalization.sentences,
      decoration: InputDecoration(
        hintText: 'Ingresar con correo',
        icon: Icon(Icons.person),
        border: OutlineInputBorder(borderRadius: BorderRadius.circular(30.0)),
      ),
      onChanged: (value) {
        setState(() {
          _user = value;
        });
      },
    );
  }

  Widget _insertPassword() {
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

  Widget _loginButton() {
    return FloatingActionButton.extended(
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
        print('enviado');
      },
    );
  }
}

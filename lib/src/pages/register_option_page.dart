import 'package:flutter/material.dart';
import 'package:food/src/pages/register_page.dart';

class RegisterOpccionPage extends StatefulWidget {
  @override
  _RegisterOpccionPageState createState() => _RegisterOpccionPageState();
}

class _RegisterOpccionPageState extends State<RegisterOpccionPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: ListView(
        padding: EdgeInsets.symmetric(horizontal: 10.0, vertical: 20.0),
        children: <Widget>[
          Icon(Icons.home),
          _faceBookLRegister(),
          Divider(),
          _googleLogin(),
          Divider(),
          Center(child: Text('Ó')),
          Divider(),
          _crearCuenta(),
          Divider(),
        ],
      ),
    );
  }

  Widget _crearCuenta() {
    return FloatingActionButton.extended(
      heroTag: 'boton crear cuenta',
      label: const Text('Crear cuenta'),
      backgroundColor: Colors.pink[100],
      onPressed: () {
        final route = MaterialPageRoute(
          builder: (context) => RegisterPage(),
        );
        Navigator.push(context, route);
      },
    );
  }

  Widget _faceBookLRegister() {
    return ElevatedButton(
      child: Text(''),
      onPressed: () {
        print('object');
      },
    );
  }

  _googleLogin() {
    return ElevatedButton(
      child: Text(''),
      onPressed: () {
        print('object');
      },
    );
  }
}

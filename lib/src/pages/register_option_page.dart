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
          _facebookRegister(),
          Divider(),
          _googleRegister(),
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

  Widget _facebookRegister() {
    return FlatButton(
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[
          CircleAvatar(backgroundImage: AssetImage('assets/13.jpg')),
          SizedBox(
            width: 30.0,
          ),
          Text('Registro con Facebook')
        ],
      ),
      onPressed: () {
        print('presionado');
      },
    );
  }

  Widget _googleRegister() {
    return FlatButton(
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[
          CircleAvatar(backgroundImage: AssetImage('assets/13.jpg')),
          SizedBox(
            width: 30.0,
          ),
          Text('Registro con Google')
        ],
      ),
      onPressed: () {
        print('presionado');
      },
    );
  }
}

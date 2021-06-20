import 'package:flutter/material.dart';
import 'package:food/src/pages/login_page.dart';
import 'package:food/src/pages/register_option_page.dart';

class InformationPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
          decoration: BoxDecoration(
            image: DecorationImage(
              image: AssetImage('assets/13.jpg'),
              fit: BoxFit.cover,
            ),
          ),
          child: Center(
            child: _mostrarInfo(),
          )),
      floatingActionButton: _crearBotones(context),
    );
  }

  Widget _mostrarInfo() {
    return Container(
      height: 200.0,
      width: 300.0,
      child: Card(
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(30.0),
        ),
        child: Column(
          children: <Widget>[
            ListTile(
              title: Column(
                children: <Widget>[
                  Center(child: Text('Has ejercicio')),
                  Divider(),
                ],
              ),
              subtitle: Text(
                  'Hacer ejercicio diariamente no solo te ayuda a despejar la mente, tambien aumenta tu energia y mantienes un estilo de vida saludable'),
            ),
          ],
        ),
      ),
    );
  }

  Widget _crearBotones(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.end,
      children: <Widget>[
        SizedBox(
          width: 30.0,
        ),
        FloatingActionButton.extended(
          heroTag: 'login button',
          label: const Text('Iniciar sesión'),
          foregroundColor: Colors.black,
          backgroundColor: Colors.white,
          onPressed: () {
            final route = MaterialPageRoute(builder: (context) {
              return LoginPage();
            });
            Navigator.push(context, route);
          },
        ),
        Expanded(
          child: SizedBox(
            width: 10.0,
          ),
        ),
        FloatingActionButton.extended(
          heroTag: 'reguster button',
          label: const Text('Registrarse'),
          foregroundColor: Colors.black,
          backgroundColor: Colors.white,
          onPressed: () {
            final route = MaterialPageRoute(builder: (context) {
              return RegisterOpccionPage();
            });
            Navigator.push(context, route);
          },
        ),
      ],
    );
  }
}

import 'package:flutter/material.dart';
import 'package:get/get.dart';

class InformationPage extends StatefulWidget {
  @override
  _InformationPageState createState() => _InformationPageState();
}

class _InformationPageState extends State<InformationPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        decoration: BoxDecoration(
          image: DecorationImage(
            image: AssetImage('images/info.jpg'),
            fit: BoxFit.cover,
          ),
        ),
        child: SingleChildScrollView(
          child: Column(
            children: [
              SizedBox(height: 100.0),
              Image(
                image: AssetImage('images/Healthy.png'),
              ),
              SizedBox(height: 20.0),
              _card(),
              Container(
                padding: EdgeInsets.symmetric(vertical: 10.0, horizontal: 10.0),
                height: 250.0,
              ),
            ],
          ),
        ),
      ),
      floatingActionButton: _crearBotones(),
    );
  }

  Widget _crearBotones() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.end,
      children: <Widget>[
        SizedBox(
          width: 30.0,
        ),
        FloatingActionButton.extended(
          heroTag: 'login button',
          label: const Text(
            'Iniciar sesión',
            style: TextStyle(fontSize: 15.0),
          ),
          foregroundColor: Colors.black,
          backgroundColor: Colors.white,
          onPressed: () {
            Get.toNamed('login');
          },
        ),
        Expanded(
          child: SizedBox(),
        ),
        FloatingActionButton.extended(
          heroTag: 'register button',
          label: const Text(
            'Registrarse',
            style: TextStyle(fontSize: 15.0),
          ),
          foregroundColor: Colors.black,
          backgroundColor: Colors.white,
          onPressed: () {
            // Get.toNamed('register_opt');
            Get.toNamed('welcome');
          },
        ),
      ],
    );
  }

  Widget _card() {
    return Container(
      child: ClipRRect(
        borderRadius: BorderRadius.circular(30.0),
        child: Container(
          width: 300.0,
          padding: EdgeInsets.all(20.0),
          child: Text(
            'Recibe recomendaciones te tu nutricionista en tiempo real',
            style: TextStyle(
              fontSize: 25.0,
              color: Colors.white,
              fontWeight: FontWeight.bold,
            ),
            textAlign: TextAlign.center,
          ),
        ),
      ),
    );
  }
}

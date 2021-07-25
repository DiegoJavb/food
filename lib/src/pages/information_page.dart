import 'package:flutter/material.dart';
import 'package:food/src/res/custom_colors.dart';
import 'package:get/get.dart';

class InformationPage extends StatefulWidget {
  @override
  _InformationPageState createState() => _InformationPageState();
}

class _InformationPageState extends State<InformationPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: CustomColors.foodpink,
      body: SingleChildScrollView(
        child: Container(
          child: Column(
            children: [
              SizedBox(height: 100.0),
              Image(
                image: AssetImage('images/Healthy.png'),
              ),
              SizedBox(height: 20.0),
              _card(),
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
          label: const Text('Iniciar sesión'),
          foregroundColor: Colors.black,
          backgroundColor: Colors.white,
          onPressed: () {
            Get.toNamed('login');
          },
        ),
        Expanded(
          child: SizedBox(
            width: 10.0,
          ),
        ),
        FloatingActionButton.extended(
          heroTag: 'register button',
          label: const Text('Registrarse'),
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
    final card = Container(
      color: CustomColors.foodpink,
      child: Column(
        mainAxisSize: MainAxisSize.max,
        children: [
          Container(
            width: 300.0,
            padding: EdgeInsets.all(20.0),
            child: ListTile(
              subtitle: Text(
                'Recibe recomendaciones te tu nutricionista en tiempo real',
                style: TextStyle(fontSize: 20.0),
                textAlign: TextAlign.center,
              ),
            ),
          )
        ],
      ),
    );
    return Container(
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(30.0),
        color: Colors.white,
      ),
      child: ClipRRect(
        borderRadius: BorderRadius.circular(30.0),
        child: card,
      ),
    );
  }
}

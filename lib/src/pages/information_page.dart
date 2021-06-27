import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:carousel_slider/carousel_slider.dart';

class InformationPage extends StatelessWidget {
  CarouselSlider carouselSlider;

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
        child: Column(
          children: [
            SizedBox(
              height: 20.0,
            ),
            FlutterLogo(
              size: 200.0,
            ),
            CarouselSlider(
              items: <Widget>[
                _card(),
                _card(),
              ],
              options: CarouselOptions(),
            )
          ],
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
          heroTag: 'reguster button',
          label: const Text('Registrarse'),
          foregroundColor: Colors.black,
          backgroundColor: Colors.white,
          onPressed: () {
            Get.toNamed('register_opt');
          },
        ),
      ],
    );
  }

  Widget _card() {
    final card = Container(
      child: Column(
        mainAxisSize: MainAxisSize.max,
        children: [
          Container(
            width: 250.0,
            padding: EdgeInsets.all(20.0),
            child: ListTile(
              title: Column(
                children: <Widget>[
                  Center(child: Text('Has ejercicio')),
                  Divider(),
                ],
              ),
              subtitle: Text(
                  'Hacer ejercicio diariamente no solo te ayuda a despejar la mente, tambien aumenta tu energia y mantienes un estilo de vida saludable'),
            ),
          )
        ],
      ),
    );
    return Container(
      decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(30.0),
          color: Colors.white,
          boxShadow: <BoxShadow>[
            BoxShadow(
              color: Colors.black26,
              blurRadius: 10.0,
              spreadRadius: 2.0,
              offset: Offset(2.0, 8.0),
            )
          ]),
      child: ClipRRect(
        borderRadius: BorderRadius.circular(30.0),
        child: card,
      ),
    );
  }
}

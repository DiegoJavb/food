import 'package:flutter/material.dart';
import 'package:get/get.dart';

class WelcomePage extends StatefulWidget {
  @override
  _WelcomePageState createState() => _WelcomePageState();
}

enum SingingCharacter { lafayette, jefferson }

class _WelcomePageState extends State<WelcomePage> {
  Object _value = 1;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: Center(
        child: Column(
          children: <Widget>[
            SizedBox(height: 20.0),
            Text(
              'Bienvenido',
              style: TextStyle(
                fontSize: 40.0,
                fontWeight: FontWeight.w300,
              ),
            ),
            SizedBox(height: 80.0),
            Container(
              width: 300.0,
              child: Text(
                'Cuentanos con que rol te identificas',
                style: TextStyle(fontSize: 25.0),
              ),
            ),
            SizedBox(height: 50.0),
            _crearCheckBoxes(),
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton.extended(
        heroTag: 'siguiente button',
        label: const Text(
          'Siguiente',
          style: TextStyle(fontSize: 20.0),
        ),
        foregroundColor: Colors.black,
        backgroundColor: Colors.white,
        onPressed: () {
          Get.toNamed('register_opt');
        },
      ),
    );
  }

  Widget _crearCheckBoxes() {
    return Container(
      child: Column(
        children: <Widget>[
          RadioListTile(
            value: 1,
            groupValue: _value,
            onChanged: (value) {
              setState(() {
                _value = value!;
              });
            },
            title: Text('Nutricionista'),
          ),
          RadioListTile(
            value: 0,
            groupValue: _value,
            onChanged: (value) {
              setState(() {
                _value = value!;
              });
            },
            title: Text('Paciente'),
          ),
        ],
      ),
    );
  }
}

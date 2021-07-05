import 'package:flutter/material.dart';

class WelcomePage extends StatefulWidget {
  @override
  _WelcomePageState createState() => _WelcomePageState();
}

enum SingingCharacter { lafayette, jefferson }

class _WelcomePageState extends State<WelcomePage> {
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
    );
  }

  _crearCheckBoxes() {}
}

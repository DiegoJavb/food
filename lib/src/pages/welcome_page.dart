import 'package:flutter/material.dart';
import 'package:food/src/pages/register_option_page.dart';
import 'package:food/src/res/custom_colors.dart';
import 'package:get/get.dart';
import 'package:food/src/providers/role_pass.dart' as role;

class WelcomePage extends StatefulWidget {
  @override
  _WelcomePageState createState() => _WelcomePageState();
}

enum SingingCharacter { nutricionista, paciente }

class _WelcomePageState extends State<WelcomePage> {
  Object _value = 1;
  String _role = 'nutritionist';
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: CustomColors.firebaseNavy,
      ),
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
          Get.to(
            () => RegisterOpccionPage(roleUser: _role),
          );
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
                _role = 'nutritionist';
                role.rolUser = _role;
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
                _role = 'patient';
                role.rolUser = _role;
              });
            },
            title: Text('Paciente'),
          ),
        ],
      ),
    );
  }
}

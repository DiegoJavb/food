import 'package:flutter/material.dart';
import 'package:food/src/components/customAppBar.dart';
import 'package:food/src/pages/register_option_page.dart';
import 'package:food/src/res/custom_colors.dart';
import 'package:get/get.dart';
import 'package:food/src/providers/role_pass.dart' as role;

class WelcomePage extends StatefulWidget {
  @override
  _WelcomePageState createState() => _WelcomePageState();
}

enum SingingCharacter { nutritionist, patient }

class _WelcomePageState extends State<WelcomePage> {
  Object _value = 1;
  String _role = 'Paciente';
  @override
  Widget build(BuildContext context) {
    print(role.rolUser);
    return Scaffold(
      appBar: CustomAppBar(
        title: 'Bienvenido',
      ),
      body: SingleChildScrollView(
        child: Center(
          child: Column(
            children: <Widget>[
              SizedBox(height: 10.0),
              Container(
                padding: const EdgeInsets.symmetric(
                  horizontal: 40.0,
                  vertical: 10.0,
                ),
                child: Image(
                  image: AssetImage('images/Healthy.png'),
                  fit: BoxFit.cover,
                ),
              ),
              SizedBox(height: 60.0),
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
      ),
      floatingActionButton: FloatingActionButton.extended(
        heroTag: 'siguiente button',
        label: const Text(
          'Siguiente',
          style: TextStyle(fontSize: 15.0),
        ),
        foregroundColor: Colors.black,
        backgroundColor: Colors.white,
        onPressed: () {
          Get.to(
            () => RegisterOpccionPage(),
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
            activeColor: CustomColors.foodProgress2,
            value: 0,
            groupValue: _value,
            onChanged: (value) {
              setState(() {
                _value = value!;
                _role = 'Nutricionista';
                role.rolUser = _role;
              });
            },
            title: Text('Nutricionista'),
          ),
          RadioListTile(
            activeColor: CustomColors.foodProgress2,
            value: 1,
            groupValue: _value,
            onChanged: (value) {
              setState(() {
                _value = value!;
                _role = 'Paciente';
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

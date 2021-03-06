import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter_signin_button/button_list.dart';
import 'package:flutter_signin_button/button_view.dart';
import 'package:food/src/components/customAppBar.dart';
import 'package:food/src/controllers/login_controller.dart';
import 'package:food/src/pages/register_page.dart';
import 'package:get/get.dart';
import 'package:food/src/providers/role_pass.dart' as role;

class RegisterOpccionPage extends StatefulWidget {
  RegisterOpccionPage();
  @override
  _RegisterOpccionPageState createState() => _RegisterOpccionPageState();
}

class _RegisterOpccionPageState extends State<RegisterOpccionPage> {
  GlobalKey<FormState> loginFormKey = GlobalKey<FormState>();
  FirebaseAuth auth = FirebaseAuth.instance;

  @override
  Widget build(BuildContext context) {
    print(role.rolUser);
    return Scaffold(
      appBar: CustomAppBar(
        title: '',
      ),
      body: GetBuilder<LoginController>(
        init: LoginController(),
        builder: (_) {
          return SingleChildScrollView(
            child: Form(
              key: loginFormKey,
              child: Column(
                children: <Widget>[
                  SizedBox(height: 20.0),
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
                  SizedBox(height: 20.0),
                  role.rolUser == 'Paciente'
                      ? Container(
                          child: Column(
                            children: [
                              _googleRegister(_),
                              Center(
                                child: Text(
                                  'Ó',
                                  style: TextStyle(fontSize: 20.0),
                                ),
                              ),
                              _crearCuenta(),
                            ],
                          ),
                        )
                      : Container(
                          child: Column(
                            children: [
                              _crearCuenta(),
                            ],
                          ),
                        )
                ],
              ),
            ),
          );
        },
      ),
    );
  }

  Widget _googleRegister(_) {
    return Container(
      padding: const EdgeInsets.all(10.0),
      child: SignInButton(
        Buttons.GoogleDark,
        text: 'Registrate con Google',
        onPressed: () async {
          _.signInWithGoogle();
        },
      ),
    );
  }

  Widget _crearCuenta() {
    return Container(
      padding: const EdgeInsets.all(10.0),
      child: SignInButton(
        Buttons.Email,
        text: 'Registrate con correo',
        onPressed: () async {
          // Get.toNamed('register');
          Get.to(
            () => RegisterPage(),
          );
        },
      ),
    );
  }
}
//

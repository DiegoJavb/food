import 'package:food/src/pages/information_page.dart';
import 'package:food/src/pages/register_option_page.dart';
import 'package:food/src/pages/register_page.dart';
import 'package:food/src/pages/welcome_page.dart';
import 'package:get/route_manager.dart';
import 'package:food/src/pages/login_page.dart';
import 'package:food/src/pages/home_page.dart';

//para estasrutas haremos uso del packete get
getAplicationRoutes() => [
      GetPage(
        //La direccion raiz será la pagina informativa
        name: '/',
        page: () => InformationPage(),
      ),
      GetPage(
        name: 'login',
        page: () => LoginPage(),
      ),
      GetPage(
        name: 'register_opt',
        page: () => RegisterOpccionPage(),
      ),
      GetPage(
        name: 'register',
        page: () => RegisterPage(),
      ),
      GetPage(
        name: 'home',
        page: () => HomePage(),
      ),
      GetPage(
        name: 'welcome',
        page: () => WelcomePage(),
      ),
    ];

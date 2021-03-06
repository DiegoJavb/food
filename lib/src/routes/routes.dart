import 'package:get/route_manager.dart';
import 'package:food/src/pages/add_appointment_page.dart';
import 'package:food/src/pages/recomendations_page.dart';
import 'package:food/src/pages/information_page.dart';
import 'package:food/src/pages/record_page.dart';
import 'package:food/src/pages/welcome_page.dart';
import 'package:food/src/pages/login_page.dart';
import 'package:food/src/pages/home_page.dart';
import 'package:food/src/pages/news_page.dart';

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
        name: 'home',
        page: () => HomePage(),
      ),
      GetPage(
        name: 'welcome',
        page: () => WelcomePage(),
      ),
      GetPage(
        name: 'record',
        page: () => RecordPage(),
      ),
      GetPage(
        name: 'recomendation',
        page: () => RecomendationsPage(),
      ),
      GetPage(
        name: 'addAppointment',
        page: () => AddAppointmentPage(),
      ),
      GetPage(
        name: 'news',
        page: () => NewsPage(),
      ),
    ];

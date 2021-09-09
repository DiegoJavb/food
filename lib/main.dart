import 'package:flutter/material.dart';
import 'package:food/src/controllers/database_controller.dart';
import 'package:food/src/controllers/database_evaluation.dart';
import 'package:food/src/controllers/database_user_controller.dart';
import 'package:food/src/res/custom_colors.dart';
import 'package:get/get.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:food/src/routes/routes.dart';
import 'package:flutter/rendering.dart';
import 'package:shared_preferences/shared_preferences.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(MyApp());
}

class MyApp extends StatefulWidget {
  // This widget is the root of your application.
  @override
  _MyAppState createState() => _MyAppState();
}

String? email;
Future<void> obtenerDatos() async {
  SharedPreferences prefs = await SharedPreferences.getInstance();
  print('existe alguna pref: $prefs');
  email = prefs.getString('email');
  if (email == null || email == '') {
    Get.toNamed('/');
  } else {
    Get.toNamed('home');
    DatabaseUser.userUid = email;
    DatabaseEvaluations.userUid = email;
    Database.userUid = email;
  }
}

class _MyAppState extends State<MyApp> {
  bool isLoggedIn = false;

  @override
  void initState() {
    super.initState();
    obtenerDatos();
  }

  @override
  Widget build(BuildContext context) {
    //si utulizamos get, SERIA UNA GETMATERIALAPP
    return GetMaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Material App',
      // initialRoute: isLoggedIn ? 'home' : '/',
      navigatorKey: Get.key,
      getPages: getAplicationRoutes(),
      localizationsDelegates: [
        GlobalMaterialLocalizations.delegate,
        GlobalWidgetsLocalizations.delegate,
      ],
      supportedLocales: [
        const Locale('en', 'US'),
        const Locale('es', 'ES'),
      ],
      theme: ThemeData(
        primaryColor: CustomColors.foodBackground,
      ),
    );
  }
}

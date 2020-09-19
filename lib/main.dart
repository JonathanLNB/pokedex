import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:pokedex/Actividades/LogIn.dart';
import 'package:splashscreen/splashscreen.dart';

import 'Herramientas/AppColors.dart';
import 'Herramientas/Strings.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(new MaterialApp(
    title: Strings.pokedex,
    debugShowCheckedModeBanner: false,
    home: Scaffold(
      body: SplashScreen(
        seconds: 2,
        gradientBackground: LinearGradient(colors: [
          AppColors.lightRed,
          AppColors.red,
          AppColors.darkRed
        ], begin: Alignment.topLeft, end: Alignment.centerRight),
        navigateAfterSeconds: LogIn(),
        image: Image.asset("${Strings.images}pokeapi.png"),
        photoSize: 120,
        loaderColor: AppColors.white,
      ),
    ),
  ));
}

import 'dart:async';
import 'dart:io';
import 'dart:math';

import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:pokedex/Herramientas/AppColors.dart';
import 'package:pokedex/Herramientas/Herramientas.dart';
import 'package:pokedex/Herramientas/SessionManager.dart';
import 'package:pokedex/Herramientas/Strings.dart';
import 'package:pokedex/Herramientas/Views/NavigationBar.dart';
import 'package:pokedex/TDA/Pokemon.dart';

import 'Home.dart';

class Welcome extends StatefulWidget {
  @override
  State<Welcome> createState() {
    return new _Welcome();
  }
}

class _Welcome extends State<Welcome> {
  SessionManager sessionManager;
  Timer _timer;
  String _imagenAct = "";
  int _imagen = 1;

  @override
  void initState() {
    configuracion();
    iniciarContador();
  }

  @override
  void dispose() {
    if (_timer != null) _timer.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.white,
      body: WillPopScope(
          onWillPop: onBackPress,
          child: Stack(children: <Widget>[
            NavigationBar(true),
            Center(
              child: Container(
                margin: EdgeInsets.only(top: 40, left: 10, right: 10),
                child: Column(
                  children: [
                    FadeInImage(
                        placeholder: AssetImage("${Strings.images}errorImage.png"),
                        image: AssetImage(_imagenAct)),
                    SizedBox(height: 100,),
                    Text(
                      Strings.bienvenido,
                      style: TextStyle(
                          color: AppColors.lightblack,
                          fontSize: 50.0,
                          fontFamily: "Pokemon",
                          fontWeight: FontWeight.bold),
                    ),
                    SizedBox(height: 20,),
                    FlatButton(
                      minWidth: MediaQuery.of(context).size.width-50,
                      color: AppColors.red,
                      textColor: AppColors.white,
                      padding: EdgeInsets.all(8.0),
                      splashColor: AppColors.darkRed,
                      shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(20)),
                      child: Text(
                        Strings.gotcha,
                        style: TextStyle(
                          fontFamily: "Pokemon",
                          fontSize: 30.0,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      onPressed: () {
                        Navigator.pushAndRemoveUntil(
                            context,
                            MaterialPageRoute(builder: (context) => Home()),
                            ModalRoute.withName('/Home'));
                      },
                    )
                  ],
                ),
              ),
            )
          ])),
    );
  }

  void configuracion() async {
    sessionManager = new SessionManager();
    if (await sessionManager.inicializar()) await sessionManager.setHome(true);
  }

  void iniciarContador() {
    const segundo = const Duration(seconds: 2);
    _timer = new Timer.periodic(
      segundo,
      (Timer timer) => setState(() {
          if (_imagen == 23)
            _imagen = 1;
          else
            _imagen = _imagen + 1;
          _imagenAct = "${Strings.images}pokemons/${_imagen}.png";
        },
      ),
    );
  }

  Future<bool> onBackPress() {
    Herramientas.salir(context);
  }
}

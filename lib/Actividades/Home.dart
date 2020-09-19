import 'dart:io';
import 'dart:math';

import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:pokedex/Herramientas/AppColors.dart';
import 'package:pokedex/Herramientas/Herramientas.dart';
import 'package:pokedex/Herramientas/Strings.dart';
import 'package:pokedex/Herramientas/Views/NavigationBar.dart';
import 'package:pokedex/Herramientas/Views/PokedexDrawer.dart';
import 'package:pokedex/Herramientas/Views/ProgressBar.dart';
import 'package:pokedex/TDA/Pokemon.dart';

import 'Details.dart';

class Home extends StatefulWidget {
  @override
  State<Home> createState() {
    return new _Home();
  }
}

class _Home extends State<Home> {
  final GlobalKey<ScaffoldState> _scaffoldKey = new GlobalKey<ScaffoldState>();
  Pokemon _pokemon;
  bool dialogo = false;

  @override
  void initState() {
    generar();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      drawerDragStartBehavior: DragStartBehavior.down,
      key: _scaffoldKey,
      backgroundColor: AppColors.white,
      body: WillPopScope(
          onWillPop: onBackPress,
          child: Stack(children: <Widget>[
            SingleChildScrollView(
                scrollDirection: Axis.vertical,
                child: Center(
                    child: Container(
                  margin: EdgeInsets.only(top: 150, left: 20, right: 20),
                  child: Column(
                    children: [
                      _pokemon != null
                          ? FadeInImage(
                              image: NetworkImage(
                                "${Strings.IMAGESURL}${_pokemon.id}.png",
                              ),
                              placeholder:
                                  AssetImage("${Strings.images}errorImage.png"),
                            )
                          : loading(context),
                      SizedBox(
                        height: 20,
                      ),
                      _pokemon != null
                          ? Text(
                              "${_pokemon.id}: ${_pokemon.name}",
                              textAlign: TextAlign.center,
                              style: TextStyle(
                                  color: AppColors.red,
                                  fontSize: 30.0,
                                  fontFamily: "Pokemon",
                                  fontWeight: FontWeight.bold),
                            )
                          : SizedBox(),
                      SizedBox(
                        height: 20,
                      ),
                      _pokemon != null
                          ? FlatButton(
                              minWidth: MediaQuery.of(context).size.width - 50,
                              color: AppColors.lightblack,
                              textColor: AppColors.white,
                              padding: EdgeInsets.all(8.0),
                              splashColor: AppColors.darkblack,
                              shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(20)),
                              child: Text(
                                Strings.informacion,
                                style: TextStyle(
                                  fontFamily: "Pokemon",
                                  fontSize: 30.0,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                              onPressed: () {
                                Navigator.of(context).push(MaterialPageRoute(
                                    builder: (context) => Details(
                                          pokemon: _pokemon,
                                        )));
                              },
                            )
                          : SizedBox()
                    ],
                  ),
                ))),
            NavigationBar(false),
            Padding(
                padding: Platform.isAndroid
                    ? EdgeInsets.only(left: 15, top: 40, right: 10)
                    : EdgeInsets.only(left: 15, top: 50, right: 10),
                child: Row(
                  children: [
                    FloatingActionButton(
                      onPressed: () {
                        _scaffoldKey.currentState.openDrawer();
                      },
                      backgroundColor: AppColors.black,
                      child: Icon(
                        Icons.menu,
                        color: AppColors.white,
                      ),
                    ),
                    SizedBox(
                      width: 20,
                    ),
                    Text(
                      Strings.home,
                      style: TextStyle(
                          color: AppColors.white,
                          fontSize: 30.0,
                          fontFamily: "Pokemon",
                          fontWeight: FontWeight.bold),
                    ),
                  ],
                )),
          ])),
      floatingActionButton: FloatingActionButton(
        heroTag: "Cargar",
        onPressed: () {
          showLoading();
          setState(() {
            _pokemon = null;
          });
          generar();
        },
        child: Icon(Icons.autorenew),
        backgroundColor: AppColors.black,
      ),
      drawer: PokedexDrawer(),
    );
  }

  void generar() async {
    try {
      Random rng = new Random();
      Map<String, dynamic> json = await Herramientas.requestBuilder(
          "${Strings.BASEURL}pokemon/${rng.nextInt(887)}", false, "{}");
      setState(() {
        _pokemon = Pokemon.fromJson(json);
      });
    } catch (e) {
      print(e);
      Fluttertoast.showToast(
          msg: Strings.errorS,
          backgroundColor: AppColors.darkblue,
          textColor: AppColors.white);
    }
    if (dialogo) {
      dialogo = false;
      Navigator.pop(context);
    }
  }

  void showLoading() {
    dialogo = true;
    showDialog(
      context: context,
      barrierDismissible: false,
      builder: (context) => loading(context),
    );
  }

  Widget loading(BuildContext context) {
    return Stack(
      alignment: Alignment.center,
      children: <Widget>[
        ProgressBar(
          radius: 20,
          dotRadius: 8,
        )
      ],
    );
  }

  Future<bool> onBackPress() {
    Herramientas.salir(context);
  }
}

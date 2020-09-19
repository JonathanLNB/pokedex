import 'dart:io';

import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:pokedex/API/PokeList.dart';
import 'package:pokedex/Adaptadores/PokeAdapter.dart';
import 'package:pokedex/Herramientas/AppColors.dart';
import 'package:pokedex/Herramientas/Herramientas.dart';
import 'package:pokedex/Herramientas/Strings.dart';
import 'package:pokedex/Herramientas/Views/NavigationBar.dart';
import 'package:pokedex/Herramientas/Views/PokedexDrawer.dart';
import 'package:pokedex/Herramientas/Views/ProgressBar.dart';
import 'package:pokedex/TDA/Specie.dart';

class Pokedex extends StatefulWidget {
  @override
  State<Pokedex> createState() {
    return new _Pokedex();
  }
}

class _Pokedex extends State<Pokedex> {
  final GlobalKey<ScaffoldState> _scaffoldKey = new GlobalKey<ScaffoldState>();
  PokeList pokeList;
  List<Specie> pokemons = [];
  String next = "${Strings.BASEURL}pokemon?offset=0&limit=20";
  bool dialogo = false;

  @override
  void initState() {
    configuracion();
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
                child: pokemons.length == 0
                    ? Container(
                        alignment: Alignment.center,
                        margin: EdgeInsets.only(top: 120, left: 10, right: 20),
                        child: loading(context))
                    : Column(
                        children: [
                          Container(
                              margin: EdgeInsets.only(
                                  top: 120, left: 10, right: 20),
                              child: Center(
                                  child: Table(
                                defaultColumnWidth: IntrinsicColumnWidth(),
                                children: getPokemons(),
                              ))),
                          SizedBox(
                            height: 10,
                          ),
                          pokemons.length < 887
                              ? FlatButton(
                                  minWidth:
                                      MediaQuery.of(context).size.width - 50,
                                  color: AppColors.lightblack,
                                  textColor: AppColors.white,
                                  padding: EdgeInsets.all(8.0),
                                  splashColor: AppColors.darkblack,
                                  shape: RoundedRectangleBorder(
                                      borderRadius: BorderRadius.circular(20)),
                                  child: Text(
                                    Strings.siguiente,
                                    style: TextStyle(
                                      fontFamily: "Pokemon",
                                      fontSize: 30.0,
                                      fontWeight: FontWeight.bold,
                                    ),
                                  ),
                                  onPressed: () {
                                    showLoading();
                                    configuracion();
                                  },
                                )
                              : SizedBox(),
                          SizedBox(
                            height: 10,
                          )
                        ],
                      )),
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
                      Strings.pokedex,
                      style: TextStyle(
                          color: AppColors.white,
                          fontSize: 30.0,
                          fontFamily: "Pokemon",
                          fontWeight: FontWeight.bold),
                    ),
                  ],
                )),
          ])),
      drawer: PokedexDrawer(),
    );
  }

  List<TableRow> getPokemons() {
    List<TableRow> modulosW = [];
    List<Widget> tableRows = [];
    for (int cont = 0;
        cont < pokemons.length;
        cont += MediaQuery.of(context).size.width > 450 ? 3 : 2) {
      tableRows = [];
      tableRows.add(new PokeAdapter(pokemons[cont], cont + 1));
      if (cont + 1 < pokemons.length)
        tableRows.add(new PokeAdapter(pokemons[cont + 1], cont + 2));
      else
        tableRows.add(new Container());
      if (MediaQuery.of(context).size.width > 450) {
        if (cont + 2 < pokemons.length)
          tableRows.add(new PokeAdapter(pokemons[cont + 2], cont + 3));
        else
          tableRows.add(new Container());
      }
      modulosW.add(TableRow(children: tableRows));
    }
    return modulosW;
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

  configuracion() async {
    try {
      Map<String, dynamic> json =
          await Herramientas.requestBuilder(next, false, "{}");
      setState(() {
        pokeList = PokeList.fromJson(json);
        next = pokeList.next;
        if (pokemons.length > 0)
          pokeList.results.forEach((pokemon) {
            pokemons.add(pokemon);
          });
        else
          pokemons.addAll(pokeList.results);
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

  Future<bool> onBackPress() {
    Herramientas.salir(context);
  }
}

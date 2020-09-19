import 'package:flutter/material.dart';
import 'package:flutter_html/flutter_html.dart';
import 'package:pokedex/Herramientas/AppColors.dart';
import 'package:pokedex/Herramientas/Strings.dart';
import 'package:pokedex/Herramientas/Views/NavigationBar.dart';
import 'package:pokedex/TDA/Pokemon.dart';

class Details extends StatelessWidget {
  Pokemon pokemon;

  Details({this.pokemon});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: AppColors.white,
        body: Stack(
          children: <Widget>[
            SingleChildScrollView(
                scrollDirection: Axis.vertical,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Container(
                      margin: EdgeInsets.only(top: 120),
                      child: Stack(
                        children: <Widget>[
                          Center(
                            child: getTarjetaPokemon(context),
                          ),
                          getImagen(),
                        ],
                      ),
                    ),
                    SizedBox(
                      height: 10,
                    ),
                    getTarjetaHTML(context, Strings.tipos, generarTipos()),
                    SizedBox(
                      height: 10,
                    ),
                    getTarjetaHTML(context, Strings.formas, generarFormas()),
                    SizedBox(
                      height: 10,
                    ),
                    getTarjetaHTML(
                        context, Strings.movimientos, generarMovimientos()),
                  ],
                )),
            NavigationBar(false),
            Padding(
                padding: EdgeInsets.only(left: 15, top: 40, right: 10),
                child: GestureDetector(
                    onTap: () {
                      Navigator.pop(context);
                    },
                    child: Row(
                      children: <Widget>[
                        Icon(
                          Icons.arrow_back_ios,
                          color: AppColors.white,
                        ),
                        SizedBox(
                          width: 10,
                        ),
                        Text(
                          Strings.detalles,
                          style: TextStyle(
                              color: AppColors.white,
                              fontSize: 30.0,
                              fontFamily: "Pokemon",
                              fontWeight: FontWeight.bold),
                        ),
                      ],
                    ))),
          ],
        ));
  }

  Container getTarjetaPokemon(BuildContext context) {
    return Container(
      height: 160,
      width: MediaQuery.of(context).size.width - 60,
      margin: const EdgeInsets.only(
        top: 80.0,
      ),
      decoration: new BoxDecoration(
        color: AppColors.white,
        shape: BoxShape.rectangle,
        borderRadius: new BorderRadius.circular(8.0),
        boxShadow: <BoxShadow>[
          new BoxShadow(
              color: Colors.grey, blurRadius: 2.5, offset: new Offset(0.0, 5.0))
        ],
      ),
      child: new Container(
        margin: const EdgeInsets.only(top: 50.0),
        constraints: new BoxConstraints.expand(),
        child: new Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: <Widget>[
            new Text(
              pokemon.name,
              textAlign: TextAlign.center,
              style: TextStyle(
                  fontSize: 25,
                  fontFamily: "Pokemon",
                  fontWeight: FontWeight.bold,
                  color: AppColors.red),
            ),
            SizedBox(
              height: 10,
            ),
            Row(
              mainAxisSize: MainAxisSize.max,
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                new Flexible(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          "Height: ${pokemon.height}",
                          style: TextStyle(
                            fontFamily: "GoogleSans",
                            fontSize: 15.0,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        SizedBox(
                          height: 10,
                        ),
                        Text(
                          "Base Experience: ${pokemon.baseExperience}",
                          style: TextStyle(
                            fontFamily: "GoogleSans",
                            fontSize: 15.0,
                          ),
                        ),
                      ],
                    ),
                    flex: 1),
                new Flexible(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        "Weight: ${pokemon.weight}",
                        style: TextStyle(
                          fontFamily: "GoogleSans",
                          fontSize: 15.0,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      SizedBox(
                        height: 10,
                      ),
                      Text(
                        "Pokédex N.º: ${pokemon.id}",
                        style: TextStyle(
                          fontFamily: "GoogleSans",
                          fontSize: 15.0,
                        ),
                      ),
                    ],
                  ),
                  flex: 1,
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }

  Widget getTarjeta(BuildContext context, String titulo, String texto) {
    return Container(
        width: MediaQuery.of(context).size.width - 60,
        margin: EdgeInsets.all(10),
        child: Material(
          shape:
              RoundedRectangleBorder(borderRadius: BorderRadius.circular(10.0)),
          elevation: 5.0,
          color: AppColors.red,
          child: Column(
            children: <Widget>[
              Container(
                  margin: EdgeInsets.all(5),
                  child: Text(
                    titulo,
                    style: TextStyle(
                        fontSize: 20,
                        fontFamily: "GoogleSans",
                        fontWeight: FontWeight.bold,
                        color: Colors.white),
                    textAlign: TextAlign.center,
                  )),
              Material(
                color: Colors.white,
                borderRadius: BorderRadius.only(
                    bottomLeft: Radius.circular(10),
                    bottomRight: Radius.circular(10)),
                elevation: 15.0,
                child: Container(
                  alignment: Alignment.center,
                  margin: EdgeInsets.all(10),
                  child: Text(
                    texto,
                    style: TextStyle(
                        color: AppColors.black,
                        fontSize: 15.0,
                        fontFamily: "GoogleSans",
                        fontWeight: FontWeight.bold),
                  ),
                ),
              )
            ],
          ),
        ));
  }

  Widget getImagen() {
    return Container(
        height: 120,
        alignment: new FractionalOffset(0.5, 0.5),
        margin: const EdgeInsets.only(left: 30.0),
        child: new FadeInImage(
          image: NetworkImage(
            "${Strings.IMAGESURL}${pokemon.id}.png",
          ),
          placeholder: AssetImage("${Strings.images}errorImage.png"),
        ));
  }

  Widget getTarjetaHTML(BuildContext context, String titulo, String data) {
    return Container(
        width: MediaQuery.of(context).size.width - 60,
        margin: EdgeInsets.all(10),
        child: Material(
          shape:
              RoundedRectangleBorder(borderRadius: BorderRadius.circular(10.0)),
          elevation: 2.0,
          color: AppColors.lightblack,
          child: Column(
            children: <Widget>[
              Container(
                  margin: EdgeInsets.all(5),
                  child: Text(
                    titulo,
                    style: TextStyle(
                        fontSize: 20,
                        fontFamily: "GoogleSans",
                        fontWeight: FontWeight.bold,
                        color: Colors.white),
                    textAlign: TextAlign.center,
                  )),
              Material(
                color: Colors.white,
                borderRadius: BorderRadius.only(
                    bottomLeft: Radius.circular(10),
                    bottomRight: Radius.circular(10)),
                elevation: 2.0,
                child: Container(
                    alignment: Alignment.center,
                    margin: EdgeInsets.all(10),
                    child: Html(
                      data: data,
                      defaultTextStyle: TextStyle(
                          fontSize: 15,
                          fontFamily: "GoogleSans",
                          color: AppColors.black),
                    )),
              )
            ],
          ),
        ));
  }

  String generarFormas() {
    String movimientos = "";
    pokemon.forms.forEach((forms) {
      movimientos += "<ul><li>${forms.name}</li></ul><br>";
    });
    return movimientos;
  }

  String generarTipos() {
    String movimientos = "";
    pokemon.types.forEach((type) {
      movimientos += "<ul><li>${type.type.name}</li></ul><br>";
    });
    return movimientos;
  }

  String generarMovimientos() {
    String movimientos = "";
    pokemon.moves.forEach((move) {
      movimientos += "<ul><li>${move.move.name}</li></ul><br>";
    });
    return movimientos;
  }
}

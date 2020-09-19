import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:pokedex/Actividades/Details.dart';
import 'package:pokedex/Herramientas/AppColors.dart';
import 'package:pokedex/Herramientas/Herramientas.dart';
import 'package:pokedex/Herramientas/Strings.dart';
import 'package:pokedex/Herramientas/Views/ProgressBar.dart';
import 'package:pokedex/TDA/Pokemon.dart';
import 'package:pokedex/TDA/Specie.dart';

class PokeAdapter extends StatelessWidget {
  BuildContext context;
  Specie pokemon;
  int id;
  bool dialogo = false;

  PokeAdapter(this.pokemon, this.id);

  @override
  Widget build(BuildContext context) {
    this.context = context;
    return new Container(
      height: 130.0,
      margin: const EdgeInsets.symmetric(vertical: 10, horizontal: 5),
      child: new FlatButton(
        onPressed: () {
          showLoading();
          irDetalle(context);
        },
        child: new Stack(
          children: <Widget>[
            getTarjeta(),
            getImagen(),
          ],
        ),
      ),
    );
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

  Widget getImagen() {
    return Container(
        height: 90,
        alignment: new FractionalOffset(0.0, 0.45),
        margin: const EdgeInsets.only(left: 30.0),
        child: new FadeInImage(
          image: NetworkImage(
            "${Strings.IMAGESURL}${id}.png",
          ),
          placeholder: AssetImage("${Strings.images}errorImage.png"),
        ));
  }

  Widget getTarjeta() {
    return Container(
      width: 130,
      margin: const EdgeInsets.only(
        top: 40.0,
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
                  fontSize: 18,
                  fontFamily: "GoogleSans",
                  fontWeight: FontWeight.bold,
                  color: AppColors.red),
            ),
          ],
        ),
      ),
    );
  }

  irDetalle(BuildContext context) async {
    Pokemon pokemon;
    try {
      Map<String, dynamic> json = await Herramientas.requestBuilder(
          "${Strings.BASEURL}pokemon/${id}", false, "{}");
      if (dialogo) {
        dialogo = false;
        Navigator.pop(context);
      }
      pokemon = new Pokemon.fromJson(json);
      Navigator.of(context).push(MaterialPageRoute(
          builder: (context) => Details(
                pokemon: pokemon,
              )));
    } catch (e) {
      print(e);
      if (dialogo) {
        dialogo = false;
        Navigator.pop(context);
      }
      Fluttertoast.showToast(
          msg: Strings.errorS,
          backgroundColor: AppColors.darkblue,
          textColor: AppColors.white);
    }

  }
}

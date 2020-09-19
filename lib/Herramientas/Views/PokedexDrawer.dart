import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:giffy_dialog/giffy_dialog.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:pokedex/Actividades/Home.dart';
import 'package:pokedex/Actividades/LogIn.dart';
import 'package:pokedex/Actividades/Pokedex.dart';
import 'package:pokedex/Herramientas/SessionManager.dart';

import '../AppColors.dart';
import '../Strings.dart';

class PokedexDrawer extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    // TODO: implement createState
    return new _PokedexDrawer();
  }
}

class _PokedexDrawer extends State<PokedexDrawer> {
  SessionManager sessionManager;
  final FirebaseAuth _auth = FirebaseAuth.instance;
  final GoogleSignIn _googleSignIn = GoogleSignIn();
  String nombre = "";
  String email = "";
  String foto;

  @override
  void initState() {
    super.initState();
    configuracion();
  }

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return Drawer(
      child: ListView(
        padding: EdgeInsets.zero,
        children: <Widget>[
          UserAccountsDrawerHeader(
            margin: EdgeInsets.zero,
            accountName: Text(nombre,
                style: TextStyle(
                    fontSize: 15,
                    fontFamily: "GoogleSans",
                    fontWeight: FontWeight.bold,
                    color: AppColors.red)),
            accountEmail: Text(
              email,
              style: TextStyle(
                  fontSize: 13,
                  fontFamily: "GoogleSans",
                  fontWeight: FontWeight.bold,
                  color: AppColors.red),
            ),
            currentAccountPicture: CircleAvatar(
              backgroundImage: foto != null
                  ? NetworkImage(foto)
                  : AssetImage(Strings.images + "fotopersona.png"),
            ),
            decoration: BoxDecoration(
              image: new DecorationImage(
                  image: new AssetImage("${Strings.images}fondo.jpg"),
                  fit: BoxFit.cover),
            ),
          ),
          ListTile(
            title: Text(Strings.home,
                style: TextStyle(
                    fontSize: 15,
                    fontFamily: "GoogleSans",
                    color: AppColors.red)),
            trailing: Icon(
              Icons.home,
              color: AppColors.red,
            ),
            onTap: () {
              Navigator.pushAndRemoveUntil(
                  context,
                  MaterialPageRoute(builder: (context) => Home()),
                  ModalRoute.withName('/Home'));
            },
          ),
          ListTile(
            title: Text(Strings.pokedex,
                style: TextStyle(
                    fontSize: 15,
                    fontFamily: "GoogleSans",
                    color: AppColors.red)),
            trailing: Icon(
              Icons.list_alt_rounded,
              color: AppColors.red,
            ),
            onTap: () {
              Navigator.pushAndRemoveUntil(
                  context,
                  MaterialPageRoute(builder: (context) => Pokedex()),
                  ModalRoute.withName('/Welcome'));
            },
          ),
          ListTile(
            title: Text(Strings.cerrarS,
                style: TextStyle(
                    fontSize: 15,
                    fontFamily: "GoogleSans",
                    fontWeight: FontWeight.bold,
                    color: AppColors.red)),
            trailing: Icon(
              Icons.exit_to_app,
              color: AppColors.red,
            ),
            onTap: () {
              cerrarSesion(context);
            },
          )
        ],
      ),
    );
  }

  void cerrarSesion(BuildContext context) async {
    showDialog(
        context: context,
        builder: (_) => AssetGiffyDialog(
              image: Image.asset('assets/images/adios.gif', fit: BoxFit.cover),
              title: Text(
                Strings.confirmacion,
                style: TextStyle(
                    fontSize: 22,
                    fontFamily: "GoogleSans",
                    fontWeight: FontWeight.bold,
                    color: AppColors.darkblue),
              ),
              description: Text(
                '${nombre} are you sure you want to sign out?',
                textAlign: TextAlign.center,
                style: TextStyle(
                    fontSize: 15,
                    fontFamily: "GoogleSans",
                    color: AppColors.darkblue),
              ),
              buttonCancelText: Text(
                Strings.cancelar,
                style: TextStyle(fontFamily: "GoogleSans", color: Colors.white),
              ),
              buttonOkText: Text(
                Strings.aceptar,
                style: TextStyle(fontFamily: "GoogleSans", color: Colors.white),
              ),
              onOkButtonPressed: () async {
                await _googleSignIn.signOut();
                await _auth.signOut();
                await sessionManager.setHome(false);
                Navigator.pushAndRemoveUntil(
                    context,
                    MaterialPageRoute(builder: (context) => LogIn()),
                    ModalRoute.withName('/logIn'));
              },
            ));
  }

  User getUser() {
    return _auth.currentUser;
  }

  Future configuracion() async {
    sessionManager = new SessionManager();
    await sessionManager.inicializar();
    User user = getUser();
    if (user != null) {
      setState(() {
        nombre = user.displayName;
        email = user.email;
        if (user.photoURL != null) {
          if (user.photoURL.contains("s96-c/"))
            foto = user.photoURL.split("s96-c/")[0] +
                user.photoURL.split("s96-c/")[1];
          else
            foto = user.photoURL + "?height=500&width=500";
        }
      });
    }
  }
}

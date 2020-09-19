import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:giffy_dialog/giffy_dialog.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:pokedex/Herramientas/AppColors.dart';
import 'package:pokedex/Herramientas/Herramientas.dart';
import 'package:pokedex/Herramientas/SessionManager.dart';
import 'package:pokedex/Herramientas/Strings.dart';
import 'package:pokedex/Herramientas/Views/NavigationBar.dart';

import 'Home.dart';
import 'Welcome.dart';

class LogIn extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    // TODO: implement createState
    return new _LogIn();
  }
}

class _LogIn extends State<LogIn> {
  SessionManager sessionManager;
  final FirebaseAuth _auth = FirebaseAuth.instance;
  final GoogleSignIn _googleSignIn = GoogleSignIn();
  bool conexion = false;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    configuracion();
  }

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return Scaffold(
      backgroundColor: AppColors.white,
      body: Stack(children: <Widget>[
        NavigationBar(true),
        Container(
          alignment: Alignment.topCenter,
          child: Padding(
            padding: EdgeInsets.only(top: 150),
            child: Text(
              Strings.bienvenido,
              style: TextStyle(
                  color: AppColors.white,
                  fontSize: 30.0,
                  fontFamily: "Pokemon",
                  fontWeight: FontWeight.bold),
            ),
          ),
        ),
        ListView(
          scrollDirection: Axis.vertical,
          children: <Widget>[
            Column(
              children: <Widget>[
                Container(
                  margin: EdgeInsets.only(top: 190, bottom: 20),
                  alignment: Alignment.center,
                  child: Material(
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(10.0)),
                    elevation: 5.0,
                    color: Colors.white,
                    child: Container(
                        width: 250,
                        margin: EdgeInsets.all(10),
                        child: Column(
                          children: <Widget>[
                            Padding(
                              padding: EdgeInsets.all(10),
                              child: Image(
                                height: 150,
                                width: 150,
                                image:
                                    AssetImage("${Strings.images}pokeapi.png"),
                              ),
                            ),
                            Text(
                              Strings.iniciarS,
                              style: TextStyle(
                                  fontSize: 16,
                                  fontFamily: "GoogleSans",
                                  fontWeight: FontWeight.bold,
                                  color: AppColors.red),
                              textAlign: TextAlign.center,
                            ),
                            Padding(
                              padding: EdgeInsets.all(10),
                              child: new RaisedButton(
                                onPressed: () async {
                                  _signInWithGoogle();
                                },
                                child: Text(
                                  Strings.ingresar,
                                  style: TextStyle(
                                      fontSize: 16,
                                      fontFamily: "GoogleSans",
                                      fontWeight: FontWeight.bold,
                                      color: AppColors.white),
                                  textAlign: TextAlign.center,
                                ),
                                color: AppColors.red,
                              ),
                            )
                          ],
                        )),
                  ),
                ),
              ],
            )
          ],
        ),
      ]),
    );
  }

  _signInWithGoogle() async {
    GoogleSignInAccount googleUser = await _googleSignIn.signIn();
    GoogleSignInAuthentication googleAuth = await googleUser.authentication;
    AuthCredential credential = GoogleAuthProvider.credential(
      accessToken: googleAuth.accessToken,
      idToken: googleAuth.idToken,
    );

    UserCredential user = await _auth.signInWithCredential(credential);
    User currentUser = user.user;

    if (currentUser == null) {
      cerrarSesion();
      showDialog(
          context: context,
          builder: (context) => _onError(context, Strings.errorS));
    } else {
      await sessionManager.setHome(false);
      logueado();
    }
  }

  void cerrarSesion() async {
    sessionManager.setHome(false);
    _googleSignIn.signOut();
    _auth.signOut();
  }

  _onError(BuildContext context, String texto) {
    return AssetGiffyDialog(
      image: Image.asset(
        '${Strings.images}adios.gif',
        fit: BoxFit.cover,
      ),
      title: Text(
        Strings.error,
        style: TextStyle(
            fontSize: 22,
            fontFamily: "GoogleSans",
            fontWeight: FontWeight.bold,
            color: AppColors.red),
      ),
      description: Text(
        texto,
        textAlign: TextAlign.center,
        style: TextStyle(
            fontSize: 15, fontFamily: "GoogleSans", color: AppColors.darkblue),
      ),
      onlyOkButton: true,
      buttonOkText: Text(
        Strings.aceptar,
        style: TextStyle(fontFamily: "GoogleSans", color: Colors.white),
      ),
      onOkButtonPressed: () {
        Navigator.pop(context);
      },
    );
  }

  User getUser() {
    return _auth.currentUser;
  }

  datosMoviles(BuildContext context) async {
    showDialog(
        context: context,
        builder: (_) => FlareGiffyDialog(
              flarePath: 'assets/images/space_demo.flr',
              flareAnimation: 'loading',
              title: Text(
                Strings.datosMoviles,
                style: TextStyle(
                    fontSize: 20,
                    fontFamily: "GoogleSans",
                    fontWeight: FontWeight.bold,
                    color: AppColors.darkblack),
              ),
              description: Text(
                Strings.datosMovilesInfo,
                textAlign: TextAlign.center,
                style: TextStyle(
                    fontSize: 12,
                    fontFamily: "GoogleSans",
                    color: AppColors.darkblack),
              ),
              buttonCancelText: Text(
                Strings.cancelar,
                style: TextStyle(fontFamily: "GoogleSans", color: Colors.white),
              ),
              buttonOkText: Text(
                Strings.subir,
                style: TextStyle(fontFamily: "GoogleSans", color: Colors.white),
              ),
              onOkButtonPressed: () async {
                this.conexion = true;
                Navigator.pop(context);
              },
            ));
  }

  logueado() async {
    if (await sessionManager.getHome())
      Navigator.pushAndRemoveUntil(
          context,
          MaterialPageRoute(builder: (context) => Home()),
          ModalRoute.withName('/Home'));
    else
      Navigator.pushAndRemoveUntil(
          context,
          MaterialPageRoute(builder: (context) => Welcome()),
          ModalRoute.withName('/Welcome'));
  }

  configuracion() async {
    sessionManager = new SessionManager();
    Herramientas.checkConnection().then((tipoConexion) async {
      if (tipoConexion != null) {
        if (tipoConexion == 1) {
          if (!conexion) datosMoviles(context);
        } else if (tipoConexion == 2)
          this.conexion = true;
        else
          this.conexion = false;
      }
    });
    if (await sessionManager.inicializar()) {
      if (getUser() != null) logueado();
    }
  }
}

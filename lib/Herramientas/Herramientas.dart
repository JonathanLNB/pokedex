import 'dart:convert';
import 'dart:io';

import 'package:connectivity/connectivity.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:giffy_dialog/giffy_dialog.dart';
import 'package:requests/requests.dart';
import 'AppColors.dart';
import 'Strings.dart';

class Herramientas {
  static void salir(BuildContext context) async {
    showDialog(
        context: context,
        builder: (_) => AssetGiffyDialog(
              image: Image.asset(Strings.images + "adios.gif",
                  fit: BoxFit.cover),
              title: Text(
                Strings.salir,
                style: TextStyle(
                    fontSize: 22,
                    fontFamily: "GoogleSans",
                    fontWeight: FontWeight.bold,
                    color: AppColors.darkblack),
              ),
              description: Text(
                Strings.salirInfo,
                textAlign: TextAlign.center,
                style: TextStyle(
                    fontSize: 15,
                    fontFamily: "GoogleSans",
                    color: AppColors.darkblack),
              ),
              buttonCancelText: Text(
                Strings.cancelar,
                style: TextStyle(fontFamily: "GoogleSans", color: Colors.white),
              ),
              buttonOkText: Text(
                Strings.aceptar,
                style: TextStyle(fontFamily: "GoogleSans", color: Colors.white),
              ),
              onOkButtonPressed: () {
                Platform.isAndroid ? SystemNavigator.pop() : exit(0);
              },
            ));
  }

  static Future<int> checkConnection() async {
    var connectivityResult = await (Connectivity().checkConnectivity());
    if (connectivityResult == ConnectivityResult.mobile) {
      return 1;
    } else if (connectivityResult == ConnectivityResult.wifi) {
      return 2;
    }
    return 0;
  }

  static Future<Map<String, dynamic>> requestBuilder(
    String url,
    bool post,
    String body,
  ) async {
    Future<Map<String, dynamic>> getData() async {
      var r;
      String bodyResponse;
      try {
        if (post)
          r = await Requests.post(url, body: jsonDecode(body), timeoutSeconds: 60, verify: false);
        else
          r = await Requests.get(url, timeoutSeconds: 60, verify: false);
        r.raiseForStatus();
        bodyResponse = r.content();
        Map<String, dynamic> data = jsonDecode(bodyResponse);
        return data;
      } catch (e) {
        print(e);
        return null;
      }
    }

    return await getData();
  }
}

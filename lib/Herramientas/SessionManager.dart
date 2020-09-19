import 'package:shared_preferences/shared_preferences.dart';

class SessionManager {
  SharedPreferences session;
  static String HOME = "HOME";

  setHome(bool home) async {
    await session.setBool(HOME, home);
  }

  Future<bool> getHome() async {
    return session.getBool(HOME) ?? "";
  }

  Future<bool> inicializar() async {
    session = await SharedPreferences.getInstance();
    if (session != null)
      return true;
    else
      return false;
  }
}
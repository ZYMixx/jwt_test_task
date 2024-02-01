import 'package:shared_preferences/shared_preferences.dart';

class ServiceSharedPreferences {
  static late SharedPreferences sharedPreferences;

  static String _RTKey = 'token_RT';
  static String _JWTKey = 'token_JWT';

  static init() async {
    sharedPreferences = await SharedPreferences.getInstance();
  }

  static putRT({required token}) {
    _putString(key: _RTKey, stringData: token);
  }

  static String? getRT() {
    return _getString(key: _RTKey);
  }

  static putJWT({required token}) {
    _putString(key: _JWTKey, stringData: token);
  }

  static String? getJWT() {
    return _getString(key: _JWTKey);
  }

  static _putString({required String key, required String stringData}) {
    sharedPreferences.setString(key, stringData);
  }

  static String? _getString({required String key}) {
    return sharedPreferences.getString(key);
  }

  static resetKey({required String key}) {
    sharedPreferences.remove(key);
  }
}

// flutter pub add shared_preferences

import 'package:dio/dio.dart';
import 'package:jwt_decoder/jwt_decoder.dart';
import 'package:jwt_test_task/data/tools/tool_show_toast.dart';

import '../services/service_shared_preferences.dart';

class ApiWork {

  String host = 'https://d5dsstfjsletfcftjn3b.apigw.yandexcloud.net/';

  Future<bool> requestCodeByEmail({required String user_email}) async {
    Dio dio = Dio();
    Map<String, dynamic> jsonData = {
      'email': user_email,
    };
    try {
      Response response = await dio.post(
        '$host/login',
        data: jsonData,
      );
      if (response.statusCode == 200) {
        ToolShowToast.show('${response.data['info']}');
        return true;
      } else {
        return false;
      }
    } catch (e) {
      ToolShowToast.showError('Not valid email');
      return false;
    }
  }

  Future<bool> requestJWTbyCode({required String user_email, required String code}) async {
    Dio dio = Dio();
    Map<String, dynamic> jsonData = {
      'email': user_email,
      'code': code,
    };
    try {
      Response response = await dio.post(
        '$host/confirm_code',
        data: jsonData,
      );
      if (response.statusCode == 200) {
        ServiceSharedPreferences.putRT(token: response.data['refresh_token']);
        ServiceSharedPreferences.putJWT(token: response.data['jwt']);
        return true;
      } else {
        return false;
      }
    } catch (e) {
      ToolShowToast.showError('Code Error! Wrong email or code');
      return false;
    }
  }

  Future<bool> requestJWTbyRT({required String tokenRT}) async {
    Dio dio = Dio();
    Map<String, dynamic> jsonData = {
      'token': tokenRT,
    };
    try {
      Response response = await dio.post(
        '$host/refresh_token',
        data: jsonData,
      );
      ServiceSharedPreferences.putRT(token: response.data['refresh_token']);
      ServiceSharedPreferences.putJWT(token: response.data['jwt']);
      return true;
    } catch (e) {
      ToolShowToast.showError('RT update error');
      return false;
    }
  }

  //ApiWork.authenticateUserWithJWT {"Authorized":"ok"}
  //decodedToken {user: 0c336783-4b80-42f7-a0b5-4a533ba2e9d1, iat: 1706745346, exp: 1706748946}
  Future<bool> authenticateUserWithJWT() async {
    Dio dio = Dio();
    var jwtToken = ServiceSharedPreferences.getJWT();
    if (jwtToken == null || !JwtDecoder.isExpired(jwtToken)) {
      var tokenRT = ServiceSharedPreferences.getRT();
      if (tokenRT != null) {
        requestJWTbyRT(tokenRT: tokenRT);
      }
      jwtToken = ServiceSharedPreferences.getJWT();
    }
    dio.options.headers['Auth'] = 'Bearer $jwtToken';
    try {
      Response response = await dio.get(
        '$host/auth',
      );
      if (response.statusCode == 200) {
        return true;
      } else {
        return false;
      }
    } catch (e) {
      return false;
    }
  }
}

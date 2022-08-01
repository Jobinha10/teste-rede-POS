import 'dart:convert';
import 'package:wishes/Classes/classWebAPI.dart';
import 'package:wishes/session.dart' as session;

class LoginAPI {
  var _messegeErro;
  Future<bool> login(String email, String senha) async {
    ClassWebAPI clWebAPI = ClassWebAPI();
    Map parametros = {
      "apptoken": session.appToken,
      "password": senha,
      "email": email
    };

    // A variavel "parametros" que é passada dentro do post() é capturada pela web-api no parametro [frombody]
    var response = await clWebAPI.login(parametros);

    Map<String, dynamic> mapResponse = json.decode(response.body);

    LoginAPI().salvarTokenJwt(mapResponse);

    if (response.statusCode == 200) {
      if (LoginAPI().salvarTokenJwt(mapResponse)) {
        return true;
      } else {
        return false;
      }
    } else {
      return false;
    }
  }

  bool salvarTokenJwt(Map<String, dynamic> json) {
    try {
      session.usuarioLogado.jwtToken = json["jwttoken"];
      return true;
    } catch (e) {
      _messegeErro = json["error"];
      return false;
    }
  }
}

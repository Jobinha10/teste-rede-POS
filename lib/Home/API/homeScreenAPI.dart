import 'dart:convert';
import 'package:wishes/Classes/classWebAPI.dart';
import 'package:wishes/session.dart' as session;

class HomeScreenAPI {
  Future<bool> setValue(String key, String value) async {
    ClassWebAPI clWebAPI = ClassWebAPI();
    Map parametros = {
      "key": key,
      "value": key,
    };

    // A variavel "parametros" que é passada dentro do post() é capturada pela web-api no parametro [frombody]
    var response = await clWebAPI.setValue(parametros);

    if (response.statusCode == 200) {
      return true;
    } else {
      return false;
    }
  }
  Future<bool> deleteValue(String key) async {
    ClassWebAPI clWebAPI = ClassWebAPI();
    Map parametros = {
      "key": key,
    };

    // A variavel "parametros" que é passada dentro do post() é capturada pela web-api no parametro [frombody]
    var response = await clWebAPI.deleteValue(parametros);

    // Map<String, dynamic> mapResponse = json.decode(response.body);

    if (response.statusCode == 200) {
      return true;
    } else {
      return false;
    }
  }
  Future<String> getValue(String key) async {
    ClassWebAPI clWebAPI = ClassWebAPI();
    Map parametros = {
      "key": key,
    };

    // A variavel "parametros" que é passada dentro do post() é capturada pela web-api no parametro [frombody]
    var response = await clWebAPI.getvalue(parametros);

    Map<String, dynamic> mapResponse = json.decode(response.body);
    
    String value = mapResponse["value"];

    if (response.statusCode == 200) {
      return value;
    } else {
      return value;
    }
  }
}

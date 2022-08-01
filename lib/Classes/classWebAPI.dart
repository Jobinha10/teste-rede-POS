import 'dart:convert';
import 'dart:core';
import 'package:http/http.dart' as http;
import 'package:wishes/classes/classUtil.dart';
import 'package:wishes/session.dart' as session;

class ClassWebAPI {
  List<String> _pamaters = [];
  String _webAPIName = "";

  //Adiciona parametros à lista
  addParams(String value) {
    this._pamaters.add(value);
  }

  //Monta URL
  String _getURL() {
    String _apiURL;
    ClassUtil clUtil = new ClassUtil();
    int x;

    _apiURL = "";
    _apiURL += session.hostName;

    _apiURL += this._webAPIName + "/";

    //CARREGA PRAMETROS
    if (_pamaters.length > 0) {
      for (x = 0; x < _pamaters.length; x++) {
        _apiURL += this._pamaters[x] + "/";
      }
    }
    //REMOVE ULTIMA BARRA
    _apiURL = clUtil.cropString(_apiURL);

    return _apiURL;
  }

  Future<http.Response> login(Map parametros) async {
    Uri url;
    this._webAPIName = "login";

    url = Uri.parse(this._getURL());

    //HEADER DO JSON
    var header = {"content-type": "application/json"};

    //MAPEIA OS PARAMETROS PARA JSON
    var body = json.encode(parametros);

    print("Print body:" + body);

    return await http.post(url, headers: header, body: body);
  }

  Future<http.Response> cadastrar(Map parametros) async {
    Uri url;
    this._webAPIName = "signup";

    url = Uri.parse(this._getURL());

    //HEADER DO JSON
    var header = {"content-type": "application/json"};

    //MAPEIA OS PARAMETROS PARA JSON
    var body = json.encode(parametros);

    print("Print body:" + body);

    return await http.post(url, headers: header, body: body);
  }

  Future<http.Response> setValue(Map parametros) async {
    Uri url;
    this._webAPIName = "setvalue";

    url = Uri.parse(this._getURL());

    //HEADER DO JSON
    var header = {
      "content-type": "application/json",
      "token": session.usuarioLogado.jwtToken,
    };

    //MAPEIA OS PARAMETROS PARA JSON
    var body = json.encode(parametros);

    print("Print body:" + body);

    return await http.post(url, headers: header, body: body);
  }

  Future<http.Response> getvalue(Map parametros) async {
    Uri url;
    this._webAPIName = "getvalue";

    url = Uri.parse(this._getURL());

    //HEADER DO JSON
    var header = {
      "content-type": "application/json",
      "token": session.usuarioLogado.jwtToken,
    };

    //MAPEIA OS PARAMETROS PARA JSON
    var body = json.encode(parametros);

    print("Print body:" + body);

    return await http.post(url, headers: header, body: body);
  }

  Future<http.Response> deleteValue(Map parametros) async {
    Uri url;
    this._webAPIName = "remvalue";

    url = Uri.parse(this._getURL());

    //HEADER DO JSON
    var header = {
      "content-type": "application/json",
      "token": session.usuarioLogado.jwtToken,
    };

    //MAPEIA OS PARAMETROS PARA JSON
    var body = json.encode(parametros);

    print("Print body:" + body);

    return await http.post(url, headers: header, body: body);
  }

  Future<http.Response> getalldata() async {
    Uri url;
    this._webAPIName = "getalldata";

    url = Uri.parse(this._getURL());

    //HEADER DO JSON
    var header = {
      "content-type": "application/json",
      "token": session.usuarioLogado.jwtToken,
    };

    return await http.post(url, headers: header, body: {});
  }
}

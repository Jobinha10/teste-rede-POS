import 'package:wishes/Classes/classWebAPI.dart';
import 'package:wishes/session.dart' as session;

class CadastroAPI {
  Future<bool> cadastrar(String email,String senha,String nome) async {
    ClassWebAPI clWebAPI = ClassWebAPI();
    Map parametros = {
      "apptoken": session.appToken,
      "name": nome,
      "password": senha,
      "email": email
    };

    // A variavel "parametros" que é passada dentro do post() é capturada pela web-api no parametro [frombody]
    var response = await clWebAPI.cadastrar(parametros);

    if (response.statusCode == 200) {
      return true;
    } else {
      return false;
    }
  }
}

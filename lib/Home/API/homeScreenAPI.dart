import 'dart:convert';
import 'package:wishes/Classes/classUtil.dart';
import 'package:wishes/Classes/classWebAPI.dart';
import 'package:wishes/Home/JSON/produtosDesejadosJSON.dart';

class HomeScreenAPI {
  Future<bool> setValue(String key, String value) async {
    ClassWebAPI clWebAPI = ClassWebAPI();
    Map parametros = {
      "key": key,
      "value": value,
    };

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

    var response = await clWebAPI.deleteValue(parametros);

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

    var response = await clWebAPI.getvalue(parametros);

    Map<String, dynamic> mapResponse = json.decode(response.body);

    String value = mapResponse["value"];

    if (response.statusCode == 200) {
      return value;
    } else {
      return value;
    }
  }

  Future<List<ProdutosDesejadosJSON>> getAllItens() async {
    ClassWebAPI clWebAPI = ClassWebAPI();
    List<ProdutosDesejadosJSON> produtos = [];

    var response = await clWebAPI.getalldata();

    Map<String, dynamic> mapResponse = json.decode(response.body);

    var value = mapResponse["data"];
    int quantidadeItens = ClassUtil().stgToInt(value["quantidadeItens"]);

    //ISSO FOI FEITO PARA ADAPTAR UMA LOGICA:
    //COMO UMA KEY NÃO PODE SER RESPEDIDA NÃO SERIA POSSÍVEL GERAR UMA LISTA FUNCINAL NO DART
    //ENTÃO CRIEI UMA FORMA DE PODER OBTER CORRETAMENTE ESSA LISTA
    for (var i = 0; i < quantidadeItens; i++) {
    int idCorretoItem = i + 1;
    String id = idCorretoItem.toString();
      produtos.add(
        ProdutosDesejadosJSON(
          numeroProduto: id,
          nomeProduto: value["nomeProduto" + id],
          descricao: value["descricaoProduto" + id],
          mediaValor: value["mediaValorProduto" + id],
          data: value["dataProduto" + id],
          linkProduto: value["linkProduto" + id],
        ),
      );
    }

    if (response.statusCode == 200) {
      return produtos;
    } else {
      return produtos;
    }
  }
}

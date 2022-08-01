// import 'package:decimal/decimal.dart';
// import 'package:decimal/intl.dart';
// import 'package:flutter/material.dart';
// import 'package:intl/intl.dart';

//**********************************************************************
//!UMA CLASSE QUE TEM DIVERSOS METODOS QUE PODEM SER UTIL AO PROJETO
//**********************************************************************
import 'package:intl/intl.dart';

class ClassUtil {
  //Remove ultimo caracter de uma string
  String cropString(String texto) {
    return texto.substring(0, texto.length - 1);
  }

  //Formata data Do padrão aaaa-mm-ddThh-mm-ss para dd/MM/aaaa
  String formatarData(String data) {
    DateFormat formatter = DateFormat('dd/MM/yyyy');

    //Formata
    data = formatter.format(DateTime.parse(data));

    return data;
  }


  //CONVERTE UMA STRING NUM DOUBLE
  stgToDouble(String valorString) {
    double? valorDouble = double.tryParse(valorString);
    return valorDouble;
  }

  //CONVERTE UMA STRING NUM DOUBLE
  stgToInt(String valorString) {
    int? valorDouble = int.tryParse(valorString);
    return valorDouble;
  }

  //Retorna uma string apenas com numeros de zero a nove removendo todo e qualquer outro caracter
  String soNumeros(String texto) {
    return texto.replaceAll(RegExp(r'[^0-9]'), '');
  }

  //Retorna uma string apenas com letras de Aa à zZ removendo todo e qualquer outro caracter
  String soLetras(String texto) {
    return texto.replaceAll(RegExp('[^aA-zZ]'), '');
  }

  // Valida se a string passada é um numeral válido
  bool isNumeric(String numero) {
    return (!(double.tryParse(numero) == null));
  }

  stringParaDouble(String valorString) {
    double? valorDouble = double.tryParse(valorString);
    return valorDouble;
  }
}

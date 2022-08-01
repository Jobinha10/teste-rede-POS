import 'package:flutter/material.dart';

//--------------------------------------------------------------------------
//ESSA CLASSE VISA DAR UM TEMA MAIS APRIMORADO PARA O APP DO QUE O THEMEDATA
//DO MAIN, POIS ELE POSSUI ALGUMAS LIMITAÇÕES PARA APLICAÇÕES GRANDES OU COM
//UM DESIGNER MUITO PERSONALIZADO
//--------------------------------------------------------------------------
//ESSA CLASSE PODE CONTER QUALQUER COISA REALCIONADA AO TEMA DO APP,EX:
//logo, gradient e colors além de textStyles.
class AppTheme {
  AppTheme();

  //****************************************************************
  //!COLORS
  //****************************************************************
  static const Color roxoApp = Color(0xff9E49FD);
  static const Color cinzaApp = Color(0xffA8A8A8);
  static const Color cinzaBordasNeutras = Color(0xff474053);
  static const Color pretoFundoTxtff = Color(0xff211D28);

  //****************************************************************
  //!TextStyles
  //****************************************************************
  //BASICO UTILIZADO POR VARIOS TEXT E TEXTFORMFIELDS
  static TextStyle stylePadrao = TextStyle(
    fontSize: 14,
    fontFamily: "Inter",
    fontWeight: FontWeight.w700,
    color: AppTheme.cinzaApp,
  );
  //VARIANTE DO BASICO UTILIZADO PORÉM COM A COR ROXA
  static TextStyle stylePadraoRoxo = TextStyle(
    fontSize: 14,
    fontFamily: "Inter",
    fontWeight: FontWeight.w700,
    color: AppTheme.roxoApp,
  );
  //VARIANTE DO BASICO UTILIZADO PORÉM COM A COR BRANCA
  static TextStyle stylePadraoBranco = TextStyle(
    fontSize: 14,
    fontFamily: "Inter",
    fontWeight: FontWeight.w700,
    color: Colors.white,
  );
  //BASICO UTILIZADO EM TITULOS
  static TextStyle styleTitulos = TextStyle(
    fontSize: 32,
    fontFamily: "Inter",
    fontWeight: FontWeight.w700,
    color: Colors.white,
  );
  //BASICO UTILIZADO EM TITULOS
  static TextStyle styleTitulos2 = TextStyle(
    fontSize: 17,
    fontFamily: "Inter",
    fontWeight: FontWeight.w700,
    color: Colors.white,
  );
  //STYLE QUE PODE SER PERSONALIZADO DA FORMA QUE NECESSITA
  static TextStyle stylePerson({
    double size = 14,
    FontWeight fontWeight: FontWeight.w700,
    Color color = AppTheme.cinzaApp,
    TextDecoration txtDecoration = TextDecoration.none,
  }) {
    return TextStyle(
      fontSize: size,
      fontWeight: fontWeight,
      color: color,
      fontStyle: FontStyle.normal,
      decoration: txtDecoration,
      fontFamily: "Inter",
    );
  }

  //****************************************************************
  //!GRADIENT PADRÃO JÁ MONTADO E UTILIZADO EM VÁRIAS PARTES DO APP
  //****************************************************************
  static const LinearGradient gradientPadrao = LinearGradient(
    begin: Alignment.topLeft,
    end: Alignment.bottomRight,
    tileMode: TileMode.clamp,
    colors: <Color>[
      Color(0xff4F2F79),
      Color(0xff211D28),
      Color(0xff4F2F79),
    ],
  );

  //****************************************************************
  //!ICONES PERSONALIZADOS DO APK
  //****************************************************************
  static Widget userIcon({double size = 15, Color color = AppTheme.roxoApp}) =>
      ImageIcon(
        AssetImage("assets/icons/userIcon.png"),
        size: size,
        color: color,
      );
  static Widget lockIcon({double size = 15, Color color = AppTheme.roxoApp}) =>
      ImageIcon(
        AssetImage("assets/icons/lock.png"),
        size: size,
        color: color,
      );
  //****************************************************************
  //!LOGO DO APK
  //****************************************************************
  static Widget logo = SizedBox(
    width: 63.75,
    height: 86.06,
    child: Image.asset(
      "assets/logo/logo.png",
      fit: BoxFit.cover,
    ),
  );

  //****************************************************************
  //!BOTÃO PADRÃO DO APK
  //****************************************************************
  static Widget botaoPadrao({String texto ="", void Function()? onTap}) => InkWell(
    child: Container(
        width: 342,
        height: 48,
        decoration: BoxDecoration(
          color: AppTheme.roxoApp,
          borderRadius: BorderRadius.circular(10),
          boxShadow: [BoxShadow(color: AppTheme.roxoApp)],
        ),
        child: Center(child: Text(texto, style: AppTheme.stylePadraoBranco)),
      ),
      onTap: () => onTap!(),
  );
}

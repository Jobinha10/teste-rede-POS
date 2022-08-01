// ignore_for_file: invalid_use_of_protected_member

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:wishes/theme.dart';

//**********************************************************
//!ENCAPSULADO QUE PADRONIZAR O WIDGET TextFormField
//**********************************************************
class TxffPadrao {
  //Controller da classe não privado para utilizar em telas
  final ctrlTextFormField = TextEditingController();
  //Controller para dizer se o txf é apenas de leitura
  bool readOnly = false;
  bool obscureText = true;

  Widget txfBordaPersonalizada(
    String texto, {
    required TextInputType keyboardType,
    required bool isFocused,
    required Function()? onTap,
    required Widget prefixIcon,
    double topLeft = 0,
    double topRight = 0,
    double bottomLeft = 0,
    double bottomRight = 0,
    bool useObscureText = false,
    void Function()? obscureTextState,
    Widget? suffixIcon,
    State? state,
  }) {
    return TextFormField(
      controller: ctrlTextFormField,
      keyboardType: keyboardType,
      readOnly: readOnly,
      onTap: () => onTap!(),
      autofocus: true,
      obscureText: useObscureText ? obscureText : false,
      decoration: InputDecoration(
        focusedBorder: _outlineInputBorderPerson(
          topLeft: topLeft,
          topRight: topRight,
          bottomLeft: bottomLeft,
          bottomRight: bottomRight,
          color: AppTheme.roxoApp,
        ),
        enabledBorder: _outlineInputBorderPerson(
          topLeft: topLeft,
          topRight: topRight,
          bottomLeft: bottomLeft,
          bottomRight: bottomRight,
          color: AppTheme.cinzaBordasNeutras,
        ),
        filled: true,
        fillColor: AppTheme.pretoFundoTxtff,
        hintText: texto,
        border: InputBorder.none,
        hintStyle:
            isFocused ? AppTheme.stylePadraoBranco : AppTheme.stylePadrao,
        prefixIcon: prefixIcon,
        suffixIcon:
            useObscureText ? iconVisible(isFocused, obscureTextState) : null,
        labelStyle: AppTheme.stylePadrao,
      ),
      style: AppTheme.stylePadrao,
      cursorColor: AppTheme.roxoApp,
    );
  }

  Widget txfPadrao(
    String text, {
    required TextInputType keyboardType,
    required bool isFocused,
    required Function()? onTap,
    int maxLines = 1,
    MaxLengthEnforcement maxLengthEnforcement = MaxLengthEnforcement.none,
    bool isSearch = false,
    bool useObscureText = false,
    void Function()? obscureTextState,
  }) {
    return TextFormField(
      controller: ctrlTextFormField,
      keyboardType: keyboardType,
      readOnly: readOnly,
      onTap: () => onTap!(),
      maxLines: maxLines,
      maxLengthEnforcement: maxLengthEnforcement,
      obscureText: useObscureText ? obscureText : false,
      decoration: InputDecoration(
        hintText: text,
        hintStyle:
            isFocused ? AppTheme.stylePadraoBranco : AppTheme.stylePadrao,
        filled: true,
        fillColor: AppTheme.pretoFundoTxtff,
        border: InputBorder.none,
        prefixIcon: isSearch
            ? Icon(
                Icons.search,
                color: isFocused ? AppTheme.roxoApp : AppTheme.cinzaApp,
              )
            : AppTheme.lockIcon(
                color: isFocused ? AppTheme.roxoApp : AppTheme.cinzaApp,
              ),
        suffixIcon:
            useObscureText ? iconVisible(isFocused, obscureTextState) : null,
        focusedBorder:
            isSearch ? null : _outlineInputBorder(color: AppTheme.roxoApp),
        enabledBorder: isSearch
            ? null
            : _outlineInputBorder(color: AppTheme.cinzaBordasNeutras),
      ),
      style: AppTheme.stylePadrao,
      cursorColor: AppTheme.roxoApp,
    );
  }

  //PEGA O VALOR DO TEXTFORM
  String getValue() {
    String value;
    value = ctrlTextFormField.text.toString();
    return value;
  }

  addListener(void Function() function) {
    ctrlTextFormField.addListener(function);
  }

  //ADICIONA UM VALOR AO TEXFORMFIELD(NÃO SE APLICA AO AUTOCOMPLETE)
  void setValue(String value) {
    ctrlTextFormField.text = value;
  }

  //LIMPA O CAMPO
  void clear() {
    ctrlTextFormField.text = "";
  }

//****************************************************************************
//!ICONE MONTADO PARA CONTROLAR O OBSCURETEXT
//****************************************************************************
  Widget iconVisible(bool isFocused, void Function()? obscureTextState) {
    return IconButton(
      icon: Icon(
        obscureText ? Icons.visibility_outlined : Icons.visibility_off_outlined,
        color: isFocused ? AppTheme.roxoApp : AppTheme.cinzaApp,
        size: 18,
      ),
      onPressed: () {
        obscureTextState!();
      },
    );
  }

//****************************************************************************
//!ESTILOS DE BORDAS DO TEXTFORMFIELD-- SEPARADOS AQUI PARA FACILITAÇÃO
//****************************************************************************
//BORDA PADRÃO UTILIZADA NOS TEXTFORMFIELD
  OutlineInputBorder _outlineInputBorder({
    double widthBorder = 1.0,
    Color color = AppTheme.roxoApp,
  }) {
    return OutlineInputBorder(
      borderRadius: BorderRadius.circular(8),
      borderSide: BorderSide(
        width: widthBorder,
        color: color,
      ),
    );
  }

  //PERMITE QUE VOCÊ PERSONALIZE A BORDER DO TEXTFORMFIELD DE UMA FORMA MAIS LIVRE
  OutlineInputBorder _outlineInputBorderPerson({
    double widthBorder = 2.0,
    Color color = AppTheme.roxoApp,
    double topLeft = 0,
    double topRight = 0,
    double bottomLeft = 0,
    double bottomRight = 0,
  }) {
    return OutlineInputBorder(
      borderRadius: BorderRadius.only(
        topLeft: Radius.circular(topLeft),
        topRight: Radius.circular(topRight),
        bottomLeft: Radius.circular(bottomLeft),
        bottomRight: Radius.circular(bottomRight),
      ),
      borderSide: BorderSide(
        width: widthBorder,
        color: color,
      ),
    );
  }
}

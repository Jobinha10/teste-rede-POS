import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:rflutter_alert/rflutter_alert.dart';
import 'package:wishes/theme.dart';

class ToastOrAlert {
  ToastOrAlert();
  //PODE SER CHAMADO PARA DEIXAR O BOTAO TRANSPARENTE
  static DialogButton botaoTransparente = DialogButton(
    child: null,
    color: Colors.transparent,
    splashColor: Colors.transparent,
    highlightColor: Colors.transparent,
    onPressed: null,
  );

  //RETORNA UM TOAST PARA USUARIO PADRÃO
  static toastPadrao(String msg,{bool erro = false}) {
    return Fluttertoast.showToast(
      msg: msg,
      toastLength: Toast.LENGTH_SHORT,
      gravity: ToastGravity.CENTER,
      timeInSecForIosWeb: 5,
      backgroundColor: erro?Colors.red :AppTheme.roxoApp,
      textColor: Colors.white,
      fontSize: 16.0,
    );
  }

  static alertWithContent({
    required String titulo,
    required BuildContext context,
    required Widget content,
    required List<DialogButton> buttons,
    String desc = "",
    TextStyle? titleStyle,
    bool isCloseButton = true,
    bool isOverlayTapDismiss = false,
    TextStyle? descStyle,
    AnimationType animationType: AnimationType.fromTop,
  }) {
    return Alert(
      context: context,
      closeIcon: Icon(
        Icons.close,
        color: AppTheme.roxoApp,
        size: 25,
      ),
      title: titulo,
      desc: desc,
      type: AlertType.none,
      buttons: buttons,
      content: content,
      style: AlertStyle(
        animationType: animationType,
        isCloseButton: isCloseButton,
        isOverlayTapDismiss: isOverlayTapDismiss,
        overlayColor: Colors.black87,
        animationDuration: const Duration(milliseconds: 250),
        backgroundColor: AppTheme.pretoFundoTxtff,
        alertBorder: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(10),
          side: BorderSide(color: AppTheme.roxoApp),
        ),
        titleStyle: titleStyle == null
            ? titleStyle = AppTheme.stylePadrao
            : titleStyle = titleStyle,
        descStyle: descStyle == null
            ? descStyle = AppTheme.stylePadrao
            : descStyle = descStyle,
      ),
    ).show();
  }
}

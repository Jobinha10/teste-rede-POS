import 'package:flutter/material.dart';
import 'package:wishes/Cadastro/cadastroScreen.dart';
import 'package:wishes/Encapsulados/textFormFieldPadrao.dart';
import 'package:wishes/Encapsulados/toastAlert.dart';
import 'package:wishes/Home/homePage.dart';
import 'package:wishes/Login/API/loginAPI.dart';
import 'package:wishes/theme.dart';
import 'package:wishes/session.dart' as session;

class LoginScreen extends StatefulWidget {
  const LoginScreen({Key? key}) : super(key: key);

  @override
  _LoginScreenState createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final _formKey = GlobalKey<FormState>();
  //UM ARRAY QUE É UM CONTROLLER PARA VERIFICAR SE TEXTFORMFIELD ESTÁ SELECIONADO
  List<bool> _isFocused = [false, false];
  //VARIAVÉS QUE HERDARAM O MEU ENCAPSULADO DO TEXTFORMFIELD
  //OBS: txf é uma abreviação de TextFormField esse prefixo ajuda na horientação.
  var txfLogin = TxffPadrao();
  var txfSenha = TxffPadrao();
  bool obscureText = true;
  @override
  void initState() {
    _isFocused[0] = true;
    _isFocused[1] = false;
    super.initState();
  }

  fazerLogin() async {
    ToastOrAlert.toastPadrao("Bem vindo! ");
    //validação do form
    bool formOk = _formKey.currentState!.validate();
    if (!formOk) {
      return;
    }
    var urlResponse = await LoginAPI().login(
      txfLogin.getValue(),
      txfSenha.getValue(),
    );
    // VERIFICA O RETORNO DA URL
    if (urlResponse) {
      ToastOrAlert.toastPadrao("Bem vindo!");
      session.usuarioLogado.email = txfLogin.getValue();
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(
          builder: (context) => HomeScreen(),
        ),
      );
    }else{
      ToastOrAlert.toastPadrao("E-mail ou senha incorretos.",erro: true);
    }
  }

  @override
  Widget build(BuildContext context) {
    //!APENAS PARA FINS ESTETICOS
    //em vez de escrever toda vez o widget SizedBox é só apenas chamar o size()
    //h para height ou seja um espaço vertical
    //w para width ou seja um espaço horizontal
    size({double h = 0, double w = 0}) {
      return SizedBox(
        height: h,
        width: w,
      );
    }

    //**********************************************************************
    //!ESTRUTURA DOS OBJETOS NA TELA
    //!AQUI VOCÊ PODE SEPARADAMENTE LIDAR CADA ITEM DA SUA ÁRVORE DE WIDGETS
    //**********************************************************************
    final tituloAbaixoDaLogo = Text(
      "Wishes",
      style: AppTheme.styleTitulos,
    );
    final subTituloAbaixoDoTexto = Text(
      "O melhor organizador para sua lista de desejos.",
      style: AppTheme.stylePadrao,
    );
    final campoLogin = Padding(
      padding: EdgeInsets.only(left: 16.0, right: 16.0),
      child: txfLogin.txfBordaPersonalizada(
        "Login",
        testMask: "email",
        keyboardType: TextInputType.text,
        isFocused: _isFocused[0],
        prefixIcon: AppTheme.userIcon(
          color: _isFocused[0] ? AppTheme.roxoApp : AppTheme.cinzaApp,
        ),
        topLeft: 8,
        topRight: 8,
        onTap: () {
          setState(() {
            _isFocused[0] = true;
            _isFocused[1] = false;
          });
        },
      ),
    );
    final campoSenha = Padding(
      padding: EdgeInsets.only(left: 16.0, right: 16.0),
      child: txfSenha.txfBordaPersonalizada(
        "Senha",
        testMask: "obrigatorio",
        keyboardType: TextInputType.text,
        isFocused: _isFocused[1],
        prefixIcon: AppTheme.lockIcon(
          color: _isFocused[1] ? AppTheme.roxoApp : AppTheme.cinzaApp,
        ),
        useObscureText: true,
        obscureTextState: () {
          setState(() {
            txfSenha.obscureText = !txfSenha.obscureText;
          });
        },
        bottomLeft: 8,
        bottomRight: 8,
        onTap: () {
          setState(() {
            _isFocused[0] = false;
            _isFocused[1] = true;
          });
        },
      ),
    );
    final campoRecuperarSenha = Padding(
      padding: EdgeInsets.only(right: 16.0),
      child: Align(
        alignment: Alignment.centerRight,
        child: Text(
          "recuperar a senha?",
          style: AppTheme.stylePadraoRoxo,
        ),
      ),
    );
    final botaoEntrarApp = AppTheme.botaoPadrao(
      texto: "Entrar",
      onTap: () => fazerLogin(),
    );
    final textoCadastro = GestureDetector(
      child: RichText(
        text: TextSpan(
          children: [
            TextSpan(
              text: "Ainda não tem uma conta? ",
              style: AppTheme.stylePadrao,
            ),
            TextSpan(
              text: "Cadastre-se clicando aqui",
              style: AppTheme.stylePerson(
                color: Colors.white,
                txtDecoration: TextDecoration.underline,
              ),
            ),
          ],
        ),
      ),
      onTap: () => Navigator.push(
        context,
        MaterialPageRoute(
          builder: (context) => CadastroScreen(),
        ),
      ),
    );
    //***************************************************************
    //!ESTRUTURA DA TELA
    //!AQUI VOCÊ PODE LIDAR COM A ESTRUTURA SUA ÁRVORE DE WIDGETS
    //***************************************************************
    return Scaffold(
      body: Container(
        decoration: BoxDecoration(
          gradient: AppTheme.gradientPadrao,
        ),
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  AppTheme.logo,
                  size(h: 12.94),
                  tituloAbaixoDaLogo,
                  size(h: 5),
                  subTituloAbaixoDoTexto,
                  size(h: 31),
                  Form(
                    key: _formKey,
                    child: Column(
                      children: [
                        campoLogin,
                        campoSenha,
                        size(h: 10),
                        campoRecuperarSenha,
                      ],
                    ),
                  ),
                  size(h: 62),
                  botaoEntrarApp
                ],
              ),
              textoCadastro
            ],
          ),
        ),
      ),
    );
  }
}

import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:wishes/Cadastro/API/cadastroAPI.dart';
import 'package:wishes/Encapsulados/textFormFieldPadrao.dart';
import 'package:wishes/Encapsulados/toastAlert.dart';
import 'package:wishes/theme.dart';
import 'package:wishes/session.dart' as session;

class CadastroScreen extends StatefulWidget {
  const CadastroScreen({Key? key}) : super(key: key);

  @override
  State<CadastroScreen> createState() => _CadastroScreenState();
}

class _CadastroScreenState extends State<CadastroScreen> {
  //UM ARRAY QUE É UM CONTROLLER PARA VERIFICAR SE TEXTFORMFIELD
  //ESTÁ SELECIONADO
  List<bool> _isFocused = [false, false, false];
  final _formKey = GlobalKey<FormState>();
  //VARIAVÉS QUE HERDARAM O MEU ENCAPSULADO DO TEXTFORMFIELD
  //OBS1: txf é uma abreviação de TextFormField esse prefixo ajuda na horientação.
  //OBS2: a variavél que herda essa classe ela tem tanto o widget como as funções do controller.
  var txfNomeCompleto = TxffPadrao();
  var txfEmail = TxffPadrao();
  var txfSenha = TxffPadrao();

  @override
  void initState() {
    _isFocused[0] = true;
    super.initState();
  }

  cadastrarUsuario() async {
    var prefs = await SharedPreferences.getInstance();

    //validação do form
    bool? formOk = _formKey.currentState?.validate();
    if (!formOk!) {
      return;
    }

    var urlResponse = await CadastroAPI().cadastrar(
      txfEmail.getValue(),
      txfSenha.getValue(),
      txfNomeCompleto.getValue(),
    );

    // VERIFICA O RETORNO DA URL
    if (urlResponse) {
        
      ToastOrAlert.toastPadrao("Cadastro realizado com sucesso!");

      session.usuarioLogado.nome = txfNomeCompleto.getValue();
      //SALVA NO CACHE AS VARIAVEIS NECESSARIOS PARA MANTER O NOME DO USUARIO
      prefs.setString("nome", session.usuarioLogado.nome);

      Navigator.pop(context);
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
    final campoRegistrarNome = Padding(
      padding: EdgeInsets.only(left: 16.0, right: 16.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            "Nome completo",
            style: AppTheme.stylePadraoBranco,
          ),
          size(h: 3),
          txfNomeCompleto.txfPadrao(
            "Nome completo",
            isFocused: _isFocused[0],
            keyboardType: TextInputType.name,
            onTap: () {
              setState(() {
                _isFocused[0] = true;
                _isFocused[1] = false;
                _isFocused[2] = false;
              });
            },
          ),
        ],
      ),
    );

    final campoRegistrarEmail = Padding(
      padding: EdgeInsets.only(left: 16.0, right: 16.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text("E-mail", style: AppTheme.stylePadraoBranco),
          size(h: 3),
          txfEmail.txfPadrao(
            "E-mail",
            keyboardType: TextInputType.emailAddress,
            isFocused: _isFocused[1],
            onTap: () {
              setState(() {
                _isFocused[0] = false;
                _isFocused[1] = true;
                _isFocused[2] = false;
              });
            },
          ),
        ],
      ),
    );
    final campoRegistrarSenha = Padding(
      padding: EdgeInsets.only(left: 16.0, right: 16.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text("Senha", style: AppTheme.stylePadraoBranco),
          size(h: 3),
          txfSenha.txfPadrao(
            "Senha",
            keyboardType: TextInputType.visiblePassword,
            isFocused: _isFocused[2],
            onTap: () {
              setState(() {
                _isFocused[0] = false;
                _isFocused[1] = false;
                _isFocused[2] = true;
              });
            },
            useObscureText: true,
            obscureTextState: () {
              setState(() {
                txfSenha.obscureText = !txfSenha.obscureText;
              });
            },
          ),
        ],
      ),
    );
    final botaoRealizarCadastro = Padding(
      padding: const EdgeInsets.only(bottom: 15),
      child: AppTheme.botaoPadrao(
        texto: "Cadastrar",
        onTap: () => cadastrarUsuario(),
      ),
    );
    //***************************************************************
    //!ESTRUTURA DA TELA
    //!AQUI VOCÊ PODE LIDAR COM A ESTRUTURA SUA ÁRVORE DE WIDGETS
    //***************************************************************
    return Scaffold(
      extendBodyBehindAppBar: true,
      appBar: AppBar(
        title: Text("Cadastrar"),
        centerTitle: true,
        backgroundColor: Colors.transparent,
        elevation: 1,
      ),
      body: Container(
        decoration: BoxDecoration(gradient: AppTheme.gradientPadrao),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Padding(
              padding: const EdgeInsets.only(top: 140),
              child: Form(
                key: _formKey,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    campoRegistrarNome,
                    size(h: 34),
                    campoRegistrarEmail,
                    size(h: 34),
                    campoRegistrarSenha
                  ],
                ),
              ),
            ),
            botaoRealizarCadastro
          ],
        ),
      ),
    );
  }
}

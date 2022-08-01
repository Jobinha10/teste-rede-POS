import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:rflutter_alert/rflutter_alert.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:wishes/Classes/classUtil.dart';
import 'package:wishes/Encapsulados/textFormFieldPadrao.dart';
import 'package:wishes/Encapsulados/toastAlert.dart';
import 'package:wishes/Home/API/homeScreenAPI.dart';
import 'package:wishes/Home/JSON/produtosDesejadosJSON.dart';
import 'package:wishes/theme.dart';
import 'package:wishes/session.dart' as session;

class HomeScreen extends StatefulWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  //VARIAVÉS QUE HERDARAM O MEU ENCAPSULADO DO TEXTFORMFIELD
  //OBS1: txf é uma abreviação de TextFormField esse prefixo ajuda na horientação.
  //OBS2: a variavél que herda essa classe ela tem tanto o widget como as funções do controller.
  var txfPesquisarItem = TxffPadrao();
  int quantidadeItens = 0;
  bool _habilitarPesquisa = false;
  int _lengthLista = 0;
  bool _confimedDismiss = false;
  List<ProdutosDesejadosJSON> listaItensDesejados = [
    // ProdutosDesejadosJSON(
    //   nomeProduto: "Alexa",
    //   descricao: "A da 4 geração",
    //   mediaValor: "400,00",
    //   data: "31/08/2022",
    //   linkProduto: "https://www.google.com/",
    // ),
    // ProdutosDesejadosJSON(
    //   nomeProduto: "Flange relax cadeira gamer",
    //   descricao: "Tem que ser de 27 cm altura e base 30 cm ",
    //   mediaValor: "150,00",
    //   data: "31/08/2022",
    //   linkProduto: "https://www.google.com/",
    // ),
    // ProdutosDesejadosJSON(
    //   nomeProduto: "Pulseira de prata",
    //   descricao: "Tem que ser grossa viu",
    //   mediaValor: "600,00",
    //   data: "31/08/2022",
    //   linkProduto: "https://www.google.com/",
    // ),
  ];
  List<ProdutosDesejadosJSON> listaItensFiltrada = [];

  @override
  void initState() {
    HomeScreenAPI().getValue("quantidadeItens").then((value) {
      setState(() {
        quantidadeItens = ClassUtil().stgToInt(value);
      });
    });
    _listarItens();
    super.initState();
  }

  _listarItens() {
    HomeScreenAPI().getAllItens().then((lista) {
      setState(() {
        listaItensDesejados = lista;
        listaItensFiltrada = lista;
        _lengthLista = listaItensDesejados.length;
      });
    });
  }

  alterarValues(
    int index, {
    required String nomeProduto,
    required String descricaoProduto,
    required String mediaValorProduto,
    required String linkProduto,
  }) async {
    String id = listaItensDesejados[index].numeroProduto.toString();
    //CRIO O VALOR DO NOME DO PRODUTO
    String nomeProdutoChave = "nomeProduto" + id;
    await HomeScreenAPI().setValue(nomeProdutoChave, nomeProduto);
    // CRIO O VALOR DA DESC DO PRODUTO
    String descProdutoChave = "descricaoProduto" + id;
    await HomeScreenAPI().setValue(descProdutoChave, descricaoProduto);
    //  CRIO O VALOR DA MEDIA DE VALOR DO PRODUTO
    String valorMedioProdutoChave = "mediaValorProduto" + id;
    await HomeScreenAPI().setValue(valorMedioProdutoChave, mediaValorProduto);
    //  CRIO O VALOR DA MEDIA DE VALOR DO PRODUTO`
    String dataProdutoChave = "dataProduto" + id;
    await HomeScreenAPI().setValue(
        dataProdutoChave, ClassUtil().formatarData(DateTime.now().toString()));
    //  CRIO O VALOR PARA O LINK DO PRODUTO
    String linkProdutoChave = "linkProduto" + id;
    await HomeScreenAPI().setValue(linkProdutoChave, linkProduto);
  }

  setvalues({
    required String nomeProduto,
    required String descricaoProduto,
    required String mediaValorProduto,
    required String linkProduto,
  }) async {
    quantidadeItens = quantidadeItens + 1;
    //ATUALIZA A QUANTIDADE DE ITENS
    await HomeScreenAPI()
        .setValue("quantidadeItens", quantidadeItens.toString());
    //CRIO O VALOR DO NOME DO PRODUTO
    String nomeProdutoChave = "nomeProduto" + quantidadeItens.toString();
    await HomeScreenAPI().setValue(nomeProdutoChave, nomeProduto);
    // CRIO O VALOR DA DESC DO PRODUTO
    String descProdutoChave = "descricaoProduto" + quantidadeItens.toString();
    await HomeScreenAPI().setValue(descProdutoChave, descricaoProduto);
    //  CRIO O VALOR DA MEDIA DE VALOR DO PRODUTO
    String valorMedioProdutoChave =
        "mediaValorProduto" + quantidadeItens.toString();
    await HomeScreenAPI().setValue(valorMedioProdutoChave, mediaValorProduto);
    //  CRIO O VALOR DA MEDIA DE VALOR DO PRODUTO`
    String dataProdutoChave = "dataProduto" + quantidadeItens.toString();
    await HomeScreenAPI().setValue(
        dataProdutoChave, ClassUtil().formatarData(DateTime.now().toString()));
    //  CRIO O VALOR PARA O LINK DO PRODUTO
    String linkProdutoChave = "linkProduto" + quantidadeItens.toString();
    await HomeScreenAPI().setValue(linkProdutoChave, linkProduto);
  }

  removeValues(int index) async {
    //PEGA O ID
    String id = listaItensDesejados[index].numeroProduto.toString();
    //ATUALIZA A QUANTIDADE DE ITENS QUE O USUARIO DESEJA
    quantidadeItens = quantidadeItens - 1;
    //ATUALIZA A QUANTIDADE DE ITENS
    await HomeScreenAPI()
        .setValue("quantidadeItens", quantidadeItens.toString());
    //DELETA O ITEM SELECIONADO
    //CRIO O VALOR DO NOME DO PRODUTO
    String nomeProdutoChave = "nomeProduto" + id;
    await HomeScreenAPI().deleteValue(nomeProdutoChave);
    // CRIO O VALOR DA DESC DO PRODUTO
    String descProdutoChave = "descricaoProduto" + id;
    await HomeScreenAPI().deleteValue(descProdutoChave);
    //  CRIO O VALOR DA MEDIA DE VALOR DO PRODUTO
    String valorMedioProdutoChave = "mediaValorProduto" + id;
    await HomeScreenAPI().deleteValue(valorMedioProdutoChave);
    //  CRIO O VALOR DA MEDIA DE VALOR DO PRODUTO`
    String dataProdutoChave = "dataProduto" + id;
    await HomeScreenAPI().deleteValue(dataProdutoChave);
    //  CRIO O VALOR PARA O LINK DO PRODUTO
    String linkProdutoChave = "linkProduto" + id;
    await HomeScreenAPI().deleteValue(linkProdutoChave);
  }

  Future<bool> removerItem(int index) async {
    String nomeProduto = listaItensFiltrada[index].nomeProduto!;
    await ToastOrAlert.alertWithContent(
      context: context,
      titulo: 'Tem certeza?',
      desc: "Deseja remover $nomeProduto da sua lista de desejos ?",
      content: Container(),
      buttons: [
        DialogButton(
          child: Center(
              child: Text(
            "Sim",
            style: AppTheme.stylePadraoBranco,
          )),
          color: AppTheme.roxoApp,
          onPressed: () async {
            await removeValues(index);
            ToastOrAlert.toastPadrao("Item removido com sucesso");
            Navigator.pop(context, true);
            setState(() {
              listaItensDesejados.removeAt(index);
              _lengthLista = listaItensDesejados.length;
              listaItensFiltrada = listaItensDesejados;
              _confimedDismiss = true;
            });
          },
        ),
        DialogButton(
          child: Center(
              child: Text(
            "Não",
            style: AppTheme.stylePadraoBranco,
          )),
          color: AppTheme.roxoApp,
          onPressed: () {
            Navigator.pop(context, false);
            setState(() {
              _confimedDismiss = false;
            });
          },
        ),
      ],
    );
    return _confimedDismiss;
  }

  acessarLink(String link) async {
    Uri url = Uri.parse(link);
    try {
      await launchUrl(
        url,
        mode: LaunchMode.externalApplication,
      );
    } catch (e) {
      ToastOrAlert.toastPadrao(
          "Não foi possível abrir a url, cheque e tente novamente.",
          erro: true);
    }
  }

  inspecionarItem(int index) {
    var txfNomeProduto = TxffPadrao();
    var txfDescProduto = TxffPadrao();
    var txfValorMedioProduto = TxffPadrao();
    var txfLinkProduto = TxffPadrao();

    List<bool> isFocused = [false, false, false, false];

    setState(() {
      txfNomeProduto.setValue(listaItensFiltrada[index].nomeProduto!);
      txfDescProduto.setValue(listaItensFiltrada[index].descricao!);
      txfValorMedioProduto.setValue(listaItensFiltrada[index].mediaValor!);
      txfLinkProduto.setValue(listaItensFiltrada[index].linkProduto!);
    });

    return ToastOrAlert.alertWithContent(
      context: context,
      titulo: listaItensFiltrada[index].nomeProduto! +
          " salvo em: " +
          listaItensFiltrada[index].data!,
      content: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          txfNomeProduto.txfPadrao(
            "Nome",
            testMask: "nome",
            keyboardType: TextInputType.name,
            isFocused: isFocused[0],
            onTap: () {
              setState(() {
                isFocused[0] = true;
                isFocused[1] = false;
                isFocused[2] = false;
              });
            },
          ),
          SizedBox(height: 10),
          txfDescProduto.txfPadrao(
            "Descrição do produto",
            testMask: "nome",
            keyboardType: TextInputType.name,
            isFocused: isFocused[1],
            maxLines: 3,
            maxLengthEnforcement: MaxLengthEnforcement.enforced,
            onTap: () {
              setState(() {
                isFocused[1] = true;
                isFocused[0] = false;
                isFocused[2] = false;
              });
            },
          ),
          SizedBox(height: 10),
          txfValorMedioProduto.txfPadrao(
            "Média de valor",
            testMask: "cash",
            keyboardType: TextInputType.number,
            isFocused: isFocused[2],
            onTap: () {
              setState(() {
                isFocused[2] = true;
                isFocused[1] = false;
                isFocused[2] = false;
              });
            },
          ),
          SizedBox(height: 10),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Container(
                width: 170,
                child: txfLinkProduto.txfPadrao(
                  "Link",
                  testMask: "",
                  keyboardType: TextInputType.url,
                  isFocused: isFocused[3],
                  onTap: () {
                    setState(() {
                      isFocused[3] = true;
                      isFocused[2] = false;
                      isFocused[1] = false;
                      isFocused[0] = false;
                    });
                  },
                ),
              ),
              InkWell(
                child: Container(
                  width: 35,
                  height: 30,
                  decoration: BoxDecoration(
                    color: AppTheme.roxoApp,
                    borderRadius: BorderRadius.circular(10),
                    boxShadow: [BoxShadow(color: AppTheme.roxoApp)],
                  ),
                  child: Center(
                    child: Icon(
                      Icons.link,
                      color: Colors.white,
                    ),
                  ),
                ),
                onTap: () => acessarLink(txfLinkProduto.getValue()),
              ),
            ],
          ),
        ],
      ),
      buttons: [
        DialogButton(
          color: AppTheme.roxoApp,
          radius: BorderRadius.circular(10),
          child: Center(
            child: Text("Atualizar", style: AppTheme.stylePadraoBranco),
          ),
          onPressed: () async {
            await alterarValues(
              index,
              descricaoProduto: txfDescProduto.getValue(),
              mediaValorProduto: txfValorMedioProduto.getValue(),
              nomeProduto: txfNomeProduto.getValue(),
              linkProduto: txfLinkProduto.getValue(),
            );
            Navigator.pop(context);
            ToastOrAlert.toastPadrao("Item alterado com sucesso.");
            _listarItens();
          },
        ),
      ],
      animationType: AnimationType.fromBottom,
    );
  }

  addNovoItem() {
    var txfNomeProduto = TxffPadrao();
    var txfDescProduto = TxffPadrao();
    var txfValorMedioProduto = TxffPadrao();
    var txfLinkProduto = TxffPadrao();
    List<bool> isFocused = [false, false, false];

    return ToastOrAlert.alertWithContent(
      context: context,
      titulo: "Novo produto",
      content: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            "Nome",
            style: AppTheme.stylePadraoBranco,
          ),
          SizedBox(height: 3),
          txfNomeProduto.txfPadrao(
            "Nome",
            testMask: "nome",
            keyboardType: TextInputType.name,
            isFocused: isFocused[0],
            onTap: () {
              setState(() {
                isFocused[0] = true;
                isFocused[1] = false;
                isFocused[2] = false;
              });
            },
          ),
          SizedBox(height: 10),
          Text("Descrição do produto", style: AppTheme.stylePadraoBranco),
          SizedBox(height: 3),
          txfDescProduto.txfPadrao(
            "Descrição do produto",
            testMask: "nome",
            keyboardType: TextInputType.name,
            isFocused: isFocused[1],
            maxLines: 3,
            maxLengthEnforcement: MaxLengthEnforcement.enforced,
            onTap: () {
              setState(() {
                isFocused[1] = true;
                isFocused[0] = false;
                isFocused[2] = false;
              });
            },
          ),
          SizedBox(height: 10),
          Text("Média de valor", style: AppTheme.stylePadraoBranco),
          SizedBox(height: 3),
          txfValorMedioProduto.txfPadrao(
            "Média de valor",
            testMask: "cash",
            keyboardType: TextInputType.number,
            isFocused: isFocused[2],
            onTap: () {
              setState(() {
                isFocused[2] = true;
                isFocused[1] = false;
                isFocused[2] = false;
              });
            },
          ),
          SizedBox(height: 10),
          Text("Link do produto", style: AppTheme.stylePadraoBranco),
          SizedBox(height: 3),
          txfLinkProduto.txfPadrao(
            "Link",
            testMask: "link",
            keyboardType: TextInputType.url,
            isFocused: isFocused[2],
            onTap: () {
              setState(() {
                isFocused[2] = true;
                isFocused[1] = false;
                isFocused[2] = false;
              });
            },
          ),
        ],
      ),
      buttons: [
        DialogButton(
          color: AppTheme.roxoApp,
          radius: BorderRadius.circular(10),
          child: Center(
            child: Text("Adicionar", style: AppTheme.stylePadraoBranco),
          ),
          onPressed: () async {
            await setvalues(
              descricaoProduto: txfDescProduto.getValue(),
              mediaValorProduto: txfValorMedioProduto.getValue(),
              nomeProduto: txfNomeProduto.getValue(),
              linkProduto: txfLinkProduto.getValue(),
            );
            Navigator.pop(context);
            ToastOrAlert.toastPadrao("Item adicionado com sucesso");
            _listarItens();
          },
        ),
      ],
      animationType: AnimationType.fromBottom,
    );
  }

  @override
  Widget build(BuildContext context) {
    //**********************************************************************
    //!ITENS PARA REDUZIR CODIGO DA ÁRVORE DE WIDGETS
    //**********************************************************************
    //em vez de escrever toda vez o widget SizedBox é só apenas chamar o size()
    //h para height ou seja um espaço vertical
    //w para width ou seja um espaço horizontal
    size({double h = 0, double w = 0}) {
      return SizedBox(
        height: h,
        width: w,
      );
    }

    Widget styleListaItens(int index) {
      return Dismissible(
        key: Key(listaItensFiltrada[index].nomeProduto!),
        confirmDismiss: (direction) => removerItem(index),
        child: Container(
          height: 120,
          decoration: BoxDecoration(
            color: AppTheme.pretoFundoTxtff,
            border: Border.all(color: AppTheme.roxoApp, width: 1),
            borderRadius: BorderRadius.circular(10),
          ),
          child: Padding(
            padding: const EdgeInsets.all(10),
            child: InkWell(
              onTap: () => inspecionarItem(index),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    listaItensFiltrada[index].nomeProduto!,
                    maxLines: 1,
                    style: AppTheme.stylePerson(
                      size: 16,
                      color: Colors.white,
                    ),
                  ),
                  size(h: 5),
                  Padding(
                    padding: const EdgeInsets.only(left: 4),
                    child: Text(
                      listaItensFiltrada[index].descricao!,
                      maxLines: 1,
                      style: AppTheme.stylePerson(
                        size: 14,
                        color: Colors.white54,
                      ),
                    ),
                  ),
                  size(h: 5),
                  Padding(
                    padding: const EdgeInsets.only(left: 4),
                    child: Text(
                      "Média de valor: R\$ " +
                          listaItensFiltrada[index].mediaValor!,
                      style: AppTheme.stylePerson(
                        size: 14,
                        color: Colors.white54,
                      ),
                    ),
                  ),
                  size(h: 15),
                  Padding(
                    padding: const EdgeInsets.only(left: 4),
                    child: Text(
                      listaItensFiltrada[index].data!,
                      style: AppTheme.stylePerson(
                        size: 14,
                        color: Colors.white54,
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      );
    }

    //**********************************************************************
    //!ESTRUTURA DOS OBJETOS NA TELA
    //!AQUI VOCÊ PODE SEPARADAMENTE LIDAR CADA ITEM DA SUA ÁRVORE DE WIDGETS
    //**********************************************************************
    final floatingActionButton = FloatingActionButton(
      child: Icon(Icons.add),
      backgroundColor: AppTheme.roxoApp,
      onPressed: () => addNovoItem(),
    );
    txfPesquisarItem.addListener(() {
      setState(() {
        //Valida - se não há texto para pesquisar nada a fazer aqui !
        if (txfPesquisarItem.getValue().trim() == "") {
          _lengthLista = listaItensDesejados.length;
          listaItensFiltrada = listaItensDesejados;
          return;
        }
        // Filtra
        listaItensFiltrada = listaItensDesejados
            .where((value) => value.nomeProduto!.toLowerCase().contains(
                  txfPesquisarItem.getValue().toLowerCase(),
                ))
            .toList();

        _lengthLista = listaItensFiltrada.length;
      });
    });
    final pesquisarItem = txfPesquisarItem.txfPadrao(
      "",
      testMask: "",
      keyboardType: TextInputType.text,
      isFocused: true,
      onTap: () {},
      isSearch: true,
    );
    //FOI COLOCADO AQUI EM VEZ DE UMA PROPRIEDADE DO SCAFFOLD PARA ELE MELHOR SE ADEQUAR NA ÁRVORE
    //POIS A PROPRIEDADE extendBodyBehindAppBar: true ATENDE AO FATO DE QUE ELE VAI TER A COR DO GRADIENTE
    //PORÉM O TORNA INTANGÍVEL E FORA DA ÁRVORE COISA QUE PREJUDICA A ESTRUTURA RESPONSIVA.
    final appBar = AppBar(
      title: _habilitarPesquisa
          ? pesquisarItem
          : Text(
              "Seus desejados",
              style: AppTheme.stylePerson(
                size: 22,
                color: Colors.white,
              ),
            ),
      centerTitle: true,
      backgroundColor: Colors.transparent,
      elevation: 0.5,
      actions: [
        Padding(
          padding: const EdgeInsets.all(8.0),
          child: IconButton(
            icon: Icon(
              _habilitarPesquisa ? Icons.close : Icons.search,
              color: Colors.white,
            ),
            splashRadius: 0.1,
            onPressed: () {
              setState(() {
                // txfPesquisarItem.clear();
                txfPesquisarItem.setValue("");
                _lengthLista = listaItensDesejados.length;
                listaItensFiltrada = listaItensDesejados;
                _habilitarPesquisa = !_habilitarPesquisa;
              });
            },
          ),
        ),
      ],
    );
    final listaDesejados = Expanded(
      child: Container(
        height: 150,
        child: Column(
          children: [
            Expanded(
              child: Padding(
                padding: const EdgeInsets.only(left: 8, right: 8),
                child: ListView.separated(
                  separatorBuilder: (context, index) {
                    return size(h: 15);
                  },
                  itemCount: _lengthLista,
                  itemBuilder: (context, index) {
                    return styleListaItens(index);
                  },
                ),
              ),
            ),
          ],
        ),
      ),
    );
    final drawer = Drawer(
      child: Container(
        decoration: BoxDecoration(gradient: AppTheme.gradientPadrao),
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              size(h: 42),
              CircleAvatar(
                backgroundColor: AppTheme.roxoApp,
                radius: 50,
                child: Text(
                  session.usuarioLogado.nome ==  ""?"W": session.usuarioLogado.nome.substring(0, 1),
                  style: AppTheme.styleTitulos,
                ),
              ),
              size(h: 5),
              Text(
                session.usuarioLogado.nome.toUpperCase(),
                style: AppTheme.styleTitulos2,
                maxLines: 1,
              ),
              size(h: 15),
              Text(
                session.usuarioLogado.email,
                style: AppTheme.stylePadraoBranco,
              ),
              size(h: 15),
              Text(
                "Seus desejados: " + quantidadeItens.toString(),
                style: AppTheme.stylePadraoBranco,
              ),
            ],
          ),
        ),
      ),
    );
    //**********************************************************************
    //!ESTRUTURA DA TELA
    //!AQUI VOCÊ PODE LIDAR COM A ESTRUTURA SUA ÁRVORE DE WIDGETS
    //**********************************************************************
    return Scaffold(
      drawer: drawer,
      floatingActionButton: floatingActionButton,
      floatingActionButtonLocation: FloatingActionButtonLocation.miniEndFloat,
      //appBar: appBar,//SUBUSTITUIDO POR OUTRA FORMA DE INTRODUZIR O APPBAR
      body: Container(
        decoration: BoxDecoration(gradient: AppTheme.gradientPadrao),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            appBar,
            listaDesejados,
          ],
        ),
      ),
    );
  }
}

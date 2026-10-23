import 'package:flutter/material.dart';
import '../data/rates_repository.dart';

class Home extends StatefulWidget {
  final RatesRepository? repository;
  const Home({super.key, this.repository});
  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<Home> {
  //controlador
  final realController = TextEditingController();
  final dolarController = TextEditingController();
  final euroController = TextEditingController();

  late ExchangeRates currentRates;
  late final RatesRepository repository =
      widget.repository ?? RatesRepository();
  late final Future<ExchangeRates> rates = repository.fetch();

  @override
  void dispose() {
    if (widget.repository == null) repository.close();
    realController.dispose();
    dolarController.dispose();
    euroController.dispose();
    super.dispose();
  }

  //resetar os campos
  void _clearAll() {
    realController.text = "";
    dolarController.text = "";
    euroController.text = "";
  }

  //declarando as funçoes pra alterar o valor
  void _realChanged(String text) {
    if (text.isEmpty) {
      _clearAll();
      return;
    }
    final real = double.tryParse(text.replaceAll(',', '.'));
    if (real == null || !real.isFinite) return; //VALOR EM REAL
    /*Conversao*/
    dolarController.text =
        (currentRates.convert(real, Currency.real, Currency.dollar))
            .toStringAsFixed(2 /*dois digitos pos a virgula*/);
    euroController.text =
        (currentRates.convert(real, Currency.real, Currency.euro))
            .toStringAsFixed(2);
  }

  void _dolarChanged(String text) {
    if (text.isEmpty) {
      _clearAll();
      return;
    }
    final dolar = double.tryParse(text.replaceAll(',', '.'));
    if (dolar == null || !dolar.isFinite) return;
    /*Conversao*/
    realController.text =
        (currentRates.convert(dolar, Currency.dollar, Currency.real))
            .toStringAsFixed(2);
    euroController.text =
        (currentRates.convert(dolar, Currency.dollar, Currency.euro))
            .toStringAsFixed(
                2); //convertendo pra reais e depois dividindo pelo euro
  }

  void _euroChanged(String text) {
    if (text.isEmpty) {
      _clearAll();
      return;
    }
    final euro = double.tryParse(text.replaceAll(',', '.'));
    if (euro == null || !euro.isFinite) return;
    realController.text =
        (currentRates.convert(euro, Currency.euro, Currency.real))
            .toStringAsFixed(2);
    dolarController.text =
        (currentRates.convert(euro, Currency.euro, Currency.dollar))
            .toStringAsFixed(
                2); //conventendo o valor por reias e dividir pelo dolar
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      //barra de navegaçao
      backgroundColor: Colors.black,
      appBar: AppBar(
        title: Text("\$Convensor de Moedas\$"),
        backgroundColor: Colors.amber,
        centerTitle: true,
      ),
      body: FutureBuilder<ExchangeRates>(
        //json retorna um map
        future: rates, //socilicita os dados e retorna
        builder: (context, snapshot) {
          //observa qual o status da conexao
          switch (snapshot.connectionState) {
            //nao esta conectando em nada
            case ConnectionState.none:
            case ConnectionState.waiting: //Esperando receber um dado
              return Center(
                  child: Text(
                "Carregando Dados...",
                style: TextStyle(
                  color: Colors.amber,
                  fontSize: 25.0,
                ),
                textAlign: TextAlign.center,
              ));
            default:
              //vendo se obteve algo erro
              if (snapshot.hasError) {
                return Center(
                    child: Text(
                  "Erro ao Carregar Dados",
                  style: TextStyle(
                    color: Colors.amber,
                    fontSize: 25.0,
                  ),
                  textAlign: TextAlign.center,
                ));
              } else {
                currentRates = snapshot.data!;

                return SingleChildScrollView(
                  //colocando uma borda
                  padding: EdgeInsets.all(10.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment
                        .stretch, //alinhando a coluna no centro
                    children: <Widget>[
                      Icon(Icons.monetization_on,
                          size: 150.0, color: Colors.amber),
                      buildTextField(
                          "Reais", "R\$", realController, _realChanged),
                      Divider(), //dando um espaço entre os blocos de texto
                      buildTextField(
                          "Dolares", "US\$", dolarController, _dolarChanged),
                      Divider(), //dando um espaço entre os blocos de texto
                      buildTextField(
                          "Euros", "€", euroController, _euroChanged),
                    ],
                  ),
                );
              }
          }
        },
      ),
    );
  }
}

//retorna um widget
Widget buildTextField(String label, String prefixo, TextEditingController c,
    ValueChanged<String> f) {
  return TextField(
    controller: c,
    //bloco de texto
    decoration: InputDecoration(
      labelText: label,
      labelStyle: TextStyle(color: Colors.amber),
      //colocando uma borda em todo o campo
      border: OutlineInputBorder(),
      prefixText: prefixo,
    ),
    style: TextStyle(
        //mudar a cor do texto e aumentando
        color: Colors.amber,
        fontSize: 25.0),
    onChanged: f, //qualquer alteraçao no campo ele ja chama a funçao
    keyboardType: TextInputType.number, //so colocar numeros
  );
}

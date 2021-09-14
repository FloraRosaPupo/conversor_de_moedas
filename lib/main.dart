import 'package:flutter/material.dart';

import 'package:http/http.dart' as http;
import 'dart:async';
import 'dart:convert';

const request = "https://api.hgbrasil.com/finance?format=json&key=1f3ee023";

void main() async {
  //requisiçao assincrona
  http.Response response = await http.get(request); //esperar os dados chegarem
  print(json.decode(response.body)["results"]["currencies"]["USD"]);

  runApp(MaterialApp(
      home: Home(),
      //adicionando um tema
      theme: ThemeData(
          hintColor: Colors.amber,
          primaryColor: Colors.white,
          inputDecorationTheme: InputDecorationTheme(
            enabledBorder:
                OutlineInputBorder(borderSide: BorderSide(color: Colors.white)),
            focusedBorder:
                OutlineInputBorder(borderSide: BorderSide(color: Colors.amber)),
            hintStyle: TextStyle(color: Colors.amber),
          ))));
}

//dado futuro que restorna um map
Future<Map> getData() async {
  //requisiçao assincrona
  http.Response response = await http
      .get(request); //esperar os dados chegarem e armazenar no response

  return json
      .decode(response.body); //pegar de um arquivo json e retornar um map
}

class Home extends StatefulWidget {
  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<Home> {
  //controlador
  final realController = TextEditingController();
  final dolarController = TextEditingController();
  final euroController = TextEditingController();

  double dolar;
  double euro;

  //resetar os campos 
  void _clearAll(){
    realController.text = "";
    dolarController.text = "";
    euroController.text = "";
  }
  //declarando as funçoes pra alterar o valor
  void _realChanged(String text) {
    if(text.isEmpty) {
      _clearAll();
      return;
    }
    double real = double.parse(text); //VALOR EM REAL
    /*Conversao*/
    dolarController.text =
        (real / dolar).toStringAsFixed(2 /*dois digitos pos a virgula*/);
    euroController.text = (real / euro).toStringAsFixed(2);
  }

  void _dolarChanged(String text) {
    if(text.isEmpty) {
      _clearAll();
      return;
    }
    double dolar = double.parse(text);
    /*Conversao*/
    realController.text = (dolar * this.dolar).toStringAsFixed(2);
    euroController.text = (dolar * this.dolar / euro).toStringAsFixed(2); //convertendo pra reais e depois dividindo pelo euro
  }

  void _euroChanged(String text) {
    if(text.isEmpty) {
      _clearAll();
      return;
    }
    double euro = double.parse(text);
    realController.text = (euro * this.euro).toStringAsFixed(2);
    dolarController.text = (euro * this.euro / dolar).toStringAsFixed(2);//conventendo o valor por reias e dividir pelo dolar

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
      body: FutureBuilder<Map>(
        //json retorna um map
        future: getData(), //socilicita os dados e retorna
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
                dolar = snapshot.data["results"]["currencies"]["USD"]["buy"];
                euro = snapshot.data["results"]["currencies"]["EUR"]["buy"];

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
Widget buildTextField(
    String label, String prefixo, TextEditingController c, Function f) {
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



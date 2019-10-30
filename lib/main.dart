import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart';
import 'dart:convert';

void main() => runApp(MaterialApp(
      home: Main(),
      debugShowCheckedModeBanner: false,
    ));

class Main extends StatefulWidget {
  @override
  _MainState createState() => _MainState();
}

class _MainState extends State<Main> {
  String _valorBitcoin = "";

  _atualizarCotacao() async {
    //url da api
    String url = "https://blockchain.info/ticker";

    Response response;
    response = await get(url);

    Map<String, dynamic> retorno = json.decode(response.body);

    print("Resultado: " +
        retorno["BRL"]["symbol"].toString() +
        retorno["BRL"]["buy"].toString());

    String valor = retorno["BRL"]["buy"].toString();
    valor = valor.replaceAll(".", ",");

    setState(() {
      _valorBitcoin = retorno["BRL"]["symbol"].toString() + " " + valor;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color.fromRGBO(255, 148, 0, 0.8),
      body: Container(
        padding: EdgeInsets.all(30),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: <Widget>[
            Image.asset("imgs/bitcoin.png"),
            Padding(
              padding: EdgeInsets.only(top: 30),
              child: Text(
                _valorBitcoin,
                style: TextStyle(
                  fontSize: 40,
                ),
              ),
            ),
            Padding(
              padding: EdgeInsets.only(top: 30),
              child: RaisedButton(
                textColor: Color.fromRGBO(255, 148, 0, 1),
                child: Text("ATUALIZAR",
                style: TextStyle(
                  fontSize: 20,
                ),),
                onPressed: _atualizarCotacao,
              ),
            ),
          ],
        ),
      ),
    );
  }
}

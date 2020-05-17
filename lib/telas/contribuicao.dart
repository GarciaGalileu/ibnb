import 'package:flutter/material.dart';
import 'package:ibnb/config/constants.dart';
import 'package:ibnb/telas/formulario.dart';

class TelaContribuicao extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return _TelaContribuicao();
  }
}

class _TelaContribuicao extends State<TelaContribuicao> {
  _textField({String labelText}) {
    return TextField(
      decoration: InputDecoration(
        border: OutlineInputBorder(),
        labelText: labelText,
        errorText: null
      ),
    );
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Column(
          children: <Widget>[
            Container(
              alignment: Alignment.center,
              height: 180,
              decoration: BoxDecoration(
                color: Colors.black,
                image: DecorationImage(
                  image: AssetImage(
                    "assets/img/logo-igreja.png",
                  ),
                ),
                borderRadius: BorderRadius.only(
                  bottomLeft: Radius.circular(40),
                  bottomRight: Radius.circular(40),
                ),
              ),
            ),
            SizedBox(height: 20),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20),
              child: Column(
                children: <Widget>[
                  Center(
                    child: Text(
                      "Faça a sua contribuição",
                      style: TextStyle(color: ibaTextColor, fontSize: 40),
                      textAlign: TextAlign.center,
                    ),
                  ),
                ],
              ),
            ),
            SizedBox(height: 20),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: <Widget>[
                  Text(
                    "Esta é uma plataforma para todos que desejam semear no Reino de Deus através da devolução dos seus dízimos e ofertas na Igreja Batista Nova Belém de forma Segura e Prática por meio de Boleto, Débito ou Crédito",
                    style: TextStyle(color: ibaTextColor, fontSize: 22),
                    textAlign: TextAlign.justify,
                  ),
                ],
              ),
            ),
            SizedBox(height: 20),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20),
              child: Column(
                children: <Widget>[
                  Container(
                    alignment: Alignment.center,
                    height: 180,
                    decoration: BoxDecoration(
                      color: Color.fromRGBO(255,255,255,0.2),
                      borderRadius: BorderRadius.only(
                        bottomLeft: Radius.circular(40),
                        bottomRight: Radius.circular(40),
                      ),
                    ),
                    child: FormularioContribuicao()
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}

import 'package:flutter/material.dart';

class FormularioContribuicao extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return _FormularioContribuicao();
  }
}

class _FormularioContribuicao extends State<FormularioContribuicao> {
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
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(children: <Widget>[
          _textField()
        ]),
      ),
    );
  }
}

import 'package:flutter/material.dart';
//import 'package:flutter_recaptcha_v2/flutter_recaptcha_v2.dart';
import 'package:ibnb/config/constants.dart';
import 'package:brasil_fields/brasil_fields.dart';
import 'package:flutter/services.dart';

class FormularioContribuicao extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return _FormularioContribuicao();
  }
}

class _FormularioContribuicao extends State<FormularioContribuicao> {
  FocusNode _focusNode;
  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  bool _autoValidate = false;
  String valor;

  int selectRadio;
  @override
  void initState() {
    super.initState();
    selectRadio = 0;
    _focusNode = FocusNode();
  }

  @override
  void dispose() {
    _focusNode.dispose();
    super.dispose();
  }

  setSelectRadio(int val) {
    setState(() {
      selectRadio = val;
    });
  }

  void _requestFocus() {
    setState(() {
      FocusScope.of(context).requestFocus(_focusNode);
    });
  }

  _textField({String labelText}) {
    return Padding(
      padding: const EdgeInsets.only(right: 8.0),
      child: TextFormField(
        onSaved: (String value) {
          valor = value;
        },
        validator: _validateValor,
        focusNode: _focusNode,
        onTap: _requestFocus,
        style: TextStyle(color: Colors.white, fontSize: 22),
        inputFormatters: [
          WhitelistingTextInputFormatter.digitsOnly,
          RealInputFormatter(centavos: true),
        ],
        keyboardType: TextInputType.number,
        decoration: InputDecoration(
          labelText: _focusNode.hasFocus ? "Digite o valor" : "R\$ 0,00",
          labelStyle: TextStyle(color: ibaTextColor),
          fillColor: ibaTextColor,
          enabledBorder: OutlineInputBorder(
            borderSide: const BorderSide(color: Colors.white, width: 2.0),
            //borderRadius: BorderRadius.circular(25.0),
          ),
          focusedBorder: OutlineInputBorder(
            borderSide: const BorderSide(color: Colors.white, width: 2.0),
            // borderRadius: BorderRadius.circular(25.0),
          ),
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: _scaffoldKey,
      body: Form(
        key: _formKey,
        autovalidate: _autoValidate,
        child: Column(
          children: <Widget>[
            Container(
              margin: EdgeInsets.only(top: 20),
              child: Text(
                "INFORMAÇÕES DA CONTRIBUIÇÃO",
                style: TextStyle(
                    color: ibaTextColor, fontSize: 22, fontFamily: 'Lato'),
                textAlign: TextAlign.center,
              ),
            ),
            Container(
              alignment: Alignment.topLeft,
              margin: EdgeInsets.only(top: 25, left: 10),
              child: Text(
                "Qual a sua contribuição?",
                style: TextStyle(
                    color: ibaTextColor, fontSize: 20, fontFamily: 'Lato'),
              ),
            ),
            new Row(
              children: <Widget>[
                new Radio(
                  activeColor: Colors.white,
                  value: 1,
                  groupValue: selectRadio,
                  onChanged: (val) {
                    setSelectRadio(val);
                  },
                ),
                new Text(
                  'Dízimo',
                  style: new TextStyle(fontSize: 16.0, color: ibaTextColor),
                ),
                new Radio(
                    activeColor: Colors.white,
                    value: 2,
                    groupValue: selectRadio,
                    onChanged: (val) {
                      setSelectRadio(val);
                    }),
                new Text(
                  'Oferta',
                  style: new TextStyle(fontSize: 16.0, color: ibaTextColor),
                ),
              ],
            ),
            Container(
              alignment: Alignment.topLeft,
              margin: EdgeInsets.only(top: 25, left: 10),
              child: _textField(),
            ),
            SizedBox(height: 10),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: RaisedButton(
                color: ibaPrimaryColor,
                onPressed: _validateInputs,
                child: Container(
                  width: MediaQuery.of(context).size.width,
                  height: 50,
                  decoration: const BoxDecoration(),
                  child: Center(
                    child: Text('CONFIRMAR',
                        style: new TextStyle(
                          fontSize: 20.0,
                          color: ibaTextColor,
                        ),
                        textAlign: TextAlign.center),
                  ),
                ),
              ),
            )
          ],
        ),
      ),
    );
  }

  String _validateValor(String value) {
    if (value.isEmpty) {
      return 'Digite o valor da contribuição';
    }
      return null;
  }

  void _validateInputs() {
    final form = _formKey.currentState;
    if (form.validate()) {
      if (selectRadio == 0) {
        _showSnackBar('Selecione o tipo de contribuição');
      } else {
        // TODOS OS DADOS DO FORMULARIO SÃO VÁLIDOS
        // O PRÓXIMO PASSO É REALIZAR A INTEGRAÇÃO COM O MERCADO PAGO
        form.save();
        
      }
    } else {
      setState(() => _autoValidate = true);
    }
  }

  void _showSnackBar(message) {
    final snackBar = new SnackBar(
      content: new Text(
        message,
        style: new TextStyle(
          fontSize: 14.0,
          color: ibaTextColor,
        ),
      ),
    );
    _scaffoldKey.currentState.showSnackBar(snackBar);
  }
}

import 'config/constants.dart';
import 'package:flutter/material.dart';
import 'package:ibnb/telas/contribuicao.dart';

void main() {
  runApp(Contribuicao());
}

class Contribuicao extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        fontFamily: 'Lato',
        primaryColor: ibaPrimaryColor,
        scaffoldBackgroundColor: ibaBackgorundColor,
        textTheme: Theme.of(context).textTheme.apply(displayColor: ibaTextColor)
      ),
      home: TelaContribuicao(),
    );
  }

}

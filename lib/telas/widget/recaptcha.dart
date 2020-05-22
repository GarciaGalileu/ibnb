import 'package:flutter/material.dart';
import 'package:flutter_recaptcha_v2/flutter_recaptcha_v2.dart';

class MyHomePage extends StatefulWidget {
  MyHomePage({Key key, this.title}) : super(key: key);

  final String title;

  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  String verifyResult = "";
  RecaptchaV2Controller recaptchaV2Controller = RecaptchaV2Controller();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.title),
      ),
      body: Stack(
        children: <Widget>[
          Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                RaisedButton(
                  child: Text("SHOW ReCAPTCHA"),
                  onPressed: () {
                    recaptchaV2Controller.show();
                  },
                ),
                Text(verifyResult),
              ],
            ),
          ),
          RecaptchaV2(
            apiKey: "6Lcqi_oUAAAAAKTaRUUm27ryfUttLshEOr4Rr7MF",
            apiSecret: "6Lcqi_oUAAAAANZZewuRT-SLbpuKl_ZrZQ_Ts3he",
            controller: recaptchaV2Controller,
            onVerifiedError: (err){
              print(err);
            },
            onVerifiedSuccessfully: (success) {
              setState(() {
                if (success) {
                  verifyResult = "You've been verified successfully.";
                } else {
                  verifyResult = "Failed to verify.";
                }
              });
            },
          ),
        ],
      ),
    );
  }
}
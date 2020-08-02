import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_app/helpers/AppGlobal.dart';
import 'package:flutter_app/models/userDTO.dart';
import 'package:flutter_app/services/customer.services.dart';
import 'package:flutter_app/ui/navigation.dart';
import 'package:flutter_app/ui/welcome/components/background.dart';

import 'components/rounded_button.dart';
import 'components/text_field_container.dart';

class otpPage extends StatefulWidget {
  final String message;
  otpPage(this.message);
  @override
  State<StatefulWidget> createState() => otpPageState(message);
}

class otpPageState extends State<otpPage> {
  String message;
  String otp;
  otpPageState(this.message);
  final _formKey = GlobalKey<FormState>();
  final key = new GlobalKey<ScaffoldState>();

  @override
  void initState() {
    super.initState();
  }

  bool validateAndSave() {
    final form = _formKey.currentState;
    if (form.validate()) {
      form.save();
      return true;
    }
    return false;
  }
  var otpController = TextEditingController();
  void updateotp() {
    otp = otpController.text.trim();
  }
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: "OTP",
      home: Scaffold(
        key: key,
          //appBar:  ,
          backgroundColor: kPrimaryColor,
          body: _body()
      ),
    );
  }

  void validateOTP() async{
    userDTO model = new userDTO('', '', '', '', '', '', '', '', '', '', '', 0, '');
    model.otp = otp.trim();
    var resp = await customerService.ConfirmAccount(model);
    if(resp != null){
      if(resp.code == "200") {
        key.currentState.showSnackBar(SnackBar(
          content: Text("Success"),
          backgroundColor: Colors.blue,
          duration: Duration(seconds: 5),
        ));
        new Future<Null>.delayed(Duration(seconds: 5), () {
          Navigator.of(context).pushReplacement(
              new MaterialPageRoute(builder: (BuildContext context) => navigation()));
        });
      }
      else{
        key.currentState.showSnackBar(new SnackBar(
            content: new Text(resp.shortDescription),
            action: SnackBarAction(
                label: "x",
                textColor: Colors.white,
                onPressed: () {
                  key.currentState.hideCurrentSnackBar();
                }),
            backgroundColor: Colors.red,
            duration: Duration(minutes: 3)));
      }
      ScaffoldState().removeCurrentSnackBar();
    }
  }

  void ResendCode() async {

  }
  void showProcess(BuildContext context){
    key.currentState.showSnackBar(SnackBar(
      content: Text("Validating"),
      backgroundColor: Colors.blue,
      duration: Duration(seconds: 5),
    ));
  }
  Widget _body(){
    Size size = MediaQuery.of(context).size;
    return Background(
      child: Form(
          key: _formKey,
          child: new SingleChildScrollView(
            child: Padding(
              padding: const EdgeInsets.all(5.0),
              child: Container(
                padding: const EdgeInsets.fromLTRB(20, 30, 20, 50),
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(35.0),
                    color: Colors.black12
                ),
                child: Column(
                  children: <Widget>[
                    Text("Verification Code", style: TextStyle(color: Colors.white, fontSize: 30, fontWeight: FontWeight.bold),),
                    SizedBox(height: size.height * 0.05),
                    Text(message, style: TextStyle(fontWeight: FontWeight.bold,
                        fontSize: 16, color: Colors.white)),
                    SizedBox(height: size.height * 0.09,),
                    TextFieldContainer(
                      child: TextFormField(
                        key: new Key('otp'),
                        onChanged: (value) => updateotp(),
                        validator: (value) {
                          if (value.isEmpty) {
                            return 'Verification Code cannot be blank';
                          }
                          return null;
                        },
                        cursorColor: kPrimaryColor,
                        autocorrect: false,
                        controller: otpController,
                        decoration: InputDecoration(border: InputBorder.none, isDense: true, labelText: "Enter your code",),
                      ),
                    ),
                    SizedBox(height: size.height * 0.05,),
                    RoundedButton(
                      text: "VALIDATE",
                      color: Colors.green,
                      textColor: Colors.white,
                      press: () {
                        if (_formKey.currentState.validate()){
                          ScaffoldState().removeCurrentSnackBar();
                          showProcess(context);
                          ScaffoldState().removeCurrentSnackBar();
                          validateOTP();
                        }
                      },
                    ),
                    FlatButton(
                      onPressed: (){
                        ResendCode();
                      },
                      color: Colors.red,
                      shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(18.0)),
                      child: Text("Resend Code", style: TextStyle(color: Colors.white),),
                    )
                  ],
                ),
              ),
            ),
          )
      ),
    );
  }

}
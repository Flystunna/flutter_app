import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_app/helpers/AppGlobal.dart';
import 'package:flutter_app/models/userDTO.dart';
import 'package:flutter_app/services/customer.services.dart';
import 'package:flutter_app/ui/navigation.dart';
import 'package:flutter_app/ui/welcome/components/background.dart';

import 'Login.dart';
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
  userDTO model = new userDTO('', '', '', '', '', '', '', '', '', '', '', 0,'','');
  otpPageState(this.message);
  final _formKey = GlobalKey<FormState>();
  final key = new GlobalKey<ScaffoldState>();
  bool isLoading = false;

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
    //userDTO model = new userDTO('', '', '', '', '', '', '', '', '', '', '', 0,'');
    model.otp = otp.trim();
    var resp = await customerService.ConfirmAccount(model);
    if(resp != null){
      if(resp.code == "200") {
        key.currentState.showSnackBar(SnackBar(
          content: Text("Account Activated Successfully"),
          backgroundColor: Colors.blue,
          duration: Duration(seconds: 3),
        ));
        new Future<Null>.delayed(Duration(seconds: 3), () {
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

  void _navigateToLogin() async {
    await Navigator.pushReplacement(
        context,
        MaterialPageRoute(
            builder: (context) => Login()));
  }
  void ResendCode() async {
    setState(() {
      isLoading = true;
    });
    var resendcode = await customerService.SendActivationCode(model);

    if(resendcode != null){
      if(resendcode.code == '200'){
        setState(() {
          isLoading = false;
        });
        key.currentState.showSnackBar(new SnackBar(
            content: new Text(resendcode.shortDescription),
            action: SnackBarAction(
                label: "x",
                textColor: Colors.white,
                onPressed: () {
                  key.currentState.hideCurrentSnackBar();
                }),
            backgroundColor: Colors.lightGreen,
            duration: Duration(minutes: 3)));
      }
      else{
        setState(() {
          isLoading = false;
        });
        key.currentState.showSnackBar(new SnackBar(
            content: new Text(resendcode.shortDescription),
            action: SnackBarAction(
                label: "x",
                textColor: Colors.white,
                onPressed: () {
                  key.currentState.hideCurrentSnackBar();
                }),
            backgroundColor: Colors.blue,
            duration: Duration(minutes: 3)));
        ScaffoldState().removeCurrentSnackBar();
      }
    }
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
                            return 'Verification Code Missing';
                          }
                          return null;
                        },
                        cursorColor: kPrimaryColor,
                        autocorrect: false,
                        controller: otpController,
                        decoration: InputDecoration(border: InputBorder.none, isDense: true, labelText: "Enter Verification Code",),
                      ),
                    ),
                    SizedBox(height: size.height * 0.05,),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: <Widget>[
                        FlatButton(
                            color: Colors.purple,
                            onPressed: () {
                              if (_formKey.currentState.validate()){
                                ScaffoldState().removeCurrentSnackBar();
                                showProcess(context);
                                ScaffoldState().removeCurrentSnackBar();
                                validateOTP();
                              }
                            },
                            shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(15.0)),
                            child: Text("Validate", style: TextStyle(color: Colors.white))
                        ),
                        SizedBox(width: size.width * 0.02),
                        FlatButton(
                            color: Colors.purple,
                            onPressed: () {
                              _navigateToLogin();
                            },
                            shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(15.0)),
                            child: Text("Back To Login", style: TextStyle(color: Colors.white))
                        ),
                      ],
                    ),
                    Container(
                      padding: EdgeInsets.all(2),
                      child:  isLoading == false ?  FlatButton(
                        onPressed: (){
                          ResendCode();
                        },
                        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(18.0)),
                        child: Text("Resend Code", style: TextStyle(color: Colors.white),),
                      ) : Center(
                        child: CircularProgressIndicator(backgroundColor: kPrimaryLightColor, strokeWidth: 5,),
                      ),
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
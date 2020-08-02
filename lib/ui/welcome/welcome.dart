import 'package:flutter/material.dart';
import 'package:flutter_app/ui/welcome/components/body.dart';
import 'package:flutter_app/services/token.services.dart';

import '../navigation.dart';


class WelcomeScreen extends StatefulWidget {
  WelcomeScreen({Key key}) : super(key: key);
  @override
  _WelcomeScreenState createState() => _WelcomeScreenState();
}

class _WelcomeScreenState extends State<WelcomeScreen> {
  bool isAuth = false;
  isAuthenticate(){
    tokenService().isLoggedin().then((auth){
      if(auth == "" || auth == null){
        setState(() {
          isAuth = false;
        });
      }else{
        setState(() {
          isAuth = true;
        });
      }
    });
  }
  @override
  Widget build(BuildContext context) {
    isAuthenticate();
    return Scaffold(
      body: isAuth != true ?  Body() : navigation(),
    );
  }
}


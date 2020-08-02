import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_app/services/token.services.dart';
import '../main.dart';

class Logout extends StatefulWidget {
  @override
  LogoutState createState() {
    return LogoutState();
  }
}

class LogoutState extends State<Logout> {
  @override
  void initState() {
    super.initState();
  }
  @override
  void dispose() {
    super.dispose();
  }

  void _logout() async{
    await tokenService.logout();
    Navigator.of(context, rootNavigator: true).pushAndRemoveUntil(MaterialPageRoute(builder: (context)=> MyApp()), (Route<dynamic> route) => false);
  }

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    _logout();
    return Scaffold(
      //key: key,
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[
          Expanded(child: Text("Logout"))
        ],
      ),
    );
  }
}
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_app/helpers/AppGlobal.dart';
import 'package:flutter_app/main.dart';
import 'package:flutter_app/models/EmployeeDTO.dart';
import 'package:flutter_app/models/LoginModel.dart';
import 'package:flutter_app/models/Usermodel.dart';
import 'package:flutter_app/services/token.services.dart';
import 'package:flutter_app/ui/welcome/welcome.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:flutter_svg/svg.dart';
import 'PrimaryButton.dart';
import 'addemployeePage.dart';
import 'components/rounded_button.dart';
import 'components/rounded_input_field.dart';
import 'components/rounded_password_field.dart';
import 'components/text_field_container.dart';
import 'customerSignup.dart';
import 'employeesPage.dart';
import 'navigation.dart';

class Login extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final appTitle = 'Login';
    return MaterialApp(
      title: appTitle,
      home: Scaffold(
        //appBar: _buildAppBar(appTitle),
        backgroundColor: Colors.white,
        body: MyCustomForm(),
      ),
    );
  }
}

Widget _buildAppBar(String title) {
  return AppBar(
    title: Center(child: Text(title)),
    backgroundColor: Colors.lightBlueAccent,
  );
}

// Create a Form widget.
class MyCustomForm extends StatefulWidget {
  @override
  MyCustomFormState createState() {
    return MyCustomFormState();
  }
}

// Create a corresponding State class.
// This class holds data related to the form.
class MyCustomFormState extends State<MyCustomForm> {
  final _formKey = GlobalKey<FormState>();
  Usermodel _user = new Usermodel();
  bool _passwordVisible = false;
  String validateEmail(String value) {
    String pattern =
        r'^(([^<>()[\]\\.,;:\s@\"]+(\.[^<>()[\]\\.,;:\s@\"]+)*)|(\".+\"))@((\[[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\])|(([a-zA-Z\-0-9]+\.)+[a-zA-Z]{2,}))$';
    RegExp regExp = new RegExp(pattern);
    if (value.length == 0) {
      return "Email is Required";
    } else if (!regExp.hasMatch(value.trim())) {
      return "Invalid Email";
    } else {
      return null;
    }
  }

  bool validateAndSave() {
    final form = _formKey.currentState;
    if (form.validate()) {
      form.save();
      return true;
    }
    return false;
  }

  bool loginSuccess(String value){
    if(value.trim().contains('Login Successful'))
      return true;
    else{
      return false;
    }
  }

  var usernameController = TextEditingController();

  void updateUsername() {
    _user.email = usernameController.text.trim();
  }

  var passwordController = TextEditingController();

  void updatePassword() {
    _user.password = passwordController.text.trim();
  }

  void _navigateToEmployee() async{
    await Navigator.pushReplacement(context, MaterialPageRoute(
        builder: (context) => AddEmployeePage(EmployeeDTO('','','','','','','',1,'','','','',1,'',''))
    ));
  }
  void _navigateToCustomerSignup() async{
    await Navigator.pushReplacement(context, MaterialPageRoute(
        builder: (context) => CustomerSignup()
    ));
  }

  void _logout() async{
    await tokenService.logout();
    Navigator.of(context, rootNavigator: true).pushAndRemoveUntil(MaterialPageRoute(builder: (context)=> MyApp()), (Route<dynamic> route) => false);
  }

  @override
  void initState() {
    super.initState();
  }

  @override
  void dispose() {
    super.dispose();
  }

  Widget padded({Widget child}) {
    return new Padding(
      padding: EdgeInsets.symmetric(vertical: 8.0),
      child: child,
    );
  }

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Form(
        key: _formKey,
        child: new SingleChildScrollView(
          child: new Container(
            padding: const EdgeInsets.fromLTRB(16.0, 30.0, 16.0, 16.0),
            child: new Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                new Card( child: new Column(mainAxisSize: MainAxisSize.min, children: <Widget>[
                  new Container(
                      padding: const EdgeInsets.all(16.0),
                      child: new Column(
                        children: <Widget>[
                          Text(
                            "LOGIN",
                            style: TextStyle(fontWeight: FontWeight.bold),
                          ),
                          SizedBox(height: size.height * 0.1),
                          SvgPicture.asset(
                            "assets/icons/login.svg",
                            height: size.height * 0.35,
                          ),
                          TextFieldContainer(
                            child: TextFormField(
                              key: new Key('email'),
                              onChanged: (value) => updateUsername(),
                              validator: (val) => validateEmail(val),
                              cursorColor: kPrimaryColor,
                              autocorrect: false,
                              controller: usernameController,
                              decoration: InputDecoration(
                                icon: Icon(Icons.person, color: kPrimaryColor,),
                                hintText: "Your Email",
                                border: InputBorder.none,
                              ),
                            ),
                          ),
                          TextFieldContainer(
                            child: TextFormField(
                              key: new Key('password'),
                              obscureText: !_passwordVisible,
                              controller: passwordController,
                              onChanged: (value) => updatePassword(),
                              validator: (value) {
                                if (value.isEmpty) {
                                  return 'Password cannot be blank';
                                } return null;
                              },
                              cursorColor: kPrimaryColor,
                              decoration: InputDecoration(
                                hintText: "Password",
                                icon: Icon(Icons.lock, color: kPrimaryColor,),
                                suffixIcon: IconButton(
                                  icon: Icon(_passwordVisible? Icons.visibility : Icons.visibility_off, color: kPrimaryColor),
                                  onPressed: (){ setState(() {_passwordVisible = !_passwordVisible;});},
                                ), border: InputBorder.none,
                              ),
                            ),
                          ),
                          RoundedButton(
                            text: "LOGIN",
                            press: () async {
                              if (_formKey.currentState.validate()) {
                                Scaffold.of(context).showSnackBar(SnackBar(content: Text("Processing"), backgroundColor: Colors.blue, duration: Duration(seconds: 1),));
                                var login = new LoginModel();
                                login.userName = _user.email.trim();
                                login.password = _user.password.trim();
                                var resp = await tokenService.login(login);
                                if(resp.object != null){
                                  _user.username = resp.object.username;
                                }
                                if(resp.shortDescription != null) {
                                  if(loginSuccess(resp.shortDescription)) {
                                    Scaffold.of(context).showSnackBar(SnackBar(content: Text(resp.shortDescription), backgroundColor: Colors.green, duration: Duration(seconds: 1)));
                                  }
                                  else{
                                    Scaffold.of(context).showSnackBar(SnackBar(content: Text(resp.shortDescription), backgroundColor: Colors.redAccent, duration: Duration(seconds: 1)));
                                  }
                                }
                                if (resp.shortDescription.contains('Login Successful')) {
                                  ScaffoldState().removeCurrentSnackBar();
                                  new Future<Null>.delayed( Duration(seconds: 3), () {
                                    Navigator.of(context).pushReplacement(new MaterialPageRoute(builder: (BuildContext context) => navigation()));
                                  });
                                }
                              }
                            },
                          ),
                          RoundedButton(
                            text: "Need an account? Register",
                            color: kPrimaryLightColor,
                            press: () {
                              _navigateToCustomerSignup();
                              },
                            textColor: Colors.black,
                          ),
//                          new FlatButton(
//                              key: new Key('welcome-screen'),
//                              child: new Text("Logout"),
//                              onPressed: () {
//                                _logout();
//                              //Navigator.of(context, rootNavigator: true).pushAndRemoveUntil(MaterialPageRoute(builder: (context)=> MyApp()), (Route<dynamic> route) => false);
//                              //Navigator.pushAndRemoveUntil(context, MaterialPageRoute(builder: (context) => MyApp()));
//                              })
                        ],
                      ))
                ])),
              ],
            ),
          ),
        )
    );
  }
}
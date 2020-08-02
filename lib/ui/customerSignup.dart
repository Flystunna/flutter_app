import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_app/helpers/AppGlobal.dart';
import 'package:flutter_app/models/EmployeeDTO.dart';
import 'package:flutter_app/models/LoginModel.dart';
import 'package:flutter_app/models/userDTO.dart';
import 'package:flutter_app/services/customer.services.dart';
import 'package:flutter_app/services/token.services.dart';
import 'package:flutter_app/ui/welcome/welcome.dart';
import 'package:flutter_svg/svg.dart';
import 'package:intl/intl.dart';
import 'Login.dart';
import 'addemployeePage.dart';
import 'components/rounded_button.dart';
import 'components/text_field_container.dart';
import 'navigation.dart';
import 'otpPage.dart';

class CustomerSignup extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final appTitle = 'Login';
    return MaterialApp(
      title: appTitle,
      home: Scaffold(
        backgroundColor: Colors.white,
        body: CustomerSignupForm(),
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
class CustomerSignupForm extends StatefulWidget {
  @override
  CustomerSignupFormState createState() {
    return CustomerSignupFormState();
  }
}

// Create a corresponding State class.
// This class holds data related to the form.
class CustomerSignupFormState extends State<CustomerSignupForm> {
  final _formKey = GlobalKey<FormState>();
  userDTO _user = new userDTO('','','','','','','','','','','',0,'');
  bool _passwordVisible = false;
  DateTime pickedDate;
  TimeOfDay time;

  @override
  void initState() {
    super.initState();
    pickedDate = DateTime.now();
    time = TimeOfDay.now();
  }

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
  _pickDate() async {
    DateTime date = await showDatePicker(
      context: context,
      firstDate: DateTime(DateTime.now().year-100),
      lastDate: DateTime(DateTime.now().year+100),
      initialDate: pickedDate,
    );
    if(date != null)
      setState(() {
        pickedDate = date;
      });
  }

  bool validateAndSave() {
    final form = _formKey.currentState;
    if (form.validate()) {
      form.save();
      return true;
    }
    return false;
  }

  bool regSuccess(String value) {
    if (value.trim().contains('200'))
      return true;
    else {
      return false;
    }
  }

  var usernameController = TextEditingController();
  void updateUsername() {
    _user.email = usernameController.text.trim();
  }

  var firstnameController = TextEditingController();
  void updateFirstname() {
    _user.firstName = firstnameController.text.trim();
  }

  var lastnameController = TextEditingController();
  void updateLastname() {
    _user.lastName = lastnameController.text.trim();
  }

  var middlenameController = TextEditingController();
  void updateMiddlename() {
    _user.middleName = middlenameController.text.trim();
  }

  var nextofkinController = TextEditingController();
  void updateNOF() {
    _user.nextOfKinName = nextofkinController.text.trim();
  }

  var phoneController = TextEditingController();
  void updatePhone() {
    _user.phoneNumber = phoneController.text.trim();
  }

  var nextofkinphoneController = TextEditingController();
  void updateNofphone() {
    _user.nextOfKinPhone = nextofkinphoneController.text.trim();
  }

  var addressController = TextEditingController();
  void updateAddress() {
    _user.address = addressController.text.trim();
  }

  var passwordController = TextEditingController();
  void updatePassword() {
    _user.password = passwordController.text.trim();
  }

  void _navigateToLogin() async {
    await Navigator.pushReplacement(
        context,
        MaterialPageRoute(
            builder: (context) => Login()));
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
                new Card(
                    child: new Column(mainAxisSize: MainAxisSize.min, children: <Widget>[
                      new Container(padding: const EdgeInsets.all(15.0),
                          child: new Column(
                            children: <Widget>[Text("LET'S SIGN YOU UP", style: TextStyle(fontWeight: FontWeight.bold, fontSize: 18),),
                              SizedBox(height: size.height * 0.1),
                              SvgPicture.asset("assets/icons/signup.svg", height: size.height * 0.35,),
                              SizedBox(height: size.height * 0.01,),
                              SizedBox(
                                //height: 65,
                                child: TextFieldContainer(
                                  child: TextFormField(
                                    key: new Key('firstname'),
                                    onChanged: (value) => updateFirstname(),
                                    validator: (value) {
                                      if (value.isEmpty) {
                                        return 'Field cannot be blank';
                                      }
                                      return null;
                                    },
                                    cursorColor: kPrimaryColor,
                                    autocorrect: false,
                                    controller: firstnameController,
                                    decoration: InputDecoration(icon: Icon(Icons.person, color: kPrimaryColor),
                                      hintText: "First Name", border: InputBorder.none
                                    ),
                                  ),
                                ),
                              ),
                            SizedBox(
                              //height: 65,
                              child: TextFieldContainer(
                                child: TextFormField(
                                  key: new Key('middlename'),
                                  onChanged: (value) => updateMiddlename(),
                                  cursorColor: kPrimaryColor,
                                  autocorrect: false,
                                  controller: middlenameController,
                                  decoration: InputDecoration(
                                    icon:
                                        Icon(Icons.person, color: kPrimaryColor),
                                    hintText: "Middle Name",
                                    border: InputBorder.none,
                                  ),
                                ),
                              ),
                            ),
                            SizedBox(
                                //height: 65,
                                child: TextFieldContainer(
                                  child: TextFormField(
                                    key: new Key('lastname'),
                                    onChanged: (value) => updateLastname(),
                                    validator: (value) {
                                      if (value.isEmpty) {
                                        return 'Field cannot be blank';
                                      }
                                      return null;
                                    },
                                    cursorColor: kPrimaryColor,
                                    autocorrect: false,
                                    controller: lastnameController,
                                    decoration: InputDecoration(
                                      icon: Icon(Icons.person,
                                          color: kPrimaryColor),
                                      hintText: "Last Name",
                                      border: InputBorder.none,
                                    ),
                                  ),
                                )),
                              SizedBox(
                                //height: 65,
                                child: TextFieldContainer(
                                  child: TextFormField(
                                    key: new Key('phone'),
                                    onChanged: (value) => updatePhone(),
                                    validator: (value) {
                                      if (value.isEmpty) {
                                        return 'Field cannot be blank';
                                      }
                                      return null;
                                    },
                                    cursorColor: kPrimaryColor,
                                    autocorrect: false,
                                    controller: phoneController,
                                    decoration: InputDecoration(icon: Icon(Icons.phone, color: kPrimaryColor),
                                        hintText: "Phone Number",
                                        border: InputBorder.none
                                    ),
                                  ),
                                ),
                              ),
                            SizedBox(
                              //height: 65,
                              child: TextFieldContainer(
                                child: TextFormField(
                                  key: new Key('email'),
                                  onChanged: (value) => updateUsername(),
                                  validator: (val) => validateEmail(val),
                                  cursorColor: kPrimaryColor,
                                  autocorrect: false,
                                  controller: usernameController,
                                  decoration: InputDecoration(
                                    icon:
                                        Icon(Icons.alternate_email, color: kPrimaryColor),
                                    hintText: "Email",
                                    border: InputBorder.none,
                                  ),
                                ),
                              ),
                            ),
                              SizedBox(
                                //height: 65,
                                child: TextFieldContainer(
                                  child: TextFormField(
                                    key: new Key('address'),
                                    onChanged: (value) => updateAddress(),
                                    validator: (value) {
                                      if (value.isEmpty) {
                                        return 'Field cannot be blank';
                                      }
                                      return null;
                                    },
                                    cursorColor: kPrimaryColor,
                                    autocorrect: false,
                                    controller: addressController,
                                    decoration: InputDecoration(icon: Icon(Icons.person, color: kPrimaryColor),
                                        hintText: "Home Address", border: InputBorder.none
                                    ),
                                  ),
                                ),
                              ),
                            SizedBox(
                              height: 65,
                              child: TextFieldContainer(
                                child: TextFormField(
                                  key: new Key('newpassword'),
                                  obscureText: !_passwordVisible,
                                  controller: passwordController,
                                  onChanged: (value) => updatePassword(),
                                  validator: (value) {
                                    if (value.isEmpty) {
                                      return 'Password cannot be blank';
                                    }
                                    return null;
                                  },
                                  cursorColor: kPrimaryColor,
                                  decoration: InputDecoration(
                                    contentPadding: EdgeInsets.zero,
                                    hintText: "Password",
                                    icon: Icon(Icons.lock, color: kPrimaryColor),
                                    suffixIcon: IconButton(
                                      icon: Icon(
                                          _passwordVisible
                                              ? Icons.visibility
                                              : Icons.visibility_off,
                                          color: kPrimaryColor),
                                      onPressed: () {
                                        setState(() {
                                          _passwordVisible = !_passwordVisible;
                                        });
                                      },
                                    ),
                                    border: InputBorder.none,
                                  ),
                                ),
                              ),
                            ),
                              SizedBox(
                                  //height: 65,
                                  child: TextFieldContainer(
                                    child: TextFormField(
                                      key: new Key('nofkin'),
                                      onChanged: (value) => updateNOF(),
                                      //validator: (val) => validateEmail(val),
                                      cursorColor: kPrimaryColor,
                                      autocorrect: false,
                                      controller: nextofkinController,
                                      decoration: InputDecoration(
                                        icon: Icon(Icons.person,
                                            color: kPrimaryColor),
                                        hintText: "Optional",
                                        labelText: "Next Of Kin",
                                        isDense: true,
                                        border: InputBorder.none,
                                      ),
                                    ),
                                  )
                              ),
                              SizedBox(
                                //height: 65,
                                  child: TextFieldContainer(
                                    child: TextFormField(
                                      key: new Key('nofkinphone'),
                                      onChanged: (value) => updateNofphone(),
                                      //validator: (val) => validateEmail(val),
                                      cursorColor: kPrimaryColor,
                                      autocorrect: false,
                                      controller: nextofkinphoneController,
                                      decoration: InputDecoration(
                                        icon: Icon(Icons.phone_paused,
                                            color: kPrimaryColor),
                                        hintText: "Optional",
                                        labelText: "Next Of Kin Phone",
                                        isDense: true,
                                        border: InputBorder.none,
                                      ),
                                    ),
                                  )
                              ),
                              ListTile(
                                title: Text("Date Of Birth:   ${pickedDate.year}-${pickedDate.month}-${pickedDate.day}",style: TextStyle(fontSize: 14),),
                                trailing: Icon(Icons.keyboard_arrow_down),
                                onTap: _pickDate,
                              ),
                            RoundedButton(
                              text: "REGISTER ",
                              press: () async {
                                if (_formKey.currentState.validate()) {
                                  Scaffold.of(context).showSnackBar(SnackBar(
                                    content: Text("Processing"),
                                    backgroundColor: Colors.blue,
                                    duration: Duration(seconds: 1),
                                  ));
                                  _user.gender = 1;
                                  _user.dateOfBirth = '${pickedDate.year}-${pickedDate.month}-${pickedDate.day}';
                                  var resp = await customerService.Register(_user);
                                  if (resp.object != "false" && resp !=  null) {
                                    _user.username = _user.email;
                                  }
                                  if (resp != null) {
                                    if (regSuccess(resp.code)) {
                                      Scaffold.of(context).showSnackBar(SnackBar(
                                          content: Text(resp.shortDescription),
                                          backgroundColor: Colors.green,
                                          duration: Duration(seconds: 5)));
                                      //Page for otp will take only one string message
                                      new Future<Null>.delayed(Duration(seconds: 5), () {
                                            Navigator.of(context).pushReplacement(
                                                new MaterialPageRoute(builder: (BuildContext context) => otpPage(resp.shortDescription))
                                            );
                                          });
                                    }
                                    else if(resp.code.contains("302")){
                                      //User already exist. Move to otp page
                                      new Future<Null>.delayed(Duration(seconds: 5), () {
                                        Navigator.of(context).pushReplacement(
                                            new MaterialPageRoute(builder: (BuildContext context) => otpPage(resp.shortDescription))
                                        );
                                      });
                                    }
                                    else {
                                      Scaffold.of(context).showSnackBar(SnackBar(
                                          content: Text(resp.shortDescription),
                                          backgroundColor: Colors.redAccent,
                                          duration: Duration(seconds: 15)));
                                    }
                                  }
//                                  if(resp != null){
//                                    if (resp.code.contains('200')) {
//                                      ScaffoldState().removeCurrentSnackBar();
//
//                                    }
//                                  }
                                }
                              },
                            ),
                            RoundedButton(
                              text: "Back To Login",
                              color: kPrimaryLightColor,
                              press: () {
                                _navigateToLogin();
                              },
                              textColor: Colors.black,
                            ),
                        ],
                      ))
                ])),
              ],
            ),
          ),
        ));
  }
}

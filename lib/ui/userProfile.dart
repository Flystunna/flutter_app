import 'dart:convert';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_app/helpers/AppGlobal.dart';
import 'package:flutter_app/models/EmployeeDTO.dart';
import 'package:flutter_app/models/userDTO.dart';
import 'package:flutter_app/models/userProfileDTO.dart';
import 'package:flutter_app/services/customer.services.dart';
import 'package:flutter_app/ui/components/formTextField.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:sliding_up_panel/sliding_up_panel.dart';
import 'Logout.dart';
import 'components/text_field_container.dart';

class userProfile extends StatefulWidget {
 // final userDTO user;
  userProfile();
  @override
  State<StatefulWidget> createState() => userProfileState();
}

class userProfileState extends State<userProfile> {
  userProfileDTO user = new userProfileDTO('', '', '', '', '', '', '', '', '', '', '','','','','','');
  userProfileState();
  String referralCode = "...";
  final _formKey = GlobalKey<FormState>();
  final key = new GlobalKey<ScaffoldState>();
  DateTime pickedDate;
  TimeOfDay time;
  getProfile(){
    if(user.firstName == "" || user.firstName == null){
      customerService.GetProfile().then((resp){
        if(resp != null){
          setState(() {
            if(user.referralCode != null || user.referralCode != ""){
              referralCode = user.referralCode;
            }
            user = resp;
          });
        }
      });
    }
    else{
    }
  }
  getUser() async {
    final prefs = await SharedPreferences.getInstance();
    String username = prefs.getString("email");
    if(username != null){
      setState(() {
        user.username = username;
      });
    }
  }

  @override
  void initState() {
    super.initState();
    pickedDate = DateTime.now();
    time = TimeOfDay.now();
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

  Widget _buildAppBar() {
    return PreferredSize(
      preferredSize: Size.fromHeight(35),
      child: AppBar(
        title: Center(child: Text("Profile")),
        backgroundColor: Colors.transparent,
        centerTitle: false,
        actions: <Widget>[
          IconButton(
            icon: Icon(Icons.email
            ),
            color: Colors.white,
            onPressed: () {},
          )
        ],
      ),
    );
  }
  showAlertDialog(BuildContext context){
    Widget cancelButton = FlatButton(
      child: Text("Cancel"),
      onPressed: (){
        Navigator.of(context).pop();
      },
    );
    Widget continueButton = FlatButton(
      child: Text("Continue"),
      onPressed: (){
        Navigator.of(context).pushReplacement(new MaterialPageRoute(builder: (BuildContext context) => Logout()));
      },
    );

    AlertDialog alert = AlertDialog(
      title: Text("Logout"),
      content: Text("Are you sure you want to logout?"),
      actions: <Widget>[
        continueButton,
        cancelButton
      ],
    );

    showDialog(
        context: context,
      builder: (BuildContext context) {
       return alert;
     });
  }

  @override
  Widget build(BuildContext context) {
    var firstNameController = TextEditingController();
    firstNameController.text = user.firstName;
    void updateFirstname() {
      user.firstName = firstNameController.text.trim();
    }
    getUser();
    getProfile();
    Size size = MediaQuery.of(context).size;
    return Scaffold(
      appBar:  _buildAppBar(),
      backgroundColor: kBlueColor,
      body: Container(
          child: Form(
              key: _formKey,
              child: new SingleChildScrollView(
                //padding: EdgeInsets.all(10),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  //crossAxisAlignment: CrossAxisAlignment.center,
                  children: <Widget>[
                    Center(
                      child: Column(
                        children: <Widget>[
                          Padding(
                            padding: const EdgeInsets.all(30.0),
                            child: CircleAvatar(
                              //backgroundImage: AssetImage('images/pic.jpg'),
                              radius: 30,
                            ),
                          ),
                          Text(user.username != "" ? user.username : "Loading", style: TextStyle(color: Colors.white),),
                          SizedBox(height: size.height*0.02),
                          Text("Gender : " + user.gender, style: TextStyle(color: Colors.white)),
                          SizedBox(height: size.height*0.02),
                          Text("Referral Code : " + referralCode, style: TextStyle(color: Colors.white)),
                          SizedBox(height: size.height*0.02),
                          Text("Date Joined : " + user.dateJoined, style: TextStyle(color: Colors.white)),
                          SizedBox(height: size.height*0.022),
                        ],
                      ),
                    ),
                    ConstrainedBox(
                      constraints: BoxConstraints(
                        maxHeight: MediaQuery.of(context).size.height * 0.53
                      ),
                      child: Container(
                        decoration: BoxDecoration(
                          color: Theme.of(context).scaffoldBackgroundColor,
                          borderRadius: BorderRadius.only(
                            topLeft: Radius.circular(30.0),
                            topRight: Radius.circular(30.0),
                          ),
                        ),
                        child: Padding(
                          padding: const EdgeInsets.fromLTRB(30, 0, 30, 0),
                          child: Column(
                            //crossAxisAlignment: CrossAxisAlignment.center,
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: <Widget>[
                              Container(
                                decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(8),
                                    border: Border.all(color: Colors.black)
                                  //color: Colors.white
                                ),
                                child: Column(
                                  children: <Widget>[
                                    SizedBox(height: size.height * 0.03),
                                    Row(
                                      children: <Widget>[
                                        SizedBox(width: size.width * 0.02),
                                        Icon(Icons.person_outline, size: 18),
                                        SizedBox(width: size.width * 0.02),
                                        GestureDetector(
                                          onTap: () {
                                          },
                                          child: Text("Personal Details"),
                                        ),
                                        SizedBox(width: size.width * 0.32),
                                        GestureDetector(
                                            onTap: () {
                                            },
                                            child: Icon(Icons.arrow_forward, size: 16)
                                        ),
                                      ],
                                    ),
                                    SizedBox(height: size.height * 0.03),
                                  ],
                                ),
                              ),
                              SizedBox(height: size.height * 0.03),
                              Container(
                                decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(8),
                                    border: Border.all(color: Colors.black)
                                  //color: Colors.white
                                ),
                                child: Column(
                                  children: <Widget>[
                                    SizedBox(height: size.height * 0.03),
                                    Row(
                                      children: <Widget>[
                                        SizedBox(width: size.width * 0.02),
                                        Icon(Icons.phone, size: 18),
                                        SizedBox(width: size.width * 0.02),
                                        GestureDetector(
                                          onTap: () {
                                          },
                                          child: Text("Contact Us"),
                                        ),
                                        SizedBox(width: size.width * 0.41),
                                        GestureDetector(
                                            onTap: () {
                                            },
                                            child: Icon(Icons.arrow_forward, size: 16)
                                        ),
                                      ],
                                    ),
                                    SizedBox(height: size.height * 0.03),
                                  ],
                                ),
                              ),
                              SizedBox(height: size.height * 0.03),
                              Container(
                                decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(8),
                                    border: Border.all(color: Colors.black)
                                  //color: Colors.white
                                ),
                                child: Column(
                                  children: <Widget>[
                                    SizedBox(height: size.height * 0.03),
                                    Row(
                                      children: <Widget>[
                                        SizedBox(width: size.width * 0.02),
                                        Icon(Icons.exit_to_app, size: 18, color: Colors.red),
                                        SizedBox(width: size.width * 0.02),
                                        GestureDetector(
                                          onTap: () {
                                            showAlertDialog(context);
                                            //Navigator.of(context).pushReplacement(new MaterialPageRoute(builder: (BuildContext context) => Logout()));
                                          },
                                          child: Text("Log Out"),
                                        ),
                                        SizedBox(width: size.width * 0.47),
                                        GestureDetector(
                                            onTap: () {
                                              showAlertDialog(context);
                                              //Navigator.of(context).pushReplacement(new MaterialPageRoute(builder: (BuildContext context) => Logout()));
                                            },
                                            child: Icon(Icons.arrow_forward, size: 16)
                                        ),
                                      ],
                                    ),
                                    SizedBox(height: size.height * 0.03),
                                  ],
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              )
          ),
        ),
    );
  }
}

//                              Row(
//                                children: <Widget>[
//                                  new Flexible(
//                                    child: TextFormField(
//                                      key: new Key('firstName'),
//                                      controller: firstNameController,
//                                      onChanged: (value) => updateFirstname(),
//                                      autocorrect: false,
//                                      decoration: InputDecoration(
//                                          labelText: "First Name",
//                                          labelStyle: TextStyle(color: Colors.black),
//                                          isDense: true),
//                                      style: Theme.of(context).textTheme.copyWith(bodyText1: Theme.of(context).textTheme.bodyText1.copyWith(color: Colors.black)).bodyText1,
//                                    ) ,
//                                  ),
//                                ],
//                              ),


//                        Row(
//                          children: <Widget>[
//                            new Flexible(
//                              child: TextFormField(
//                                key: new Key('middleName'),
//                                controller: firstNameController,
//                                onChanged: (value) => updateFirstname(),
//                                autocorrect: false,
//                                decoration: InputDecoration(
//                                  //counterText: "First Name",
//                                    labelText: "Middle Name",
//                                    labelStyle: TextStyle(color: Colors.white),
//                                    isDense: true),
//                                style: Theme.of(context).textTheme.copyWith(bodyText1: Theme.of(context).textTheme.bodyText1.copyWith(color: Colors.white)).bodyText1,
//                              ),
//                            ),
//                          ],
//                        ),
//                        TextFormField(
//                          key: new Key('lastName'),
//                          controller: firstNameController,
//                          onChanged: (value) => updateFirstname(),
//                          autocorrect: false,
//                          decoration: InputDecoration(
//                              labelText: "Last Name",
//                              labelStyle: TextStyle(color: Colors.white),
//                              isDense: true),
//                          style: Theme.of(context).textTheme.copyWith(bodyText1: Theme.of(context).textTheme.bodyText1.copyWith(color: Colors.white)).bodyText1,
//                        ),
//                        TextFormField(
//                          key: new Key('email'),
//                          controller: firstNameController,
//                          readOnly: true,
//                          onChanged: (value) => updateFirstname(),
//                          autocorrect: false,
//                          decoration: InputDecoration(
//                              labelText: "Email",
//                              labelStyle: TextStyle(color: Colors.white),
//                              isDense: true),
//                          style: Theme.of(context).textTheme.copyWith(bodyText1: Theme.of(context).textTheme.bodyText1.copyWith(color: Colors.white)).bodyText1,
//                        ),
//                        TextFormField(
//                          key: new Key('phone'),
//                          controller: firstNameController,
//                          readOnly: true,
//                          onChanged: (value) => updateFirstname(),
//                          autocorrect: false,
//                          decoration: InputDecoration(
//                              labelText: "Phone Number",
//                              labelStyle: TextStyle(color: Colors.white),
//                              isDense: true),
//                          style: Theme.of(context).textTheme.copyWith(bodyText1: Theme.of(context).textTheme.bodyText1.copyWith(color: Colors.white)).bodyText1,
//                        ),
//                        TextFormField(
//                          key: new Key('address'),
//                          controller: firstNameController,
//                          onChanged: (value) => updateFirstname(),
//                          autocorrect: false,
//                          decoration: InputDecoration(
//                              labelText: "Home Address",
//                              labelStyle: TextStyle(color: Colors.white),
//                              isDense: true),
//                          style: Theme.of(context).textTheme.copyWith(bodyText1: Theme.of(context).textTheme.bodyText1.copyWith(color: Colors.white)).bodyText1,
//                        ),
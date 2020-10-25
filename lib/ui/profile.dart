import 'package:flushbar/flushbar.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_app/helpers/AppGlobal.dart';
import 'package:flutter_app/models/userProfileDTO.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:sliding_up_panel/sliding_up_panel.dart';
import 'package:flutter_app/services/customer.services.dart';
import 'Logout.dart';

class profile extends StatefulWidget {
  profile({Key key}) : super(key: key);
  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<profile> {
  _MyHomePageState();

  PanelController _pc2 = new PanelController();
  bool _visible = true;

  userProfileDTO user = new userProfileDTO('', '', '', '', '', '', '', '', '', '', '','','','','','');
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

  Widget flushBarMsg(final String message, final Color bgcolor, final IconData icon){
    return  Flushbar(
      flushbarPosition: FlushbarPosition.TOP,
      margin: EdgeInsets.all(8),
      icon: Icon(
        icon,
        size: 28.0,
        color: Colors.white,
      ),
      borderRadius: 8,
      message:  message,
      backgroundColor: bgcolor,
      duration:  Duration(seconds: 3),
    )..show(context);
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
    BorderRadiusGeometry radius = BorderRadius.only(
      topLeft: Radius.circular(24.0),
      topRight: Radius.circular(24.0),
    );
    return Scaffold(
      appBar:  _buildAppBar(),
      backgroundColor: kBlueColor,
      body: Stack(
        //mainAxisAlignment: MainAxisAlignment.end,
        children: <Widget>[
          new SingleChildScrollView(
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
                                        setState(() {
                                          _pc2.open();
                                          _visible = false;
                                        });
                                      },
                                      child: Text("Contact Us"),
                                    ),
                                    SizedBox(width: size.width * 0.41),
                                    GestureDetector(
                                        onTap: () {
                                          setState(() {
                                            _pc2.open();
                                            _visible = false;
                                          });
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
          ),
          Padding(
            padding: EdgeInsets.fromLTRB(30, 0, 30, 0),
            child:
            Visibility(
              maintainState: true,
              maintainAnimation: true,
              visible: !_visible,
              child: SlidingUpPanel(
                maxHeight: size.height * 0.6,
                controller: _pc2,
                panel: Container(
                  decoration: BoxDecoration(
                    color: kBlueColor,
                    //borderRadius: BorderRadius.all(Radius.circular(24.0)),
                  ),
                  child: Column(
                    mainAxisAlignment:  MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: <Widget>[
                      Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: GestureDetector(
                          child: Icon(Icons.cancel, color: Colors.white,),
                          onTap: (){
                            setState(() {
                              _pc2.close();
                              _visible = true;
                            });
                          },
                        ),
                      ),
                      SizedBox(height: size.height * 0.03),
                      Padding(
                        padding: EdgeInsets.fromLTRB(20, 0, 40, 15),
                        child: Text("You can reach us via our phone numbers, social "
                            "media platforms, email etc.",
                          style: TextStyle(color: Colors.white),),
                      ),
                      Padding(
                        padding: const EdgeInsets.fromLTRB(20, 0, 80, 0),
                        child: Container(
                          decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(8),
                              border: Border.all(color: Colors.white)
                          ),
                          child: Column(
                            children: <Widget>[
                              SizedBox(height: size.height * 0.03),
                              Row(
                                children: <Widget>[
                                  SizedBox(width: size.width * 0.02),
                                  Icon(Icons.phone, size: 18, color: Colors.white,),
                                  SizedBox(width: size.width * 0.02),
                                  GestureDetector(
                                    onTap: () {
                                    },
                                    child: Text("09084985923", style: TextStyle(color: Colors.white),),
                                  ),
                                  SizedBox(width: size.width * 0.32),
                                  GestureDetector(
                                      onTap: () {
                                        Clipboard.setData(ClipboardData(text: "09084985923"));
                                        flushBarMsg("Copied",Colors.green,  Icons.info_outline);
                                      },
                                    child: Text("Copy", style: TextStyle(color: Colors.white)),
                                  ),
                                ],
                              ),
                              SizedBox(height: size.height * 0.03),
                            ],
                          ),
                        ),
                      ),
                      SizedBox(height: size.height * 0.05),
                      Padding(
                        padding: const EdgeInsets.fromLTRB(20, 0, 80, 0),
                        child: Container(
                          decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(8),
                              border: Border.all(color: Colors.white)
                            //color: Colors.white
                          ),
                          child: Column(
                            children: <Widget>[
                              SizedBox(height: size.height * 0.03),
                              Row(
                                children: <Widget>[
                                  SizedBox(width: size.width * 0.02),
                                  Icon(Icons.mail, size: 18, color: Colors.white,),
                                  SizedBox(width: size.width * 0.02),
                                  GestureDetector(
                                    onTap: () {
                                    },
                                    child: Text("John.dhara@gmail.com", style: TextStyle(color: Colors.white),),
                                  ),
                                  SizedBox(width: size.width * 0.17),
                                  GestureDetector(
                                      onTap: () {
                                        Clipboard.setData(ClipboardData(text: "John.dhara@gmail.com"));
                                        flushBarMsg("Copied",Colors.green,  Icons.info_outline);
                                      },
                                    child: Text("Copy", style: TextStyle(color: Colors.white)),                                  ),
                                ],
                              ),
                              SizedBox(height: size.height * 0.03),
                            ],
                          ),
                        ),
                      ),
                      SizedBox(height: size.height * 0.05),
                      Padding(
                        padding: const EdgeInsets.fromLTRB(20, 0, 80, 0),
                        child: Container(
                          decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(8),
                              border: Border.all(color: Colors.white)
                            //color: Colors.white
                          ),
                          child: Column(
                            children: <Widget>[
                              SizedBox(height: size.height * 0.03),
                              Row(
                                children: <Widget>[
                                  SizedBox(width: size.width * 0.02),
                                  Icon(Icons.person_outline, size: 18, color: Colors.white),
                                  SizedBox(width: size.width * 0.02),
                                  GestureDetector(
                                    onTap: () {
                                    },
                                    child: Text("Personal Details", style: TextStyle(color: Colors.white)),
                                  ),
                                  SizedBox(width: size.width * 0.32),
                                  GestureDetector(
                                      onTap: () {
                                      },
                                      child: Icon(Icons.arrow_forward, size: 16, color: Colors.white)
                                  ),
                                ],
                              ),
                              SizedBox(height: size.height * 0.03),
                            ],
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
                collapsed: Container(
                  margin: const EdgeInsets.fromLTRB(24.0, 24.0, 24.0, 24.0),
                  decoration:
                  BoxDecoration(
                      borderRadius: BorderRadius.only(topLeft: Radius.circular(24.0), topRight: Radius.circular(24.0))),
                ),
                borderRadius: radius,
              ),
            ),
          ),
        ],
      ),
    );
  }
}

//Widget build(BuildContext context) {
//    PanelController _pc1 = new PanelController();
//    Size size = MediaQuery.of(context).size;
//    return Scaffold(
//        appBar: AppBar(
//          title: Text("SlidingUpPanelExample"),
//        ),
//        body: Stack(
//          children: <Widget>[
//            Center(child: Text("This is the Widget behind the sliding panel"),),
//            Column(
//              children: <Widget>[
//                Container(
//                  child: FlatButton(
//                    child: Text("OFF"),
//                    onPressed: (){
//                      setState(() {
//                        //_pc1.close();
//                        _visible = false;
//                      });
//                    },
//                  ),
//                ),
//                Container(
//                  child: FlatButton(
//                    child: Text("Toggle"),
//                    onPressed: (){
//                      setState(() {
//                       // _pc1.open();
//                        _visible = true;
//                      });
//                    },
//                  ),
//                ),
//              ],
//            ),
//            Visibility(
//              maintainState: true,
//              maintainAnimation: true,
//              visible: _visible,
//              child: SlidingUpPanel(
//                //defaultPanelState: PanelState.CLOSED,
//                controller: _pc1,
//                maxHeight: size.height * 0.7,
//                renderPanelSheet: false,
//                panel: _floatingPanel(),
//                collapsed: _floatingCollapsed(),
//                //borderRadius: radius,
//              )
//            ),
//          ],
//        )
//    );
//  }
//
//  Widget _floatingCollapsed(){
//    return Container(
//      decoration: BoxDecoration(
//        //color: Colors.blueGrey,
//        borderRadius: BorderRadius.only(topLeft: Radius.circular(24.0), topRight: Radius.circular(24.0)),
//      ),
//      margin: const EdgeInsets.fromLTRB(24.0, 24.0, 24.0, 0.0),
//      child: Center(
//      ),
//    );
//  }
//
//  Widget _floatingPanel(){
//    return Container(
//      decoration: BoxDecoration(
//          color: Colors.white,
//          borderRadius: BorderRadius.all(Radius.circular(24.0)),
//          boxShadow: [
//            BoxShadow(
//              blurRadius: 20.0,
//              color: Colors.grey,
//            ),
//          ]
//      ),
//      margin: const EdgeInsets.all(24.0),
//      child: Center(
//        child: Text("This is the SlidingUpPanel when open"),
//      ),
//    );
//  }
//                                        Flushbar(
//                                          flushbarPosition: FlushbarPosition.TOP,
//                                          margin: EdgeInsets.all(8),
//                                          icon: Icon(
//                                            Icons.info_outline,
//                                            size: 28.0,
//                                            color: Colors.white,
//                                          ),
//                                          borderRadius: 8,
//                                          message:  "Copied",
//                                          backgroundColor: Colors.green,
//                                          duration:  Duration(seconds: 3),
//                                        )..show(context);
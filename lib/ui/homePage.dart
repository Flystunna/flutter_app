import 'package:flutter/material.dart';
import 'package:flutter_app/models/userProfileDTO.dart';
import 'package:flutter_app/ui/userProfile.dart';
import 'package:flutter_app/services/customer.services.dart';

import 'Login.dart';

class HomePage extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => HomePageState();
}

class HomePageState extends State<HomePage> {
  userProfileDTO user = new userProfileDTO('', '', '', '', '', '', '', '', '', '', '','','','','','');

  Widget _buildDecoratedImage(Icons, String value) {
    return Container(
        decoration: BoxDecoration(
          //border: Border.all(width: 3, color: Colors.black38),
          borderRadius: const BorderRadius.all(const Radius.circular(70)),
        ),
        //margin: const EdgeInsets.all(4),
        child: Card(
            color: Colors.white,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                SizedBox(height: 4),
                Icon(Icons),
                SizedBox(height: 4),
                Padding(
                  padding: EdgeInsets.all(3),
                  child: GestureDetector(
                    onTap: () async {
                      //_navigateToLogin();
                      },
                    child: Text(value),
                  ),
                  //Text(value),
                ),
                SizedBox(height: 4),
              ],
            )));
  }
  Widget _buildBank(Icons, String value) {
    return Container(
        decoration: BoxDecoration(
          //border: Border.all(width: 3, color: Colors.black38),
          borderRadius: const BorderRadius.all(const Radius.circular(70)),
        ),
        //margin: const EdgeInsets.all(4),
        child: Card(
            color: Colors.white,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                SizedBox(height: 4),
                Icon(Icons),
                SizedBox(height: 4),
                Padding(
                  padding: EdgeInsets.all(3),
                  child: GestureDetector(
                    onTap: () {
                      //_navigateToProfile();
                    },
                    child: Text(value),
                  ),
                  //Text(value),
                ),
                SizedBox(height: 4),
              ],
            )));
  }
  Widget _buildMF(Icons, String value) {
    return Container(
        decoration: BoxDecoration(
          //border: Border.all(width: 3, color: Colors.black38),
          borderRadius: const BorderRadius.all(const Radius.circular(70)),
        ),
        //margin: const EdgeInsets.all(4),
        child: Card(
            color: Colors.white,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                SizedBox(height: 4),
                Icon(Icons),
                SizedBox(height: 4),
                Padding(
                  padding: EdgeInsets.all(3),
                  child: GestureDetector(
                    onTap: () {
                      //_navigateToLogin();
                    },
                    child: Text(value),
                  ),
                  //Text(value),
                ),
                SizedBox(height: 4),
              ],
            )));
  }
  Widget _buildPension(Icons, String value) {
    return Container(
        decoration: BoxDecoration(
          //border: Border.all(width: 3, color: Colors.black38),
          borderRadius: const BorderRadius.all(const Radius.circular(70)),
        ),
        //margin: const EdgeInsets.all(4),
        child: Card(
            color: Colors.white,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                SizedBox(height: 4),
                Icon(Icons),
                SizedBox(height: 4),
                Padding(
                  padding: EdgeInsets.all(3),
                  child: GestureDetector(
                    onTap: () {
                     // _navigateToLogin();
                    },
                    child: Text(value),
                  ),
                  //Text(value),
                ),
                SizedBox(height: 4),
              ],
            )));
  }
  void _navigateToLogin() async {
    await Navigator.pushReplacement(
        context,
        MaterialPageRoute(
            builder: (context) => Login()));
  }

//  void _navigateToProfile() async {
//    await Navigator.pushReplacement(
//        context,
//        MaterialPageRoute(
//            builder: (context) => userProfile()));
//  }

  getProfile() {
    customerService.GetProfile().then((resp) {
      //userProfileDTO model = new userProfileDTO('', '', '', '', '', '', '', '', '', '', '','','','','','');
      if (resp != null) {
        setState(() {
          user = resp;
        });
      }
    });
  }

  Widget _buildImageRow() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Expanded(child: _buildBank(Icons.account_balance, "My Bank")),
        Expanded(child: _buildMF(Icons.markunread_mailbox, "Mutual Funds")),
        Expanded(child: _buildPension(Icons.group, "Pensions")),
      ],
    );
  }

  Widget _buildRow2() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Expanded(child: _buildDecoratedImage(Icons.alternate_email, "@ Ease")),
        Expanded(child: _buildDecoratedImage(Icons.assignment_turned_in, "Insurance")),
        Expanded(child: _buildDecoratedImage(Icons.insert_chart, "Stocks")),
      ],
    );
  }

  Widget _buildColumn(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Container(
     // height: size.height * 0.02,
      decoration: BoxDecoration(),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Expanded( child:  _buildImageRow()),
          Expanded( child:  _buildRow2())
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Container(
      padding: EdgeInsets.all(10),
      height: size.height,
      color: Colors.blue[900],
      width: double.infinity,
      child: ListView(
        children: <Widget>[
          Column(
            children: <Widget>[
              Column(
                children: <Widget>[
                  Stack(
                    children: <Widget>[
                      Container(
                        child: Column(
                          children: <Widget>[
                            Row(
                                mainAxisAlignment: MainAxisAlignment.start,
                                children: <Widget>[
                                  Padding(
                                    padding: const EdgeInsets.all(15.0),
                                    child: CircleAvatar(
                                      //backgroundImage: AssetImage('images/pic.jpg'),
                                      radius: 30,
                                    ),
                                  ),
                                  SizedBox(
                                    width: size.width * 0.33,
                                  ),
                                  Padding(
                                    padding: const EdgeInsets.all(15.0),
                                    child: CircleAvatar(
                                      //backgroundImage: AssetImage('images/pic.jpg'),
                                      radius: 30,
                                    ),
                                  )
                                ]),
                            SizedBox(
                              height: size.height * 0.18,
                            ),
                            Center(
                                child: Row(mainAxisAlignment: MainAxisAlignment.center,
                                  children: <Widget>[
                                    Text("Dreams. ", style: TextStyle(color: Colors.white, fontSize: 18, fontWeight: FontWeight.w500)),
                                    Text("Possibilities.", style: TextStyle(color: Colors.white, fontSize: 18, fontWeight: FontWeight.bold))
                              ],
                            )),
                            Center(
                                child: Row(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: <Widget>[
                                    Text("IT CAN BE ", style: TextStyle(fontSize: 35, color: Colors.white, fontStyle: FontStyle.italic, fontWeight: FontWeight.w800)),
                                    Text("TM", textAlign: TextAlign.end, style: TextStyle(fontSize: 8, color: Colors.white,))
                              ],
                            )),
                            SizedBox(height: size.height * 0.18),
                          ],
                        ),
                        //height: 255,
                        decoration: BoxDecoration(
                            borderRadius: const BorderRadius.all(const Radius.circular(15)),
                            gradient: LinearGradient(colors: [Colors.blue[800], Colors.purple[600],
                            ])),
                      ),
                    ],
                  ),
                  SizedBox(height: size.height * 0.02),
                  Container(height: size.height * 0.30, child: _buildColumn(context)),
                ],
              )
            ],
          ),
        ],
      ),
    );
  }
}

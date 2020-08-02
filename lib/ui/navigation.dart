import 'package:flutter/material.dart';
import 'package:flutter_app/models/EmployeeDTO.dart';
import 'package:flutter_app/services/token.services.dart';
import 'package:flutter_app/ui/welcome/SilverApp.dart';
import 'package:flutter_app/ui/welcome/welcome.dart';
import 'dart:convert';
import 'Login.dart';
import 'Logout.dart';
import 'addemployeePage.dart';
import 'employeesPage.dart';
import 'package:flutter_app/services/employee.services.dart';

import 'homePage.dart';


class navigation extends StatefulWidget {
  navigation({Key key}) : super(key: key);
  @override
  _MyAppState createState() => _MyAppState();
}

class _MyAppState extends State<navigation> {
  int _selectedTabIndex = 0;
  List<EmployeeDTO> employees;
  EmployeeDTO emp;
  int employeeCount;
  getEmployee() {
    employeeServices.fetchEmployee().then((response) {
      Iterable list = json.decode(response.body);
      List<EmployeeDTO> employeeList = List<EmployeeDTO>();
      employeeList = list.map((model) => EmployeeDTO.fromObject(model)).toList();
      setState(() {
        employees = employeeList;
        employeeCount = employeeList.length;
      });
    });
  }
  List _pages = [
    HomePage(),
    EmployeesPage(),
    AddEmployeePage(EmployeeDTO('','','','','','','',1,'','','','',1,'','')),
    SliverAppBarPage(),
    Logout()
  ];

  _changeIndex(int index) {
    setState(() {
      _selectedTabIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    getEmployee();
    return Scaffold(
      body: Center(child: _pages[_selectedTabIndex]),
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: _selectedTabIndex,
        onTap: _changeIndex,
        iconSize: 22.0,
        selectedFontSize: 12.0,
        type: BottomNavigationBarType.fixed,
        items: [
          BottomNavigationBarItem(icon: Icon(Icons.account_balance),  title: Text("Welcome")),
          BottomNavigationBarItem(icon: new Stack(
            children: <Widget>[
              new Icon(Icons.people),
              new Positioned(top: 0, right: 0.0, child: employeeCount != null ?
              new Container(padding: EdgeInsets.all(1),
                  decoration: new BoxDecoration(color: Colors.red, borderRadius: BorderRadius.circular(6)),
                  constraints: BoxConstraints(minHeight: 9, minWidth: 9),
                  child: new Text('$employeeCount', style: new TextStyle(color: Colors.white, fontSize: 8),
                      textAlign: TextAlign.center)) :
              new Container(padding: EdgeInsets.all(1), child: new Text("")))
            ],
          ),
            title: Text("Notifications"),
          ),
          BottomNavigationBarItem(icon: Icon(Icons.person_add), title: Text("New")),
          BottomNavigationBarItem(icon: Icon(Icons.settings_applications), title: Text("Settings")),
          BottomNavigationBarItem(icon: Icon(Icons.power_settings_new), title: Text("Logout"),)
        ],
      ),
    );
  }
}
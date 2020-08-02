import 'dart:convert';
import 'dart:developer';
import 'package:flutter/material.dart';
import 'package:flutter_app/helpers/AppGlobal.dart';
import 'package:flutter_app/main.dart';
import 'package:flutter_app/models/EmployeeDTO.dart';
import 'package:flutter_app/services/employee.services.dart';
import 'package:flutter_app/ui/welcome/Login/components/background.dart';

import 'addemployeePage.dart';

class EmployeesPage extends StatefulWidget {
  EmployeesPage({Key key}) : super(key: key);
  @override
  State<StatefulWidget> createState() => _EmployeeState();
}

class _EmployeeState extends State<EmployeesPage> {
  List<EmployeeDTO> employees;
  EmployeeDTO emp;
  int employeeCount;
  getEmployee() {
    employeeServices.fetchEmployee().then((response) {
      Iterable list = json.decode(response.body);
      List<EmployeeDTO> employeeList = List<EmployeeDTO>();
      employeeList = list.map((model) => EmployeeDTO.fromObject(model)).toList();
      //var nnn = employeeList != null ? employeeList.first : null;
      setState(() {
        employees = employeeList;
        employeeCount = employeeList.length;
      });
    });
  }

  @override
  void dispose(){
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    getEmployee();
    return Scaffold(
      backgroundColor: kBlueColor,
      appBar: _buildAppBar(),
      body: employees == null
          ? Center(child: Text('No Employee Found'))
          : Center(child: _buildList()),
      floatingActionButton: FloatingActionButton.extended(
        onPressed: () {
          _navigateToNewEmployee();
        },
        label: Text('New Employee'),
        icon: Icon(Icons.person_add),
        backgroundColor: Colors.pink,
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.endFloat,
    );
  }

  Widget _buildAppBar() {
    return AppBar(
      elevation: 0,
      title: Text('List of Employees'),
      centerTitle: false,
      actions: <Widget>[
        IconButton(
          icon: Icon(Icons.menu
              // Icons.menu
              // Icons.filter_list
              //Icons.list
              //Icons.dehaze
              ),
          color: Colors.white,
          onPressed: () {},
        )
      ],
    );
  }

  Widget _buildList() {
    return Background(
        child: Container(
          child: ListView.builder(
            itemCount: employees.length,
            itemBuilder: (context, index) {
              return Column(
                children: <Widget>[
                  Card(color: Colors.white, shape: new RoundedRectangleBorder(borderRadius: BorderRadius.circular(20.0)),
                    elevation: 1.0,
                    child: ListTile(title: ListTile(leading: CircleAvatar(backgroundColor: Colors.blue,),
                        title: Text(employees[index].firstName +
                          " " +
                          employees[index].lastName),
                        subtitle: Text(employees[index].email),
                        onLongPress: null,
                        onTap: () {
                        // _navigateToDetailsPage(this.employees[index]);
                           _navigateToEmployee(this.employees[index]);
                          }),
                    ),
                  )
                ],
              );},
          ),
        )
    );
  }

  void _navigateToDetailsPage(EmployeeDTO employee) async {
    await Navigator.push(context,
        new MaterialPageRoute(builder: (context) => DetailsPage(employee)));
  }

  void _navigateToNewEmployee() async {
    await Navigator.push(
        context,
        MaterialPageRoute(
            builder: (context) => AddEmployeePage(EmployeeDTO(
                '', '', '', '', '', '', '', 1, '', '', '', '', 1,'',''))));
  }

  void _navigateToEmployee(EmployeeDTO employee) async {
    await Navigator.push(context,
        MaterialPageRoute(builder: (context) => AddEmployeePage(employee)));
  }
}

class DetailsPage extends StatelessWidget {
  final EmployeeDTO employee;

  DetailsPage(this.employee);

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return Scaffold(
      appBar: AppBar(
        title: Text(employee.firstName),
      ),
    );
  }
}

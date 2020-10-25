import 'dart:convert';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_app/helpers/AppGlobal.dart';
import 'package:flutter_app/models/EmployeeDTO.dart';
import 'package:flutter_app/services/employee.services.dart';
import 'package:flutter_app/ui/welcome/Login/components/background.dart';
import 'package:intl/intl.dart';
import 'employeesPage.dart';

class AddEmployeePage extends StatefulWidget {
  final EmployeeDTO employee;
  AddEmployeePage(this.employee);

  @override
  State<StatefulWidget> createState() => _AddEmployeeState(employee);
}

class _AddEmployeeState extends State<AddEmployeePage> {
  EmployeeDTO employee;
  _AddEmployeeState(this.employee);
  //final _formKey = GlobalKey<FormState>();
  var firstNameController = TextEditingController();
  var lastNameController = TextEditingController();
  var emailController = TextEditingController();
  var phoneController = TextEditingController();
  var addressController = TextEditingController();
  var empCodeController = TextEditingController();
  var creationTimeController = TextEditingController();
  var doeController =TextEditingController();
  var textStyle = TextStyle();
  List<String> _genders = ['Male', 'Female', 'Rather Not Say'];
  String _selectedGender;
  final key = new GlobalKey<ScaffoldState>();
  bool _validate = false;
  bool _submitted = false;
  DateTime pickedDate;
  TimeOfDay time;

  @override
  void initState() {
    super.initState();
    if(employee.dateOfEmployment != null){
      if(employee.dateOfEmployment.length != 0){
        pickedDate = DateFormat("yyyy-MM-dd").parse(employee.dateOfEmployment);
      }
    }
    pickedDate = pickedDate != null ? pickedDate : DateTime.now();
    time = TimeOfDay.now();
  }
  @override
  Widget build(BuildContext context) {
    firstNameController.text = employee.firstName;
    lastNameController.text = employee.lastName;
    emailController.text = employee.email;
    phoneController.text = employee.phoneNumber;
    addressController.text = employee.address;
    empCodeController.text = employee.employeeCode;
    textStyle = Theme.of(context).textTheme.headline6;
    // TODO: implement build
    return Scaffold(
      key: key,
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[
          Expanded(child: _buildForm()),
        ],
      ),
    );
  }

  Widget _buildAppBar() {
    return AppBar(
      title: employee.id == null ? Text('Sign Up Employee') : Text('Update Employee'),
      backgroundColor: Colors.lightBlueAccent,
    );
  }

  Widget _buildForm() {
    return Background(
        //key: _formKey,
        child: Container(
            decoration: new BoxDecoration(
              borderRadius: BorderRadius.circular(30.0),
            ),
            child: ListView(
              shrinkWrap: true,
              scrollDirection: Axis.vertical,
              padding: EdgeInsets.only(top: 35.0, left: 35.0, right: 35.0),
              children: <Widget>[
                SizedBox(height: 10),
                Text(
                  employee.id == null ? 'SIGN UP' : 'UPDATE PROFILE',
                  style: TextStyle(fontWeight: FontWeight.bold, fontSize: 18),
                  textAlign: TextAlign.center,
                ),
                SizedBox(height: 30),
                Text(_submitted == true && _validate == true ? 'All fields are mandatory' : '', textAlign: TextAlign.center, style: new TextStyle(color: Colors.red, fontSize: 14, fontFamily: 'calibri'),),
                SizedBox(height: 10),
                Container(
                  child: TextFormField(
                      controller: firstNameController,
                      style: TextStyle(
                          fontSize: 14.0, height: 1.0, color: Colors.black),
                      onChanged: (value) => updateFirstName(),
                      keyboardType: TextInputType.emailAddress,
                      decoration: InputDecoration(
                        isDense: true,
                        contentPadding: EdgeInsets.all(12.0),
                        labelText: 'First Name',
                        hintText: 'What Should We Call You?',
                        //errorText: firstNameController.text.length <= 1 ? 'First Name is required' : null,
                        prefixIcon: const Icon(Icons.person_outline,
                            color: Colors.green),
                        border: OutlineInputBorder(
                            borderSide:
                                new BorderSide(color: Colors.tealAccent),
                            borderRadius: BorderRadius.circular(35.0)),
                      )),
                ),
                SizedBox(height: 10),
                Container(
                  child: TextField(
                      controller: lastNameController,
                      style: TextStyle(
                          fontSize: 14.0, height: 1.0, color: Colors.black),
                      onChanged: (value) => updateLastName(),
                      keyboardType: TextInputType.emailAddress,
                      decoration: InputDecoration(
                        isDense: true,
                        contentPadding: EdgeInsets.all(12.0),
                        labelText: 'Last Name',
                        hintText: 'We Believe You Should Have One',
                        //errorText: lastNameController.text.length <= 1  ? 'Last Name is required' : null,
                        prefixIcon:
                            const Icon(Icons.person, color: Colors.green),
                        border: OutlineInputBorder(
                            borderSide:
                                new BorderSide(color: Colors.tealAccent),
                            borderRadius: BorderRadius.circular(35.0)),
                      )),
                ),
                SizedBox(height: 10),
                Container(
                  child: TextField(
                      controller: emailController,
                      style: TextStyle(
                          fontSize: 14.0, height: 1.0, color: Colors.black),
                      onChanged: (value) => updateEmail(),
                      keyboardType: TextInputType.emailAddress,
                      decoration: InputDecoration(
                        isDense: true,
                        contentPadding: EdgeInsets.all(12.0),
                        labelText: 'Email Address',
                        hintText: 'How Will You Get Our Alerts?',
                       // errorText: _validate ? 'Email field Can\'t Be Empty' : null,
                        prefixIcon: const Icon(Icons.mail, color: Colors.green),
                        border: OutlineInputBorder(
                            borderSide:
                                new BorderSide(color: Colors.tealAccent),
                            borderRadius: BorderRadius.circular(35.0)),
                      )),
                ),
                SizedBox(height: 10),
                Container(
                  child: TextField(
                      controller: phoneController,
                      style: TextStyle(
                          fontSize: 14.0, height: 1.0, color: Colors.black),
                      onChanged: (value) => updatePhone(),
                      keyboardType: TextInputType.phone,
                      decoration: InputDecoration(
                        isDense: true,
                        contentPadding: EdgeInsets.all(10.0),
                        labelText: 'Phone Number',
                        hintText: 'We Will Like To Keep In Touch',
                        //helperText: 'Keep it accurate',
                        prefixIcon:
                            const Icon(Icons.phone, color: Colors.green),
                        border: OutlineInputBorder(
                            borderSide:
                                new BorderSide(color: Colors.tealAccent),
                            borderRadius: BorderRadius.circular(35.0)),
                      )),
                ),
                SizedBox(height: 10),
                Container(
                  child: TextField(
                      controller: empCodeController,
                      style: TextStyle(
                          fontSize: 14.0, height: 1.0, color: Colors.black),
                      onChanged: (value) => updateEmpCode(),
                      keyboardType: TextInputType.text,
                      decoration: InputDecoration(
                        isDense: true,
                        contentPadding: EdgeInsets.all(10.0),
                        labelText: 'Employee Code',
                        hintText: 'Unique Code',
                        //helperText: 'Keep it accurate',
                        prefixIcon:
                            const Icon(Icons.voicemail, color: Colors.green),
                        border: OutlineInputBorder(
                            borderSide:
                                new BorderSide(color: Colors.tealAccent),
                            borderRadius: BorderRadius.circular(35.0)),
                      )),
                ),
                SizedBox(height: 10),
                Container(
                  child: TextField(
                      controller: addressController,
                      style: TextStyle(
                          fontSize: 14.0, height: 1.0, color: Colors.black),
                      onChanged: (value) => updateAddress(),
                      keyboardType: TextInputType.text,
                      decoration: InputDecoration(
                        isDense: true,
                        contentPadding: EdgeInsets.all(10.0),
                        labelText: 'Home Address',
                        hintText: 'Got a Home Addy?',
                        //helperText: 'Keep it accurate',
                        prefixIcon: const Icon(Icons.home, color: Colors.green),
                        border: OutlineInputBorder(
                            borderSide:
                                new BorderSide(color: Colors.tealAccent),
                            borderRadius: BorderRadius.circular(35.0)),
                      )),
                ),
                SizedBox(height: 10),
                ListTile(
                    title: Text("Employment Date: ${pickedDate.year}-${pickedDate.month}-${pickedDate.day}",style: TextStyle(fontSize: 14),),
                    trailing: Icon(Icons.keyboard_arrow_down),
                    onTap: _pickDate,
                ),
                SizedBox(height: 10),
                Container(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: <Widget>[
                      Text("Gender: "), SizedBox(height: 10),
                      employee.id == null ?
                      DropdownButton(
                          icon: Icon(Icons.arrow_drop_down),
                          isDense: true,
                          iconSize: 14,
                          elevation: 16,
                          value: _selectedGender,
                          items: _genders.map((gender) {
                            return DropdownMenuItem(child: new Text(gender), value: gender);
                          }).toList(),
                          onChanged: (gender) {
                            setState(() {
                              _selectedGender = gender;
                              updateGender(gender);
                            });
                          }) : new Text(GenderString(employee.gender.toString())),
                    ],
                  ),
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: <Widget>[
                    FlatButton(
                      shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(18.0)),
                      color: kPrimaryColor,
                      textColor: Colors.white,
                      padding: EdgeInsets.all(8.0),
                      onPressed: () {
                        setStateValue(firstNameController.text);
                        setStateValue(lastNameController.text);
                        setStateValue(emailController.text);
                        setStateValue(phoneController.text);
                        setStateValue(empCodeController.text);
                        setStateValue(addressController.text);
                        if(!_validate && _submitted){
                          employee.id == null ? SaveEmployee() : UpdateEmployee();
                        }
                      },
                      child: employee.id == null ? Text("Submit", style: TextStyle(fontSize: 14.0)) : Text("Update Profile", style: TextStyle(fontSize: 14.0)),
                    ),
                    SizedBox(width: 12),
                    RaisedButton(
                      shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(18.0)),
                      onPressed: () {
                        _navigateToEmployeePage(context);
                      },
                      color: Colors.blue,
                      textColor: Colors.white,
                      child: Text("View Employees", style: TextStyle(fontSize: 14)),
                    ),
                  ],
                ),
              ],
            )));
  }
  _pickDate() async {
    DateTime date = await showDatePicker(
      context: context,
      firstDate: DateTime(DateTime.now().year-5),
      lastDate: DateTime(DateTime.now().year+5),
      initialDate: pickedDate,
    );
    if(date != null)
      setState(() {
        pickedDate = date;
      });
  }
  void setStateValue(String controllerText){
    setState(() {
      _submitted = true;
      controllerText.isEmpty ? _validate = true : _validate = false;
    });
  }
  void updateFirstName() {
    employee.firstName = firstNameController.text.trim();
  }

  void updateLastName() {
    employee.lastName = lastNameController.text.trim();
  }

  void updateEmail() {
    employee.email = emailController.text.trim();
  }

  void updateAddress() {
    employee.address = addressController.text.trim();
  }

  void updateEmpCode() {
    employee.employeeCode = empCodeController.text.trim();
  }

  void updatePhone() {
    employee.phoneNumber = phoneController.text.trim();
  }

  // ignore: non_constant_identifier_names
  void SnackBarToEmployeeList() {
    key.currentState.showSnackBar(new SnackBar(
        content: new Text("Account Created Successfully"),
        action: SnackBarAction(
            label: "Login",
            textColor: Colors.white,
            onPressed: () {
              key.currentState.hideCurrentSnackBar();
              Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => EmployeesPage(),
                  ));
            }),
        backgroundColor: Colors.green,
        duration: Duration(minutes: 3)));
//If No Input, Automatic redirect after 2 seconds
    new Future<Null>.delayed(Duration(seconds: 2), () {
      Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => EmployeesPage(),
          ));
    });
  }

  void ShowAddEmployeeError(String error) {
    key.currentState.showSnackBar(new SnackBar(
        content: new Text(error),
        action: SnackBarAction(
            label: "",
            textColor: Colors.white,
            onPressed: () {
              key.currentState.hideCurrentSnackBar();
            }),
        backgroundColor: Colors.red,
        duration: Duration(minutes: 3)));
    //If No Input,  close snackbar after 2 seconds
    new Future<Null>.delayed(Duration(seconds: 5), () {
      key.currentState.hideCurrentSnackBar();
    });
  }

  void SaveEmployee() async {
    employee.dateOfEmployment = '${pickedDate.year}-${pickedDate.month}-${pickedDate.day}';
    var save = await employeeServices.addEmployee(employee);
    save == "Account Created Successfully"
        ? SnackBarToEmployeeList()
        : ShowAddEmployeeError(save);
  }

  void UpdateEmployee() async {
    employee.dateOfEmployment = '${pickedDate.year}-${pickedDate.month}-${pickedDate.day}';
    var update = await employeeServices.updateEmployee(employee.id, employee);
    update.statusCode == 200 ? Navigator.pop(context, true) : null;
  }

  void updateGender(String value) {
    switch (value) {
      case "Male":
        employee.gender = 0;
        break;
      case "Female":
        employee.gender = 1;
        break;
      case "Rather Not Say":
        employee.gender = 2;
        break;
      default:
    }
  }

  String GenderString(String value) {
    switch (value) {
      case "0":
        return 'Male';
        break;
      case "1":
        return 'Female';
        break;
      case "2":
        return 'Rather not say';
        break;
      default:
    }
  }

  void _navigateToEmployeePage(BuildContext context) {
    Navigator.pushReplacement(context, MaterialPageRoute(builder: (context) => EmployeesPage()));
//    Navigator.push(
//        context,
//        MaterialPageRoute(
//          builder: (context) => EmployeesPage(),
//        ));
  }
}
//Padding(
//padding: EdgeInsets.only(top: 10.0, right: 50.0, left: 50.0, bottom:20.0),
//child: RaisedButton(
//textColor: Colors.white,
//color: Colors.green,
//child: Text("Submit"),
//onPressed: () {},
//shape: new RoundedRectangleBorder(
//borderRadius: new BorderRadius.circular(30.0),
//),
//),
//)
//Container(
//          child: DropdownButton(
//            hint: Text('Please choose a location'), // Not necessary for Option 1
//            value: _selectedGender,
//            icon: Icon(Icons.arrow_downward),
//            iconSize: 24,
//            elevation: 16,
//            style: TextStyle(color: Colors.deepPurple),
//            onChanged: (newValue) {
//              setState(() {
//                _selectedGender = newValue;
//              });
//            },
//            //style: TextStyle(fontSize: 14.0, fontFamily: 'Arial', height: 1.0, color: Colors.black),
//            items: _genders.map((location) {
//              return DropdownMenuItem(
//                child: new Text(location),
//                value: location,
//              );
//            }).toList(),
//          ),
//        ),

//      floatingActionButton: FloatingActionButton.extended(
//        onPressed: () {
//          _navigateToEmployeePage(context);// Add your onPressed code here!
//        },
//        label: Text('Employees'),
//        icon: Icon(Icons.people),
//        backgroundColor: Colors.pink,
//      ),
//      floatingActionButtonLocation: FloatingActionButtonLocation.endDocked,

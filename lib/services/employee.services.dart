import 'dart:convert' as convert;
import 'dart:convert';
import 'package:flutter_app/models/BaseResponse.dart';
import 'package:flutter_app/models/EmployeeDTO.dart';
import 'package:http/http.dart' as http;

import '../helpers/AppGlobal.dart';
import '../models/PagedResponse.dart';

// ignore: camel_case_types
class employeeServices{
  static String baseURL = AppGlobal.baseURL.trim();
  static String employeeURL = baseURL + "/api/employee/GetEmployeeList2";
  static String addEmployeeURL = baseURL + "/api/employee/AddEmployee";
  static String updateEmployeeURL = baseURL+"/api/employee/Update";

  static Map<String, String> header = {
    'Content-type': 'application/json',
    'Accept': 'application/json'
  };

  static Future fetchEmployee() async {
    var response = await http.get(employeeURL);
    if (response.statusCode == 200) {
      return response;
    } else {
      print('Request failed with status: ${response.statusCode}.');
    }
  }

  static Future<String> addEmployee(EmployeeDTO model) async {
    var body = json.encode(model.toMap());
    var response = await http.post(addEmployeeURL, headers: header, body: body);
    if (response.statusCode == 200) {
      var decoded = json.decode(response.body);
      var responsePayload = BaseResponse<String>.fromJson(json.decode(response.body));
      return responsePayload.shortDescription;
    } else {
      print('Request failed with status: ${response.statusCode}.');
      return "Request Failed, Please Try Again";
    }
  }


  static Future<http.Response> updateEmployee(int id, EmployeeDTO emp) async {
    var postUrl = updateEmployeeURL;
    var body = json.encode(emp.toMap());
    var response = await http.post(postUrl, headers: header,body: body);
    if (response.statusCode == 200) {
      var decoded = json.decode(response.body);
      //var decodedstring = decoded.toString();
      return response;
    } else {
      print('Request failed with status: ${response.statusCode}.');
      return response;
    }
  }
}

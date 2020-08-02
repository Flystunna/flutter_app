
import 'dart:convert';

import 'package:flutter_app/helpers/AppGlobal.dart';
import 'package:flutter_app/models/BaseResponse.dart';
import 'package:flutter_app/models/LoginModel.dart';
import 'package:flutter_app/models/tokenDTO.dart';
import 'package:flutter_app/models/userDTO.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:flutter_app/services/storageUtil.dart';
import 'package:http/http.dart' as http;
import 'package:intl/intl.dart';

class customerService {
  static String tokenURL = AppGlobal.baseURL + "/api/token/auth";
  static String registerURL = AppGlobal.baseURL + "/api/account/AddUser";
  static String activateURL = AppGlobal.baseURL + "/api/account/Activate";
  static Map<String, String> header = {
    'Content-type': 'application/json',
    'Accept': 'application/json'
  };

 static Future<BaseResponse<userDTO>> ConfirmAccount(userDTO model) async {
   try {
     model.username = await StorageUtil().get_username();
     var body = json.encode(model.toMap());
     var response = await http.post(activateURL, headers: header, body: body);
     if (response.statusCode == 200) {
       var jsonResponse = json.decode(response.body);
       var jsonObject = jsonResponse['object'];
       var baseResponse = new BaseResponse<userDTO>();
       if(jsonObject != null){
         var deserialize = userDTO.fromObject(jsonObject);
         baseResponse.object = deserialize;
       }
       baseResponse.code = jsonResponse['code'];
       baseResponse.shortDescription = jsonResponse['shortDescription'];
       return baseResponse;
     } else {
       print('Request failed with status: ${response.statusCode}.');
       return null;
     }
   } on  Exception catch(exception){
  }catch(error){
   }
 }

  static Future<BaseResponse<String>> Register(userDTO model) async {
    var body = json.encode(model.toMap());
    var response = await http.post(registerURL, headers: header, body: body);
    if (response.statusCode == 200) {
      var jsonResponse = json.decode(response.body);
      var jsonObject = jsonResponse['object'];
      var baseResponse = new BaseResponse<String>();
      var deserialize = jsonObject.toString();
      baseResponse.object = deserialize;
      baseResponse.code = jsonResponse['code'];
      baseResponse.shortDescription = jsonResponse['shortDescription'];
      if(deserialize == 'true'){
        final storage = new FlutterSecureStorage();
        await storage.write(key: "username", value: model.email.toString());
      }
      return baseResponse;
    } else {
      print('Request failed with status: ${response.statusCode}.');
      return null;
    }
  }
}



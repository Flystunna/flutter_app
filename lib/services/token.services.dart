import 'dart:convert';
import 'dart:math';
import 'package:flutter/material.dart';
import 'package:flutter_app/helpers/AppGlobal.dart';
import 'package:flutter_app/models/BaseResponse.dart';
import 'package:flutter_app/models/LoginModel.dart';
import 'package:flutter_app/models/refreshTokenModel.dart';
import 'package:flutter_app/models/tokenDTO.dart';
import 'package:flutter_app/services/storageUtil.dart';
import 'package:http/http.dart' as http;
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:intl/intl.dart';

class tokenService {
  static String tokenURL = AppGlobal.baseURL + "/api/token/auth";
  static String refreshTokenURL = AppGlobal.baseURL + "/api/token/RefreshToken";
  static Map<String, String> header = {
    'Content-type': 'application/json',
    'Accept': 'application/json'
  };

  static Future<BaseResponse<tokenDTO>> RefreshToken(RefreshTokenModel model) async {
    var body = json.encode(model.toMap());
    var response = await http.post(
        refreshTokenURL, headers: header, body: body);
    if (response.statusCode == 200) {
      var jsonResponse = json.decode(response.body);
      var jsonObject = jsonResponse['object'];
      var baseResponse = new BaseResponse<tokenDTO>();
      if (jsonObject != null) {
        var deserialize = tokenDTO.fromObject(jsonObject);
        DateTime toExpire = DateTime.now().add(
            Duration(hours: deserialize.validity));
        String date = DateFormat("yyyy-MM-dd hh:mm:ss").format(toExpire);
        baseResponse.object = deserialize;
        final storage = new FlutterSecureStorage();
        await storage.write(key: "access_token", value: deserialize.token);
        await storage.write(key: "refresh_token", value: deserialize.refreshToken);
        await storage.write(key: "isAuth", value: 'true');
        await storage.write(key: "expires", value: date);
      }
      baseResponse.code = jsonResponse['code'];
      baseResponse.shortDescription = jsonResponse['shortDescription'];
      return baseResponse;
    } else {
      print('Request failed with status: ${response.statusCode}.');
      return null;
    }
  }

  static Future<bool> isTokenValid() async {
    final storage = new FlutterSecureStorage();
    String expires = await storage.read(key: 'expires');
    //convert to datetime
    if(expires != null || expires.length != 0){
      DateTime dateExpires = DateTime.parse(expires);
      if (dateExpires.isAfter(DateTime.now())) {
        return true;
      }
      else {
        return false;
      }
    }
    else{
      return false;
    }
  }

  Future<String> isLoggedin() async {
    final storage = new FlutterSecureStorage();
    String auth = await storage.read(key: 'isAuth');
    if(auth != null){
        return auth;
    }
    else {
      return "";
    }
  }

  static Future<bool> logout() async{
    await StorageUtil().delete_all();
    return true;
  }

  static Future<bool> Tokenize() async {
    String access_token = await StorageUtil().get_access_token();
    String refresh_token = await StorageUtil().get_refresh_token();
    var newrefresh = new RefreshTokenModel();
    newrefresh.token = access_token;
    newrefresh.refreshToken = refresh_token;
    await RefreshToken(newrefresh);
  }

  static Future<BaseResponse<tokenDTO>> login(LoginModel model) async {
    final storage = new FlutterSecureStorage();
    var body = json.encode(model.toMap());
    var response = await http.post(tokenURL, headers: header, body: body);
    if (response.statusCode == 200) {
      var jsonResponse = json.decode(response.body);
      var jsonObject = jsonResponse['object'];
      var baseResponse = new BaseResponse<tokenDTO>();
      if(jsonObject != null) {
        var deserialize = tokenDTO.fromObject(jsonObject);
        DateTime toExpire = DateTime.now().add(Duration(hours: deserialize.validity));
        String date = DateFormat("yyyy-MM-dd hh:mm:ss").format(toExpire);
        baseResponse.object = deserialize;
        baseResponse.object.username = model.userName;
        await StorageUtil().write_access_token(deserialize.token != null ? deserialize.token : "");
        await StorageUtil().write_refresh_token(deserialize.refreshToken != null ? deserialize.refreshToken : "");
        await StorageUtil().write_isAuth(deserialize.token != null ? 'true' :  "");
        await StorageUtil().write_expires(date != null ? date : "");
//        await storage.write(key: "access_token", value: deserialize.token);
//        await storage.write(key: "refresh_token", value: deserialize.refreshToken);
//        await storage.write(key: "isAuth",  value: cc);
//        await storage.write(key: "expires", value: date);
      }
      baseResponse.code = jsonResponse['code'];
      baseResponse.shortDescription = jsonResponse['shortDescription'];
      return baseResponse;
    } else {
      print('Request failed with status: ${response.statusCode}.');
      return null;
    }
  }
}


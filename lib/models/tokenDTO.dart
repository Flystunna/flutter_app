class tokenDTO {
  String _token;
  String _refreshToken;
  int _validity;
  String _expires;
  String _username;

  tokenDTO(this._refreshToken, this._token, this._validity, this._expires, this._username);

  int get validity=> _validity;
  String get refreshToken => _refreshToken;
  String get token => _token;
  String get username => _username;
  String  get expires=> _expires;

  set validity(int newId){
    _validity = newId;
  }
  set refreshToken(String newLocationId){
    _refreshToken = newLocationId;
  }
  set token(String newGender){
    _token = newGender;
  }
  set username(String newGender){
    _username = newGender;
  }
  set expires(String newGender){
    _expires = newGender;
  }
  Map<String, dynamic> toMap()
  {
    var map = Map<String, dynamic>();
    map["token"]= _token;
    map["refreshToken"]= _refreshToken;
    map["validity"]= _validity;
    map["expires"] = _expires;
    map["username"] = _username;
    return map;
  }

  tokenDTO.fromObject(dynamic o){
    this._refreshToken =o["refreshToken"];
    this._token =o["token"];
    this._validity =o["validity"] as int;
    this._expires =o["expires"];
    this._username =o["username"];
  }

//  factory tokenDTO.fromJson(Map<String, dynamic> parsedJson){
//    final token = parsedJson['token'];
//    final refreshToken = parsedJson['refreshToken'];
//    final validity = parsedJson['validity'] as int;
//    final expires = parsedJson['expires'] as DateTime;
//    final username = parsedJson['username'] as String;
//    return tokenDTO(
//        _token: token,
//        validity: validity,
//        refreshToken: refreshToken,
//        expires: expires,
//        username: username
//    );
//  }
}


//import 'package:flutter_app/models/BaseResponse.dart';
//
//class tokenDTO extends BaseResponse {
//  String token;
//  String refreshToken;
//  int validity;
//
//  tokenDTO({code, object, shortDescription, this.refreshToken, this.token, this.validity}) : super.fromJson(null);
//
//  factory tokenDTO.fromJson(Map<String, dynamic> parsedJson){
//    final baseResponse = BaseResponse.fromJson(parsedJson);
//    final token = parsedJson['token'];
//    final refreshToken = parsedJson['refreshToken'];
//    final validity = parsedJson['validity'] as int;
//    return tokenDTO(
//      shortDescription: baseResponse.shortDescription,
//      token: token,
//      validity: validity,
//      refreshToken: refreshToken,
//      code: baseResponse.code,
//      object: baseResponse.object
//    );
//  }
//}

// tokenDTO.fromJson(Map<String, dynamic> parsedJson, this.token, this.refreshToken, this.validity) : super.fromJson(parsedJson);

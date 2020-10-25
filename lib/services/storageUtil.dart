import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:shared_preferences/shared_preferences.dart';

class StorageUtil{
  final storage = new FlutterSecureStorage();

  Future<String> get_email() async {
    final prefs = await SharedPreferences.getInstance();
    prefs.getString("email") ?? "NA";
  }
  Future<String> get_access_token() async {
    String accesstoken = await storage.read(key: 'access_token');
    return accesstoken;
  }
  Future<String> get_username() async {
    String username = await storage.read(key: 'username');
    return username;
  }
  Future<String> get_refresh_token() async {
    String refreshtoken = await storage.read(key: 'refresh_token');
    return refreshtoken;
  }
  Future<String> get_isAuth() async {
    String isAuth = await storage.read(key: 'isAuth');
    return isAuth;
  }
  Future<String> get_expires() async {
    String expires = await storage.read(key: 'expires');
    return expires;
  }

  Future<void> write_access_token(String value) async {
    await storage.write(key: "access_token", value: value);
  }
  Future<void> write_refresh_token(String value) async {
    await storage.write(key: "refresh_token", value: value);
  }
  Future<void> write_isAuth(String value) async {
    await storage.write(key: "isAuth", value: value);
  }
  Future<void> write_expires(String value) async {
    await storage.write(key: "expires", value: value);
  }
  Future<void> write_username(String value) async {
    await storage.write(key: "username", value: value);
  }
  Future<void> delete_all() async{
    await storage.deleteAll();
  }
}

//class StorageUtil {
//  static StorageUtil _storageUtil;
//  static SharedPreferences _preferences;
//
//  static Future<StorageUtil> getInstance() async {
//    if (_storageUtil == null) {
//      // keep local instance till it is fully initialized.
//      var secureStorage = StorageUtil._();
//      await secureStorage._init();
//      _storageUtil = secureStorage;
//    }
//    return _storageUtil;
//  }
//  StorageUtil._();
//  Future _init() async {
//    _preferences = await SharedPreferences.getInstance();
//  }
//  // get string
//  static String getString(String key, {String defValue = ''}) {
//    if (_preferences == null) return defValue;
//    return _preferences.getString(key) ?? defValue;
//  }
//  // put string
//  static Future<bool> putString(String key, String value) {
//    if (_preferences == null) return null;
//    return _preferences.setString(key, value);
//  }
//
//}
////
////void main1() async {
////  await StorageUtil.getInstance();
////  StorageUtil.getString("access_token");
////
////}
//
///*
//* Example of a secure store as a Mixin
//* Usage:
//
//import '../mixins/secure_store_mixin.dart';
//
//MyClass extends StatelessWidget with SecureStoreMixin {
//
//  exampleSet(){
//    setSecureStore('jwt', 'jwt-token-data');
//  }
//
//  exampleGet(){
//     getSecureStore('jwt', (token) { print(token); });
//  }
//}
//
//*/
//
//class SecureStoreMixin{
//
//  final secureStore = new FlutterSecureStorage();
//
//  void setSecureStore(String key, String data) async {
//    await secureStore.write(key: key, value: data);
//  }
//
//  void getSecureStore(String key, Function callback) async {
//    await secureStore.read(key: key).then(callback);
//  }
//
//}
//
//// singleton class which has token.
//class Auth {
//  final String _token;
//  String get token => _token;
//  static Auth _instance;
//  factory Auth() => _instance;
//  Auth._init(this._token);
//  final storage = new FlutterSecureStorage();
//  static Future<void> create() async {
//    String token = await FlutterSecureStorage().read(key: 'access_token');
//    _instance = Auth._init(token);
//  }
//}
//
//// initialize singleton class in main
////void main() async {
////  var vvv = await Auth.create();
////  return vvv;
////}
//
//
//// Read value
////String value = await storage.read(key: key);
//
//// Read all values
////Map<String, String> allValues = await storage.readAll();
//
//// Delete value
////await storage.delete(key: key);
//
//// Delete all
//// await storage.deleteAll();
//
//// Write value
////await storage.write(key: key, value: value);

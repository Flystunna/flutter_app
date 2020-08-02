class LoginModel {
  String userName;
  String password;

  LoginModel({this.userName, this.password});

  Map<String, dynamic> toMap()
  {
    var map = Map<String, dynamic>();
    map["userName"]= userName;
    map["password"]= password;
    return map;
  }

  factory LoginModel.fromJson(Map<String, dynamic> parsedJson){
    final password = parsedJson['password'];
    final userName = parsedJson['userName'];
    return LoginModel(
        userName: userName,
        password: password
    );
  }
}
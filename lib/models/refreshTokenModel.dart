class RefreshTokenModel {
  String token;
  String refreshToken;
  RefreshTokenModel({this.token, this.refreshToken});
  Map<String, dynamic> toMap()
  {
    var map = Map<String, dynamic>();
    map["token"]= token;
    map["refreshToken"]= refreshToken;
    return map;
  }
  factory RefreshTokenModel.fromJson(Map<String, dynamic> parsedJson){
    final token = parsedJson['token'];
    final refreshToken = parsedJson['refreshToken'];
    return RefreshTokenModel(
        token: token,
        refreshToken: refreshToken
    );
  }
}
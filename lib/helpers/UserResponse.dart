import '../models/Usermodel.dart';


class UserResponse {
  Usermodel user;
  String error;


  UserResponse();
  UserResponse.mock(Usermodel user):
        user  = user,error = "";
}
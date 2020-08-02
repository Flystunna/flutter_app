class ApiResponse<T>
{
   bool status;
   String message;
   T data;
   
   ApiResponse.fromJson(Map json){
     status = json['status'];
     message = json['message'];
     data = ((T as BaseResponses).fromJson(json['data']));
     
   }
}

abstract class BaseResponses {
  BaseResponses.fromJson(Map json);

  fromJson(Map json);
}

class Login extends BaseResponses{
  String name;
  String email;
  
  Login.fromJson(Map json) : super.fromJson(json){
    name = json['name'];
    email = json['email'];
    
  }

  @override
  fromJson(Map json) {
    // TODO: implement fromJson
    throw UnimplementedError();
  }
}
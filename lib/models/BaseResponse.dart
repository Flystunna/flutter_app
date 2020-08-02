class BaseResponse<T>{
  String code;
  String shortDescription;
  T object;

  BaseResponse();

   BaseResponse.fromJson(Map<String, dynamic> parsedJson){
     //dynamic dynamicObject = parsedJson['object'];
     code = parsedJson['code'];
     shortDescription = parsedJson['shortDescription'];
     object = parsedJson['object'];
     //object = (BaseResponse.fromJson(dynamicObject)) as T;
   }
}

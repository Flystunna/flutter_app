import 'package:json_annotation/json_annotation.dart';

/// This allows the `User` class to access private members in
/// the generated file. The value for this is *.g.dart, where
/// the star denotes the source file name.
part 'Usermodel.g.dart';

/// An annotation for the code generator to know that this class needs the
/// JSON serialization logic to be generated when we do the flutter pub run build_runner build
@JsonSerializable()


class Usermodel{
  String id;
  String email;
  String password;
  UserType userType;
  String userId;
  String phoneNumber;
  String referralCode;
  String address;
  String username;
  String dateJoined;
  String referrer;
  String userTypes;
  String gender;
  String firstName;
  String lastName;
  String middleName;
  String otp;
  bool emailConfirmed;
  bool phoneNumberConfirmed;
  String nextOfKinPhone;
  String nextOfKin;
  String dateOfBirth;


  Usermodel({this.id,this.email,this.password, this.gender, this.phoneNumber, this.address, this.lastName,
    this.firstName, this.dateJoined, this.dateOfBirth, this.emailConfirmed, this.middleName, this.nextOfKin,
    this.nextOfKinPhone, this.otp, this.phoneNumberConfirmed, this.referralCode, this.referrer, this.userId,
    this.username, this.userType, this.userTypes});

  /// A necessary factory constructor for creating a new User instance
  /// from a map. Pass the map to the generated `_$UserFromJson()` constructor.
  /// The constructor is named after the source class, in this case, User.
  factory Usermodel.fromJson(Map<String, dynamic> json) => _$UsermodelFromJson(json);

  /// `toJson` is the convention for a class to declare support for serialization
  /// to JSON. The implementation simply calls the private, generated
  /// helper method `_$UserToJson`.
  Map<String, dynamic> toJson() => _$UsermodelToJson(this);
}

enum UserType
{
  Administrator,
  Employee,
  Partner,
  Customer
}
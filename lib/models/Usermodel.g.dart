// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'Usermodel.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Usermodel _$UsermodelFromJson(Map<String, dynamic> json) {
  return Usermodel(
    id: json['id'] as String,
    email: json['email'] as String,
    password: json['password'] as String,
    gender: json['gender'] as String,
    phoneNumber: json['phoneNumber'] as String,
    address: json['address'] as String,
    lastName: json['lastName'] as String,
    firstName: json['firstName'] as String,
    dateJoined: json['dateJoined'] as String,
    dateOfBirth: json['dateOfBirth'] as String,
    emailConfirmed: json['emailConfirmed'] as bool,
    middleName: json['middleName'] as String,
    nextOfKin: json['nextOfKin'] as String,
    nextOfKinPhone: json['nextOfKinPhone'] as String,
    otp: json['otp'] as String,
    phoneNumberConfirmed: json['phoneNumberConfirmed'] as bool,
    referralCode: json['referralCode'] as String,
    referrer: json['referrer'] as String,
    userId: json['userId'] as String,
    username: json['username'] as String,
    userType: _$enumDecodeNullable(_$UserTypeEnumMap, json['userType']),
    userTypes: json['userTypes'] as String,
  );
}

Map<String, dynamic> _$UsermodelToJson(Usermodel instance) => <String, dynamic>{
      'id': instance.id,
      'email': instance.email,
      'password': instance.password,
      'userType': _$UserTypeEnumMap[instance.userType],
      'userId': instance.userId,
      'phoneNumber': instance.phoneNumber,
      'referralCode': instance.referralCode,
      'address': instance.address,
      'username': instance.username,
      'dateJoined': instance.dateJoined,
      'referrer': instance.referrer,
      'userTypes': instance.userTypes,
      'gender': instance.gender,
      'firstName': instance.firstName,
      'lastName': instance.lastName,
      'middleName': instance.middleName,
      'otp': instance.otp,
      'emailConfirmed': instance.emailConfirmed,
      'phoneNumberConfirmed': instance.phoneNumberConfirmed,
      'nextOfKinPhone': instance.nextOfKinPhone,
      'nextOfKin': instance.nextOfKin,
      'dateOfBirth': instance.dateOfBirth,
    };

T _$enumDecode<T>(
  Map<T, dynamic> enumValues,
  dynamic source, {
  T unknownValue,
}) {
  if (source == null) {
    throw ArgumentError('A value must be provided. Supported values: '
        '${enumValues.values.join(', ')}');
  }

  final value = enumValues.entries
      .singleWhere((e) => e.value == source, orElse: () => null)
      ?.key;

  if (value == null && unknownValue == null) {
    throw ArgumentError('`$source` is not one of the supported values: '
        '${enumValues.values.join(', ')}');
  }
  return value ?? unknownValue;
}

T _$enumDecodeNullable<T>(
  Map<T, dynamic> enumValues,
  dynamic source, {
  T unknownValue,
}) {
  if (source == null) {
    return null;
  }
  return _$enumDecode<T>(enumValues, source, unknownValue: unknownValue);
}

const _$UserTypeEnumMap = {
  UserType.Administrator: 'Administrator',
  UserType.Employee: 'Employee',
  UserType.Partner: 'Partner',
};

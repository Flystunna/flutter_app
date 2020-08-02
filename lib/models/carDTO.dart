// import 'package:flutter/foundation.dart';

class CarDTO {
  final int id;
  final String title;
  final String commonName;
  final String name;
  final String regNumber;
  final String engineNumber;
  final CarType carType;
  final String carTypeString;
  final String status;
  final int productionYear;
  final String color;
  final String condition;
  String cartypeString() => carType.toString();

  CarDTO({
    this.id,
    this.title,
    this.commonName,
    this.engineNumber,
    this.name,
    this.regNumber,
    this.carType,
    this.carTypeString,
    this.color,
    this.condition,
    this.productionYear,
    this.status
  });

  factory CarDTO.fromJson(Map<String, dynamic> json) {
    return CarDTO(
      id: json['id'],
      title: json['title'],
      engineNumber: json['engineNumber'],
      regNumber: json['regNumber'],
      name: json['name'],
      commonName: json['commonName'],
      carType: json['carType'],
      carTypeString: json['carType'].toString(),
      color: json['color'],
      condition: json['condition'],
      productionYear: json['productionYear'],
      status: json['status']

    );
  }

  Map<String, dynamic> toMap()
  {
    var map = Map<String, dynamic>();
    map["title"]= title;
    map["engineNumber"]= engineNumber;
    map["regNumber"]= regNumber;
    map["name"]= name;
    map["commonName"]= commonName;
    map["carType"]= carType;
    map["color"]= color;
    map["condition"]= condition;
    map["status"]= status;

    return map;
  }

}

enum CarType
{
  Sedan,
  HatchBBack,
  Crossover,
  Coupe,
  Convertible,
  SUV,
  MPV,
  PickUp
}

import 'dart:convert';

import 'package:flutter/material.dart';

class taipei {
  List<dynamic> _taipei_district=[
    ["中山",false],["大安",false],["信義",false],["士林",false],
    ["內湖",false],["中正",false],["萬華",false],["松山",false],
    ["大同",false], ["文山",false],["北投",false],["南港",false]];

  List gettaipei_district(){
    return _taipei_district;
  }
  int gettaipei_districtLength(){
    return _taipei_district.length;
  }
}
class newTaipei{
  List<dynamic> newTaipei_districtlist=[
    ["板橋",false],["三重",false], ["淡水",false], ["中和",false],
    ["永和",false],["新莊",false],["新店",false], ["汐止",false],
    ["林口",false],["蘆洲",false],["土城",false],["三峽",false],
    ["泰山",false], ["鶯歌",false],["樹林",false],["五股",false],
    ["八里",false], ["深坑",false], ["三芝",false],["瑞芳",false],
    ["金山",false],["萬里",false], ["烏來",false], ["貢寮",false],
    ["坪林",false],["石碇",false],["平溪",false], ["雙溪",false],
    ["石門",false],];

  List getnewTaipei_districtlist(){
    return newTaipei_districtlist;
  }
  int getnewTaipei_districtlistLength(){
    return newTaipei_districtlist.length;
  }
}

class Apartment{
   String? _address;
   Map <String ,dynamic>? _apartment_type;
   List<dynamic>? _device;
   Map <String ,dynamic>? _district;
   String? _title;
   int? _price;
   Map<String,dynamic>? _rent_type;
   List<dynamic>? _restrict;
   Map<String,dynamic>? _room_type;
   List<dynamic>? _surroundingFacility;


  Apartment( Map<String, dynamic> data){
    this._address=data["address"];
    print("address");
    this._apartment_type=data["apartment_type"];
    print("type");
    this._device=data["device"];
    print("device");
    this._district=data["district"];
    print("district");
    this._title=data["name"];
    print("name");
    this._price=data["price"];
    print("price");
    this._rent_type=data["rent_type"];
    print("rent_type");
    this._restrict=data["restrict"];
    print("restrict");
    this._room_type=data["room_type"];
    print("room_type");
    this._surroundingFacility=data["surroundingfacility"];
    print("surroundingfacility");
  }
   String? getAdress(){return _address;}
   Map <String ,dynamic>? getApartmentType(){return _apartment_type;}
   List<dynamic>? getDevice(){return _device;}
   Map <String ,dynamic>? getDistrict(){return _district;}
   String? getTitle(){return _title;}
   int? getPrice(){return _price;}
   Map<String,dynamic>? getRentType(){return _rent_type;}
   List<dynamic>? getRestrict(){return _restrict;}
   Map<String,dynamic>? getRoomType(){return _room_type;}
   List<dynamic>? getSurroundingFacility(){return _surroundingFacility;}

 }




class Job{
  final String address;
  final List district;
  final String min_price;
  final String max_price;
  final List rent_type;
  final List apartment_type;
  final List room_type;
  final List restrict;
  final List device;

  Job(this.address,this.district,this.min_price,this.max_price,this.rent_type,this.apartment_type,this.room_type,this.restrict,this.device);
  Job.fromJson(Map<String, dynamic> json)
      : address =json['address'],
        district = json['district'],
        min_price = json['min_price'],
        max_price = json['max_price'],
        rent_type = json['rent_type'],
        apartment_type = json['apartment_type'],
        room_type = json['room_type'],
        restrict = json['restrict'],
        device = json['device'];
  Map<String, dynamic> toJson() => {
    'address': address,
    'district': district,
    'min_price': min_price,
    'max_price': max_price,
    'rent_type': rent_type,
    'apartment_type': apartment_type,
    'room_type': room_type,
    'restrict': restrict,
    'device': device,
  };

}
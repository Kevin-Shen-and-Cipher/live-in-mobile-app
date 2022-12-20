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
   String? _url;

  Apartment( Map<String, dynamic> data){
    this._address=data["address"];
    this._apartment_type=data["apartment_type"];
    this._device=data["device"];
    this._district=data["district"];
    this._title=data["name"];
    this._price=data["price"];
    this._rent_type=data["rent_type"];
    this._restrict=data["restrict"];
    this._room_type=data["room_type"];
    this._surroundingFacility=data["surroundingfacility"];
    this._url=data["url"];
  }
   String?                getAdress(){return _address;}
   Map <String ,dynamic>? getApartmentType(){return _apartment_type;}
   List<dynamic>?         getDevice(){return _device;}
   Map <String ,dynamic>? getDistrict(){return _district;}
   String?                getTitle(){return _title;}
   int?                   getPrice(){return _price;}
   Map<String,dynamic>?   getRentType(){return _rent_type;}
   List<dynamic>?         getRestrict(){return _restrict;}
   Map<String,dynamic>?   getRoomType(){return _room_type;}
   List<dynamic>?         getSurroundingFacility(){return _surroundingFacility;}
   String?                getUrl(){return _url;}

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
List<dynamic> countries = [
  {"pk": 1, "name": "台北"},
  {"pk": 2, "name": "新北"}];
List<dynamic> rent=[
  {"pk": 1, "name": "0~5000"},
  {"pk": 2, "name": "5000~10000"},
  {"pk": 3, "name": "10000~20000"},
  {"pk": 4, "name": "20000~30000"},
  {"pk": 5, "name": "30000~40000"},
  {"pk": 6, "name": "40000以上"},];
List<dynamic> rent_type = [
  ["透天", false],
  ["獨立套房", false],
  ["分租套房", false],
  ["雅房", false]];
List<dynamic> facility_type = [
  ["捷運", false],
  ["公車", false],
  ["學校", false]];
List<dynamic> room_type = [
  ["一房", false],
  ["二房", false],
  ["三房", false],
  ["四房以上", false]];
List<dynamic> apartment_type = [
  ["公寓", false],
  ["大樓", false],
  ["透天", false],
  ["別墅", false]];
List<dynamic> device = [
  ["冷氣", false],
  ["洗衣機", false],
  ["冰箱", false],
  ["熱水器", false],
  ["天然瓦斯", false],
  ["網路", false],
  ["床", false]];
List<dynamic> restrict = [
  ["男女皆可", false],
  ["限男", false],
  ["限女", false],
  ["排除頂樓加蓋", false]];
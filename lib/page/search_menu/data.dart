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
  List<dynamic> newTaipei_districtlist=[["板橋",false],["三重",false], ["淡水",false],
  ["中和",false],["永和",false],["新莊",false],["新店",false], ["汐止",false],
  ["林口",false],["蘆洲",false],["土城",false],["三峽",false], ["泰山",false],
  ["鶯歌",false],["樹林",false],["五股",false],["八里",false], ["深坑",false],
  ["三芝",false],["瑞芳",false],["金山",false],["萬里",false], ["烏來",false],
  ["貢寮",false],["坪林",false],["石碇",false],["平溪",false], ["雙溪",false],
  ["石門",false],];

  List getnewTaipei_districtlist(){
    return newTaipei_districtlist;
  }
  int getnewTaipei_districtlistLength(){
    return newTaipei_districtlist.length;
  }
}
class Job{
  final List district;
  final String min_price;
  final String max_price;
  final List rent_type;
  final List apartment_type;
  final List room_type;
  final List restrict;
  final List device;

  Job(this.district,this.min_price,this.max_price,this.rent_type,this.apartment_type,this.room_type,this.restrict,this.device);
  Job.fromJson(Map<String, dynamic> json)
      : district = json['district'],
        min_price = json['min_price'],
        max_price = json['max_price'],
        rent_type = json['rent_type'],
        apartment_type = json['apartment_type'],
        room_type = json['room_type'],
        restrict = json['restrict'],
        device = json['device'];
  Map<String, dynamic> toJson() => {
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
import 'package:flutter/material.dart';
import 'package:live_in/page/search_menu/newTaipei_district.dart';
import 'package:live_in/page/search_menu/taipei_district.dart';
import 'package:snippet_coder_utils/FormHelper.dart';
import 'package:getwidget/getwidget.dart';

import 'package:flutter/material.dart';
import 'package:snippet_coder_utils/FormHelper.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'dart:developer';
import 'package:json_annotation/json_annotation.dart';

class left_search_menu extends StatefulWidget {
  const left_search_menu({Key? key}) : super(key: key);

  @override
  State<left_search_menu> createState() => _left_search_menuState();
}
class User {
  String name;
  int age;
  String name1;
  int age1;

  User({required this.name, required this.age,required this.name1,required this.age1});

  Map<String, dynamic> toJson() {
    return {
      'name': name,
      'age': age,
      'name1':name1,
      'age1':age1
    };
  }
}
class _left_search_menuState extends State<left_search_menu> {

  List<dynamic> countries=[];
  List<dynamic> statesMasters=[];
  List<dynamic> rent_type=[["透天",false],["獨立套房",false],["分租套房",false],["雅房",false]];
  List<dynamic> rent=[["0~5000",false],["5000~10000",false],["10000~20000",false],["20000~30000",false],["30000~40000",false],["40000以上",false]];
  List<dynamic> facility_type=[["捷運",false],["公車",false],["學校",false]];
  List<dynamic> room_type=[["一房",false],["二房",false],["三房",false],["四房以上",false]];
  List<dynamic> apartment_type=[["公寓",false],["大樓",false],["透天",false],["別墅",false]];
  List<dynamic> device=[["冷氣",false],["洗衣機",false],["冰箱",false],["熱水器",false],["天然瓦斯",false],["網路",false],["床",false]];
  List<dynamic> restrict=[["男女皆可",false],["限男",false],["限女",false],["排除頂樓加蓋",false]];


  String? countryId;
  String? companyLocation;


  @override
  void initState() {
    super.initState();
    this.countries.add({"id":1,"name":"台北"});
    this.countries.add({"id":2,"name":"新北"});
  }

  @override
  Widget build(BuildContext context)  {
    return Container(
      width: 350,
      child: Drawer(
        child: Container(
          child: ListView(
            padding: EdgeInsets.zero,
            children: [
              Container(
                color: const Color.fromRGBO(147,197,253,1),
                height: 80,
                padding: EdgeInsets.only(top: 35),
                child: const Text(
                  "找房子",
                  textAlign: TextAlign.center,
                  overflow: TextOverflow.ellipsis,
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 20,                          // 大小
                    fontWeight: FontWeight.bold,),
                ),
              ),
              Container(
                height: 100,
                  //rgba(236, 240, 241,1.0)
                  decoration: const BoxDecoration(
                      color:  Color.fromRGBO(236,240,241,1),
                      border:Border(
                      bottom: BorderSide(
                          color:  Color.fromRGBO(196,200,201,1),
                          width: 3)
                )),
                padding: EdgeInsets.only(top: 5,left: 15,right: 10),
                child: TextField(decoration: const InputDecoration(
                  icon: Icon(Icons.location_city),
                  labelText: "目前工作地址",
                ),
                  onSubmitted: (text){
                    final city=text.split('市');
                    final districtAndLocation=city[1].split('區');
                    print("city: ${city[0]} ,"
                        "district: ${districtAndLocation[0]} , "
                        "location: ${districtAndLocation[1]}");
                  },
                )

              ),
              Container(
                height: 100,
                decoration: const BoxDecoration(
                  color:  Color.fromRGBO(236,240,241,1)//rgba(236, 240, 241,1.0)
                ),
                child: Column(
                  children: [
                    FormHelper.dropDownWidgetWithLabel(
                      labelFontSize:20,
                      context,
                      "位置/County",
                      "Select County",
                      this.countryId,
                      this.countries,
                          (onChangedVal){
                        this.countryId=onChangedVal;
                        print("Selected County:$onChangedVal");
                        setState(() { });},
                          (onChangedVal){
                        if(onChangedVal==null){
                          return"please select County";}
                        return null;},
                      borderColor:Theme.of(context).primaryColor,
                      borderFocusColor:Theme.of(context).primaryColor,
                      borderRadius: 10,
                      //optionValue: "id",
                      //optionLabel: "name"
                    ),
                  ],
                ),
              ),
              if(countryId=='1')
                taipeiDistrict(),
              if(countryId=='2')
                newTaipei_district(),

              Container(
                color: Color.fromRGBO(236,240,241,1),
                height: 150,
                padding: EdgeInsets.only(left: 15,top: 10),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Text(
                      "類型",
                      textAlign: TextAlign.left,
                      overflow: TextOverflow.ellipsis,
                      style: TextStyle(
                        fontSize: 20,                          // 大小
                        fontWeight: FontWeight.bold,),
                    ),
                    Wrap(
                        spacing: 8.0, // 主轴(水平)方向间距
                        runSpacing: 4.0, // 纵轴（垂直）方向间距
                        children: <Widget>[
                          for(int i=0;i<rent_type.length;i++)
                            InputChip(
                                selected: rent_type[i][1],
                                label: Text(rent_type[i][0]),
                                labelStyle: TextStyle(color: Colors.white),
                                avatar: Icon(Icons.add,),
                                backgroundColor: Colors.black54,
                                selectedColor: Colors.blue,
                                onPressed: () {

                                  setState(() {
                                    rent_type[i][1] = !rent_type[i][1];
                                    print(rent_type[i][0]+' is '+(rent_type[i][1]).toString(),);
                                  });
                                }
                            ),
                        ]
                    ),
                  ],
                )
              ),
              Container(
                  color: Color.fromRGBO(236,240,241,1),
                  height: 200,
                  padding: EdgeInsets.only(left: 15),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children:  [
                      Text(
                        "租金",
                        textAlign: TextAlign.left,
                        overflow: TextOverflow.ellipsis,
                        style: TextStyle(
                          fontSize: 20,                          // 大小
                          fontWeight: FontWeight.bold,),
                      ),
                      Wrap(
                          spacing: 8.0, // 主轴(水平)方向间距
                          runSpacing: 4.0, // 纵轴（垂直）方向间距
                          children: <Widget>[
                            for(int i=0;i<rent.length;i++)
                              InputChip(
                                  selected: rent[i][1],
                                  label: Text(rent[i][0]),
                                  labelStyle: TextStyle(color: Colors.white),
                                  avatar: Icon(Icons.add,),
                                  backgroundColor: Colors.black54,
                                  selectedColor: Colors.blue,
                                  onPressed: () {

                                    setState(() {
                                      rent[i][1] = !rent[i][1];
                                      print(rent[i][0]+' is '+(rent[i][1]).toString(),);
                                    });
                                  }
                              ),
                          ]
                      ),
                    ],
                  )
              ),
              Container(
                  color: Color.fromRGBO(236,240,241,1),
                  height: 150,
                  padding: EdgeInsets.only(left: 15),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const Text(
                        "格局",
                        textAlign: TextAlign.left,
                        overflow: TextOverflow.ellipsis,
                        style: TextStyle(
                          fontSize: 20,                          // 大小
                          fontWeight: FontWeight.bold,),
                      ),
                      Wrap(
                          spacing: 8.0, // 主轴(水平)方向间距
                          runSpacing: 4.0, // 纵轴（垂直）方向间距
                          children: <Widget>[
                            for(int i=0;i<room_type.length;i++)
                              InputChip(
                                  selected: room_type[i][1],
                                  label: Text(room_type[i][0]),
                                  labelStyle: TextStyle(color: Colors.white),
                                  avatar: Icon(Icons.add,),
                                  backgroundColor: Colors.black54,
                                  selectedColor: Colors.blue,
                                  onPressed: () {

                                    setState(() {
                                      room_type[i][1] = !room_type[i][1];
                                      print(room_type[i][0]+' is '+(room_type[i][1]).toString(),);
                                    });
                                  }
                              ),
                          ]
                      ),
                    ],
                  )
              ),
              Container(
                  color: Color.fromRGBO(236,240,241,1),
                  height: 100,
                  padding: EdgeInsets.only(left: 15),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const Text(
                        "特色",
                        textAlign: TextAlign.left,
                        overflow: TextOverflow.ellipsis,
                        style: TextStyle(
                          fontSize: 20,                          // 大小
                          fontWeight: FontWeight.bold,),
                      ),
                      Wrap(
                          spacing: 8.0, // 主轴(水平)方向间距
                          runSpacing: 4.0, // 纵轴（垂直）方向间距
                          children: <Widget>[
                            for(int i=0;i<facility_type.length;i++)
                              InputChip(
                                  selected: facility_type[i][1],
                                  label: Text(facility_type[i][0]),
                                  labelStyle: TextStyle(color: Colors.white),
                                  avatar: Icon(Icons.add,),
                                  backgroundColor: Colors.black54,
                                  selectedColor: Colors.blue,
                                  onPressed: () {

                                    setState(() {
                                      facility_type[i][1] = !facility_type[i][1];
                                      print(facility_type[i][0]+' is '+(facility_type[i][1]).toString(),);
                                    });
                                  }
                              ),
                          ]
                      ),
                    ],
                  )
              ),
              Container(
                  color: Color.fromRGBO(236,240,241,1),
                  height: 100,
                  padding: EdgeInsets.only(left: 15),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const Text(
                        "型態",
                        textAlign: TextAlign.left,
                        overflow: TextOverflow.ellipsis,
                        style: TextStyle(
                          fontSize: 20,                          // 大小
                          fontWeight: FontWeight.bold,),
                      ),
                      Wrap(
                          spacing: 8.0, // 主轴(水平)方向间距
                          runSpacing: 4.0, // 纵轴（垂直）方向间距
                          children: <Widget>[
                            for(int i=0;i<apartment_type.length;i++)
                              InputChip(
                                  selected: apartment_type[i][1],
                                  label: Text(apartment_type[i][0]),
                                  labelStyle: TextStyle(color: Colors.white),
                                  avatar: Icon(Icons.add,),
                                  backgroundColor: Colors.black54,
                                  selectedColor: Colors.blue,
                                  onPressed: () {

                                    setState(() {
                                      apartment_type[i][1] = !apartment_type[i][1];
                                      print(apartment_type[i][0]+' is '+(apartment_type[i][1]).toString(),);
                                    });
                                  }
                              ),
                          ]
                      ),
                    ],
                  )
              ),
              Container(
                  color: Color.fromRGBO(236,240,241,1),
                  height: 200,
                  padding: EdgeInsets.only(left: 15),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const Text(
                        "設備",
                        textAlign: TextAlign.left,
                        overflow: TextOverflow.ellipsis,
                        style: TextStyle(
                          fontSize: 20,                          // 大小
                          fontWeight: FontWeight.bold,),
                      ),
                      Wrap(
                          spacing: 8.0, // 主轴(水平)方向间距
                          runSpacing: 4.0, // 纵轴（垂直）方向间距
                          children: <Widget>[
                            for(int i=0;i<device.length;i++)
                              InputChip(
                                  selected: device[i][1],
                                  label: Text(device[i][0]),
                                  labelStyle: TextStyle(color: Colors.white),
                                  avatar: Icon(Icons.add,),
                                  backgroundColor: Colors.black54,
                                  selectedColor: Colors.blue,
                                  onPressed: () {

                                    setState(() {
                                      device[i][1] = !device[i][1];
                                      print(device[i][0]+' is '+(device[i][1]).toString(),);
                                    });
                                  }
                              ),
                          ]
                      ),
                    ],
                  )
              ),
              Container(
                  color: Color.fromRGBO(236,240,241,1),
                  height: 150,
                  padding: EdgeInsets.only(left: 15),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const Text(
                        "須知",
                        textAlign: TextAlign.left,
                        overflow: TextOverflow.ellipsis,
                        style: TextStyle(
                          fontSize: 20,                          // 大小
                          fontWeight: FontWeight.bold,),
                      ),
                      Wrap(
                          spacing: 8.0, // 主轴(水平)方向间距
                          runSpacing: 4.0, // 纵轴（垂直）方向间距
                          children: <Widget>[
                            for(int i=0;i<restrict.length;i++)
                              InputChip(
                                  selected: restrict[i][1],
                                  label: Text(restrict[i][0]),
                                  labelStyle: TextStyle(color: Colors.white),
                                  avatar: Icon(Icons.add,),
                                  backgroundColor: Colors.black54,
                                  selectedColor: Colors.blue,
                                  onPressed: () {

                                    setState(() {
                                      restrict[i][1] = !restrict[i][1];
                                      print(restrict[i][0]+' is '+(restrict[i][1]).toString(),);
                                    });
                                  }
                              ),
                          ]
                      ),
                    ],
                  )
              ),
              Container(
                color: Color.fromRGBO(236,240,241,1),
                height: 50,
                padding: EdgeInsets.only(left: 40,right: 40,bottom: 10),
                child: ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.blueGrey,),
                  child: const Text('收尋',
                    style: TextStyle(
                      fontSize: 20,                          // 大小
                      fontWeight: FontWeight.bold,),
                  ),
                  onPressed: () {},
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}

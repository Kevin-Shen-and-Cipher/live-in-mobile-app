import 'dart:convert';
import 'dart:io';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:snippet_coder_utils/FormHelper.dart';
import 'package:live_in/page/search_menu/data.dart';
import 'package:http/http.dart' as http;

import '../searchPage.dart';

//work

class righ_search_menu extends StatefulWidget {
  const righ_search_menu({Key? key}) : super(key: key);

  @override
  State<righ_search_menu> createState() => _righ_search_menuState();
}

class _righ_search_menuState extends State<righ_search_menu> {
  List<dynamic> GetDistrictData(List<dynamic> listTaipei,List<dynamic> listNewTaipei){
    List<dynamic> Returnlist=[];
    if(countryId == '1'){
      for(int i=0;i<listTaipei.length;i++){
        if(listTaipei[i][1]){
          Returnlist.add((i+1).toString());
        }
      }
    }
    if(countryId == '2'){
      for(int i=0;i<listNewTaipei.length;i++){
        if(listNewTaipei[i][1]){
          Returnlist.add((i+13).toString());
        }
      }
    }
    return  Returnlist;
  }
  List<dynamic> GetAllData(List<dynamic> list){
    List<dynamic> Returnlist=[];
    for(int i=0;i<list.length;i++){
      if(list[i][1]){
        Returnlist.add((i+1).toString());
      }
    }
    return  Returnlist;
  }

  receiveData() async {
    var client = http.Client();

    final headers = {HttpHeaders.contentTypeHeader: 'application/json'};
    var url=Uri(
        scheme: 'https',
        host: 'www.live-in.moonnight.software',
        path: 'api/jobs/',
        queryParameters: {
          'address': address!,
          'district': GetDistrictData(taipei_district.gettaipei_district(),newTaipei_district.getnewTaipei_districtlist()),
          'min_salary': salary,
          'job_position': GetAllData(job_position),
          'working_hour': GetAllData(work_hour),
        }
    );
    print(url);
    try {
      var response = await client.get(url,headers: headers);// get接收資料

      if (response.statusCode != 200) {// 確保請求成功

        throw Exception('receiveData請求失敗');
      }
      var data = json.decode(utf8.decode(response.bodyBytes));
      print("---資料獲取成功----");
      Navigator.pop(context);

      for(int i=0;i<data.length;i++){
        Getrightdata.add(new EngineerJob(new Map<String, dynamic>.from(data[i])));
      }

    } catch (e) {
      print(e);
      Fluttertoast.showToast(
          backgroundColor: Colors.deepOrangeAccent,
          msg: "錯誤，${e}，目前工作地址有誤",                 // message
          toastLength: Toast.LENGTH_LONG, // length
          gravity: ToastGravity.CENTER,    // location
          timeInSecForIosWeb: 3            // duration
      );
    } finally {
      client.close();// 在不需要時被關閉
    }
  }

  String? address;
  String? countryId;
  String? salaryId;
  String salary='';

  taipei taipei_district=new taipei();
  newTaipei newTaipei_district=new newTaipei();

  @override
  Widget build(BuildContext context) {
    return SafeArea(
        child:
    Container(
      width: 350,
      child:Scaffold(
        appBar:AppBar(
          title: Text('找工作',),
          centerTitle: true,
          backgroundColor: Color.fromRGBO(147,197,253,1),
        ),
        body: Container(
          child: ListView(
            padding: EdgeInsets.zero,
            children: [
              Container(
                  height: 100,
                  //rgba(236, 240, 241,1.0)
                  decoration: const BoxDecoration(
                      color: Color.fromRGBO(236, 240, 241, 1),
                      border: Border(
                          bottom: BorderSide(
                              color: Color.fromRGBO(196, 200, 201, 1),
                              width: 3))),
                  padding: EdgeInsets.only(top: 5, left: 15, right: 10),
                  child: TextField(
                    decoration: const InputDecoration(
                        icon: Icon(Icons.location_city),
                        labelText: "目前工作地址",
                        helperText: "*必填",
                        helperStyle: TextStyle(
                          color: Colors.red,
                        )
                    ),
                    onSubmitted: (text) {
                      address=text;
                      print(address);
                    },
                  )),
              Container(
                height: 100,
                decoration: const BoxDecoration(
                    color:  Color.fromRGBO(236,240,241,1)//rgba(236, 240, 241,1.0)
                ),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    Container(
                      padding: EdgeInsets.only(left: 15,bottom: 8,top: 10),
                      child: Row(
                        children: const [
                          Text("位置/County",
                            style: TextStyle(
                              fontSize: 20, // 大小
                              fontWeight: FontWeight.bold,
                            ),),
                          Text("  *必填",
                            textAlign: TextAlign.left,
                            style: TextStyle(
                              fontSize: 12,
                              color: Colors.red,
                            ),)
                        ],
                      ),
                    ),
                    FormHelper.dropDownWidget(
                      context,
                      "Select County",
                      this.countryId,
                      countries,
                          (onChangedVal) {
                        this.countryId = onChangedVal;
                        print("Selected County:$onChangedVal");
                        if(countryId=='1'){
                          for(int i=0 ;i<newTaipei_district.getnewTaipei_districtlistLength();i++){
                            newTaipei_district.getnewTaipei_districtlist()[i][1]=false;
                          }}
                        if(countryId=='2'){
                          for(int i=0 ;i<taipei_district.gettaipei_districtLength();i++){
                            taipei_district.gettaipei_district()[i][1]=false;
                          }}
                        setState(() {});
                      },
                          (onChangedVal) {
                        if (onChangedVal == null) {
                          return "please select County";}
                        return null;},
                      borderColor: Theme.of(context).primaryColor,
                      borderFocusColor: Theme.of(context).primaryColor,
                      borderRadius: 10,
                      optionValue: "pk",
                    ),
                  ],
                ),
              ),

              if (countryId == '1')
                Container(
                  color:  Color.fromRGBO(236,240,241,1),
                  padding: EdgeInsets.only(left: 30),
                  child: Wrap(
                    spacing: 8.0, // 主轴(水平)方向间距
                    runSpacing: 4.0, // 纵轴（垂直）方向间距
                    children: <Widget>[
                      for(int i=0;i<taipei_district.gettaipei_districtLength();i++)
                        InputChip(
                            selected: taipei_district.gettaipei_district()[i][1],
                            label: Text(taipei_district.gettaipei_district()[i][0]+"區"),
                            labelStyle: TextStyle(color: Colors.white),
                            avatar: Icon(Icons.add,),
                            backgroundColor: Colors.black54,
                            selectedColor: Colors.blue,
                            onPressed: () {

                              setState(() {
                                taipei_district.gettaipei_district()[i][1] = !taipei_district.gettaipei_district()[i][1];
                                print(taipei_district.gettaipei_district()[i][0]+' is '+(taipei_district.gettaipei_district()[i][1]).toString(),);

                              });
                            }
                        ),
                    ],
                  ),
                ),
              if (countryId == '2')
                Container(
                  color:  Color.fromRGBO(236,240,241,1),
                  padding: EdgeInsets.only(left: 30),
                  child: Wrap(
                    spacing: 8.0, // 主轴(水平)方向间距
                    runSpacing: 4.0, // 纵轴（垂直）方向间距
                    children: <Widget>[
                      for(int i=0;i<newTaipei_district.getnewTaipei_districtlistLength();i++)
                        InputChip(
                            selected: newTaipei_district.getnewTaipei_districtlist()[i][1],
                            label: Text(newTaipei_district.getnewTaipei_districtlist()[i][0]+"區"),
                            labelStyle: TextStyle(color: Colors.white),
                            avatar: Icon(Icons.add,),
                            backgroundColor: Colors.black54,
                            selectedColor: Colors.blue,
                            onPressed: () {

                              setState(() {
                                newTaipei_district.getnewTaipei_districtlist()[i][1] = !newTaipei_district.getnewTaipei_districtlist()[i][1];
                                print(newTaipei_district.getnewTaipei_districtlist()[i][0]+' is '+(newTaipei_district.getnewTaipei_districtlist()[i][1]).toString(),);

                              });
                            }
                        ),
                    ],
                  ),
                ),
              Container(
                color: Color.fromRGBO(236,240,241,300),
                height: 50,
                padding: EdgeInsets.only(left: 40,right: 40,bottom: 10),
                child: ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.blueGrey,),
                  child: const Text('搜尋',
                    style: TextStyle(
                      fontSize: 20,                          // 大小
                      fontWeight: FontWeight.bold,),
                  ),
                  onPressed: () {
                    switch(salaryId){
                      case '1':
                        salary="30000";
                        break;
                      case'2':
                        salary="40000";
                        break;
                      case'3':
                        salary="50000";
                        break;
                    }
                    if(address==null|| (GetAllData(taipei_district.gettaipei_district()).isEmpty
                        &&GetAllData(newTaipei_district.getnewTaipei_districtlist()).isEmpty)){
                      print("error，address or district is null $address");
                      Fluttertoast.showToast(
                          backgroundColor: Colors.deepOrangeAccent,
                          msg: "錯誤，「目前工作地址」和「位置」為必填",  // message
                          toastLength: Toast.LENGTH_SHORT, // length
                          gravity: ToastGravity.CENTER,    // location
                          timeInSecForIosWeb: 3            // duration
                      );

                      print(salary);
                    }else{
                      Getrightdata=[];//清除前一次資料
                      receiveData();

                    }
                  },
                ),
              ),

              Container(
                height: 100,
                decoration: const BoxDecoration(
                    color:  Color.fromRGBO(236,240,241,1)//rgba(236, 240, 241,1.0)
                ),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    Container(
                      padding: EdgeInsets.only(left: 15,bottom: 8,top: 10),
                      child: Row(
                        children: const [
                          Text("薪資待遇/Salary",
                            style: TextStyle(
                              fontSize: 20, // 大小
                              fontWeight: FontWeight.bold,
                            ),),
                        ],
                      ),
                    ),
                    FormHelper.dropDownWidget(
                      context,
                      "Select Salary",
                      this.salaryId,
                      min_salary,
                          (onChangedVal){
                        this.salaryId = onChangedVal;
                        print("Selected Salary:$onChangedVal");

                        setState(() {});
                      },
                          (onChangedVal){
                        if(onChangedVal==null){
                          return"please select Salary";}
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
              Container(
                  color: Color.fromRGBO(236,240,241,1),
                  height: 150,
                  padding: EdgeInsets.only(left: 15,top: 10),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children:  [
                      const Text(
                        "職業",
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
                            for(int i=0;i<job_position.length;i++)
                              InputChip(
                                  selected: job_position[i][1],
                                  label: Text(job_position[i][0]),
                                  labelStyle: TextStyle(color: Colors.white),
                                  avatar: Icon(Icons.add,),
                                  backgroundColor: Colors.black54,
                                  selectedColor: Colors.blue,
                                  onPressed: () {

                                    setState(() {
                                      job_position[i][1] = !job_position[i][1];
                                      print(job_position[i][0]+' is '+(job_position[i][1]).toString(),);
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
                        "班別",
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
                            for(int i=0;i<work_hour.length;i++)
                              InputChip(
                                  selected: work_hour[i][1],
                                  label: Text(work_hour[i][0]),
                                  labelStyle: TextStyle(color: Colors.white),
                                  avatar: Icon(Icons.add,),
                                  backgroundColor: Colors.black54,
                                  selectedColor: Colors.blue,
                                  onPressed: () {

                                    setState(() {
                                      work_hour[i][1] = !work_hour[i][1];
                                      print(work_hour[i][0]+' is '+(work_hour[i][1]).toString(),);
                                    });
                                  }
                              ),
                          ]
                      ),
                    ],
                  )
              ),
            ],
          ),
        ),
      ),
    )
    );
  }
}


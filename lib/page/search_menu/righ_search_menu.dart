import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:snippet_coder_utils/FormHelper.dart';
import 'package:live_in/page/search_menu/data.dart';

//work

class righ_search_menu extends StatefulWidget {
  const righ_search_menu({Key? key}) : super(key: key);

  @override
  State<righ_search_menu> createState() => _righ_search_menuState();
}

class _righ_search_menuState extends State<righ_search_menu> {

  String getdata(List<dynamic> list,int index,String value){
    String text=jsonEncode(list[index]);
    var json=jsonDecode(text);
    // print(json["fields"]);
    if(value=='name'){
      var valuetext=jsonEncode(json["fields"]);
      var ans=jsonDecode(valuetext);
      return ans[value];
    }
    else{
      return json[value];
    }
  }
  bool getbool(List<dynamic> list,int index,String value){
    String text=jsonEncode(list[index]);
    var json=jsonDecode(text);
    return json[value];
  }
  List<dynamic> GetAllData(List<dynamic> list){
    List<dynamic> Returnlist=[];
    for(int i=0;i<list.length;i++){
      if(list[i][1]){
        Returnlist.add(i);
      }
    }
    return  Returnlist;
  }
  List<dynamic> countries=[
    {"id":1,"name":"台北"},
    {"id":2,"name":"新北"},];
  List<dynamic> salary=[
    {"id":1,"name":"月薪3萬up"},
    {"id":2,"name":"月薪4萬up"},
    {"id":3,"name":"月薪5萬up"},];
  List<dynamic> job=[
    ["軟體工程師",false],
    ["演算法工程師",false],
    ["前端工程師",false],
    ["後端工程師",false]];
  List<dynamic> work_hour=[
    ["日班",false],
    ["晚班",false],
    ["大夜班",false],
    ["假日班",false],
    ["輪班",false]];

  String? countryId;
  String? salaryId;
  String? address;

  taipei taipei_district=new taipei();
  newTaipei newTaipei_district=new newTaipei();

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 350,
      child:Drawer(
        child: Container(
          child: ListView(
            padding: EdgeInsets.zero,
            children: [
              Container(
                color: const Color.fromRGBO(147,197,253,1),
                height: 80,
                padding: EdgeInsets.only(top: 35),
                child: const Text(
                  "找工作",
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
                      this.countries,
                          (onChangedVal){
                            this.countryId = onChangedVal;
                            print("Selected County:$onChangedVal");
                            if(countryId=='1'){
                              for(int i=0 ;i<newTaipei_district.getnewTaipei_districtlistLength();i++){
                                newTaipei_district.getnewTaipei_districtlist()[i][1]=false;
                              }
                            }
                            if(countryId=='2'){
                              for(int i=0 ;i<taipei_district.gettaipei_districtLength();i++){
                                taipei_district.gettaipei_district()[i][1]=false;
                              }
                            }
                            setState(() {});
                        },
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
                      this.salary,
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
                            for(int i=0;i<job.length;i++)
                              InputChip(
                                  selected: job[i][1],
                                  label: Text(job[i][0]),
                                  labelStyle: TextStyle(color: Colors.white),
                                  avatar: Icon(Icons.add,),
                                  backgroundColor: Colors.black54,
                                  selectedColor: Colors.blue,
                                  onPressed: () {

                                    setState(() {
                                      job[i][1] = !job[i][1];
                                      print(job[i][0]+' is '+(job[i][1]).toString(),);
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
                  onPressed: () {
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
                    }else{
                      List<dynamic> alldata=[
                        {
                          "min_salary":(salaryId),
                          "job_position":GetAllData(job),
                          "working_hour":GetAllData(work_hour),
                          "taipei_district":GetAllData(taipei_district.gettaipei_district()),
                          "newTaipei_districtlist":GetAllData(newTaipei_district.getnewTaipei_districtlist())
                        },
                      ];
                      var u = jsonEncode(alldata[0]);
                      var k = jsonDecode(u);
                      //print(k['apartment.device']);
                      print(u);
                    }
                  },
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}


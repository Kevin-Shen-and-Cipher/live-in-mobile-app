import 'package:flutter/material.dart';
import 'package:live_in/page/search_menu/taipei_district.dart';
import 'package:snippet_coder_utils/FormHelper.dart';

import 'newTaipei_district.dart';

//work

class righ_search_menu extends StatefulWidget {
  const righ_search_menu({Key? key}) : super(key: key);



  @override
  State<righ_search_menu> createState() => _righ_search_menuState();
}

class _righ_search_menuState extends State<righ_search_menu> {
  List<dynamic> countries=[];
  List<dynamic> statesMasters=[];
  List<dynamic> job=[["軟體工程師",false],["演算法工程師",false],["前端工程師",false],["後端工程師",false]];
  List<dynamic> work_hour=[["日班",false],["晚班",false],["大夜班",false],["假日班",false],["輪班",false]];

  String? countryId;
  String? companyLocation;

  @override
  void initState(){
    super.initState();
    this.countries.add({"id":1,"name":"台北"});
    this.countries.add({"id":2,"name":"新北"});
  }

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
                child: Text(
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
                      color:  Color.fromRGBO(236,240,241,1),
                      border:Border(
                          bottom: BorderSide(
                              color:  Color.fromRGBO(196,200,201,1),
                              width: 3)
                      )),
                  padding: EdgeInsets.only(top: 5,left: 15,right: 10),
                  child: TextField(decoration: const InputDecoration(
                    icon: Icon(Icons.location_city),
                    labelText: "目前居住地址",
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
                    children:  [
                      Text(
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


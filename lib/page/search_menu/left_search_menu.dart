import 'package:flutter/material.dart';
import 'package:live_in/page/search_menu/taipei_district.dart';
import 'package:snippet_coder_utils/FormHelper.dart';

//house

class left_search_menu extends StatefulWidget {
  const left_search_menu({Key? key}) : super(key: key);

  @override
  State<left_search_menu> createState() => _left_search_menuState();
}

class _left_search_menuState extends State<left_search_menu> {

  List<dynamic> countries=[];
  List<dynamic> statesMasters=[];

  String? countryId;

  @override
  void initState(){
    super.initState();
    this.countries.add({"id":1,"name":"India"});
    this.countries.add({"id":2,"name":"UAE"});

    this.statesMasters=[
      {"ID":1,"Name":"Apple","ParentId":1},
      {"ID":2,"Name":"B","ParentId":1},
      {"ID":3,"Name":"C","ParentId":1},
      {"ID":1,"Name":"x","ParentId":2},
      {"ID":2,"Name":"y","ParentId":2},
      {"ID":3,"Name":"z","ParentId":2},
    ];
  }

  @override
  Widget build(BuildContext context) {

    return  Container(
      width: 350,
      child:Drawer(
        child: Container(
          child: ListView(
            padding: EdgeInsets.zero,
            children: [

              Container(
                color: const Color.fromRGBO(126,214,223,1),
                height: 80,
                padding: EdgeInsets.only(top: 25),
                child: Text("Look for house"),

              ),
              Container(
                height: 100,
                decoration: const BoxDecoration(
                  color:  Color.fromRGBO(236,240,241,1)//rgba(236, 240, 241,1.0)
                  // border: Border(
                  //   top: BorderSide(width: 2),
                  //   bottom: BorderSide(width: 2),
                 // )
                ),
                child: Column(
                  children: [
                    FormHelper.dropDownWidgetWithLabel(
                      labelFontSize:15,
                      context,
                      "縣市/County",
                      "Select Country",
                      this.countryId,
                      this.countries,
                          (onChangedVal){
                        this.countryId=onChangedVal;
                        print("Selected Country:$onChangedVal");

                        setState(() { });
                      },
                          (onChangedVal){
                        if(onChangedVal==null){
                          return"please select Country";
                        }
                        return null;
                      },
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


              Container(
                color: Color.fromRGBO(236,240,241,1),
                height: 500,
              )
            ],
          ),
        ),
      ),
    );
  }
}

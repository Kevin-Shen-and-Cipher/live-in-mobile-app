
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

  List<dynamic> countries = [];
  List<dynamic> statesMasters = [];
  List<dynamic> state = [];

  String? countryId;
  String? stateID;

  @override
  void initState() {
    super.initState();
    this.countries=[
      {"pk": 1,"name": "台北市"},
      {"pk": 2,"name": "新北市"}
    ];
    this.statesMasters = [
      {"ID": 1, "Name": "Apple", "ParentId": 1},
      {"ID": 2, "Name": "B"    , "ParentId": 1},
      {"ID": 3, "Name": "C"    , "ParentId": 1},
      {"ID": 4, "Name": "x"    , "ParentId": 2},
      {"ID": 5, "Name": "y"    , "ParentId": 2},
      {"ID": 6, "Name": "z"    , "ParentId": 2},
    ];
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
                color: const Color.fromRGBO(126, 214, 223, 1),
                height: 80,
                padding: EdgeInsets.only(top: 25),
                child: Text("Look for house"),
              ),
              Container(
                color: Colors.redAccent,
                height: 250,
                child: Column(
                  children: [
                    FormHelper.dropDownWidgetWithLabel(
                      labelFontSize: 30,
                      context,
                      "Country",
                      "Select Country",
                      this.countryId,
                      this.countries,
                      (onChangedVal) {
                        var json = {
                          'name' : 'Justin',
                          'age'  : 40,
                          'childs' : [
                            {
                              'name1' : 'hamimi',
                              'age1'  : 3
                            }
                          ]
                        };
                        var app = jsonEncode(json);
                        // app.forEach((key, value) => print('${key}: ${value}'));
                        Map<String, dynamic> user = jsonEncode(json);
                        user.forEach((key, value) => print('${key}: ${value}'));
                        this.countryId =onChangedVal;


                        print("Selected Country:$onChangedVal");
                        this.state=this.
                        statesMasters.
                        where(
                              (stateItem)=>
                          stateItem["ParentId"].toString()==
                              onChangedVal.toString(),
                        ).toList();
                        this.stateID=null;
                        setState(() { });
                        print("22");
                      },
                      (onValidate) {
                        if (onValidate == null) {
                          return "please select Country";
                        }
                        return null;
                      },
                      borderColor: Theme.of(context).primaryColor,
                      borderFocusColor: Theme.of(context).primaryColor,
                      borderRadius: 10,
                      optionValue: "pk",
                      //optionLabel: field["name"]
                    ),
                    FormHelper.dropDownWidgetWithLabel(
                        context,
                        "State",
                        "select state",
                        this.stateID,
                        this.state,
                            (onChangedVal){
                          this.stateID=onChangedVal;
                          print("select state$onChangedVal");
                        },
                            (onValidate){
                          return null;
                        },
                        borderColor:Theme.of(context).primaryColor,
                        borderFocusColor:Theme.of(context).primaryColor,
                        borderRadius: 10,
                        optionValue: "ID",
                        optionLabel: "Name"
                    ),
                    Container(
                      //height: 100,
                      child: TextField(
                        onChanged: (text) {
                          print('First text field: $text');
                        },
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

import 'package:flutter/material.dart';
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
  List<dynamic> state=[];

  String? countryId;
  String? stateID;

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

    void area(){
      if(countryId!=null){
        var countryId_int=int.tryParse(countryId??"");
        print(countryId_int);
      }
    }


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
                color: Colors.redAccent,
                height: 250,
                child: Column(
                  children: [
                    FormHelper.dropDownWidgetWithLabel(
                      labelFontSize:30,
                      context,
                      "Century",
                      "Select Country",
                      this.countryId,
                      this.countries,
                          (onChangedVal){
                        this.countryId=onChangedVal;
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
                      Container(
                        height: 100,
                        child: TextField(
                          onChanged: (text) {
                            print('First text field: $text');
                          },
                        ),
                      ),


                    // FormHelper.dropDownWidgetWithLabel(
                    //     context,
                    //     "State",
                    //     "select state",
                    //     this.stateID,
                    //     this.state,
                    //         (onChangedVal){
                    //       this.stateID=onChangedVal;
                    //       print("select state$onChangedVal");
                    //     },
                    //         (onValidate){
                    //       return null;
                    //     },
                    //     borderColor:Theme.of(context).primaryColor,
                    //     borderFocusColor:Theme.of(context).primaryColor,
                    //     borderRadius: 10,
                    //     optionValue: "ID",
                    //     optionLabel: "Name"
                    // )
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

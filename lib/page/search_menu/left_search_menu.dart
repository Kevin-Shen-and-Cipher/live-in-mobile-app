import 'dart:convert';
import 'dart:io';
import 'package:flutter/material.dart';
import 'package:live_in/page/search_menu/data.dart';
import 'package:snippet_coder_utils/FormHelper.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:http/http.dart' as http;

import '../searchPage.dart';



class left_search_menu extends StatefulWidget {
  const left_search_menu({Key? key}) : super(key: key);
  @override
  State<left_search_menu> createState() => _left_search_menuState();
}

class _left_search_menuState extends State<left_search_menu> {

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
        path: 'api/apartments/',
        queryParameters: {
          'address': address!,
          'district': GetDistrictData(taipei_district.gettaipei_district(),newTaipei_district.getnewTaipei_districtlist()),
          'min_price': minRent,
          'max_price': maxRent,
          'rent_type': GetAllData(rent_type),
          'apartment_type': GetAllData(apartment_type),
          'room_type': GetAllData(room_type),
          'restrict': GetAllData(restrict),
          'device': GetAllData(device)
        }
    );
    print(url);
    try {
      var response = await client.get(url,headers: headers);// get????????????

      if (response.statusCode != 200) {// ??????????????????
        throw Exception('receiveData????????????');
      }

      var data = json.decode(utf8.decode(response.bodyBytes));

      print("---??????????????????----");
      Navigator.pop(context);
      print(data.runtimeType);
      print(data[0].runtimeType);

      for(int i=0;i<data.length;i++){
        Getleftdata.add(new Apartment(new Map<String, dynamic>.from(data[i])));
      }

    } catch (e) {
      print(e);
      Fluttertoast.showToast(
          backgroundColor: Colors.deepOrangeAccent,
          msg: "?????????${e}???????????????????????????",                 // message
          toastLength: Toast.LENGTH_LONG, // length
          gravity: ToastGravity.CENTER,    // location
          timeInSecForIosWeb: 3            // duration
      );
    } finally {
      client.close();// ????????????????????????
    }
  }

  taipei taipei_district=new taipei();
  newTaipei newTaipei_district=new newTaipei();
  String? countryId;
  String? address;
  String? rentId;
  String minRent='';
  String maxRent='';
  int max=1<<32;

  @override
  void initState() {
    super.initState();

  }
  @override
  Widget build(BuildContext context) {
    return SafeArea(
        child:Container(
          width: 350,
          child: Scaffold(
            appBar: AppBar(
              title: Text('?????????',),
              centerTitle: true,
              backgroundColor: Color.fromRGBO(147,197,253,1),
            ),
            body: Container(
              child: ListView(
                padding: EdgeInsets.zero,
                children: [
                  Container(
                      height: 100,
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
                            labelText: "??????????????????",
                            helperText: "*??????",
                            helperStyle: TextStyle(
                              color: Colors.red,
                            )
                        ),
                        onSubmitted: (text) {
                          address=text;
                          print(address);
                        },
                      )),//??????????????????
                  Container(
                    height: 100,
                    decoration: const BoxDecoration(
                        color: Color.fromRGBO(236, 240, 241, 1) //rgba(236, 240, 241,1.0)
                    ),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: [
                        Container(
                          padding: EdgeInsets.only(left: 15,bottom: 8,top: 10),
                          child: Row(
                            children: const [
                              Text("??????/County",
                                style: TextStyle(
                                  fontSize: 20, // ??????
                                  fontWeight: FontWeight.bold,
                                ),),
                              Text("  *??????",
                                textAlign: TextAlign.left,
                                style: TextStyle(
                                  fontSize: 12,
                                  color: Colors.red,
                                ),)
                            ],),
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
                  ),//??????????????????
                  if (countryId == '1')
                    Container(
                      color:  Color.fromRGBO(236,240,241,1),
                      padding: EdgeInsets.only(left: 30),
                      child: Wrap(
                        spacing: 8.0, // ??????(??????)????????????
                        runSpacing: 4.0, // ??????????????????????????????
                        children: <Widget>[
                          for(int i=0;i<taipei_district.gettaipei_districtLength();i++)
                            InputChip(
                                selected: taipei_district.gettaipei_district()[i][1],
                                label: Text(taipei_district.gettaipei_district()[i][0]+"???"),
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
                    ),//??????
                  if (countryId == '2')
                    Container(
                      color:  Color.fromRGBO(236,240,241,1),
                      padding: EdgeInsets.only(left: 30),
                      child: Wrap(
                        spacing: 8.0, // ??????(??????)????????????
                        runSpacing: 4.0, // ??????????????????????????????
                        children: <Widget>[
                          for(int i=0;i<newTaipei_district.getnewTaipei_districtlistLength();i++)
                            InputChip(
                                selected: newTaipei_district.getnewTaipei_districtlist()[i][1],
                                label: Text(newTaipei_district.getnewTaipei_districtlist()[i][0]+"???"),
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
                    ),//??????
                  Container(
                    color: Color.fromRGBO(236, 240, 241, 300),
                    height: 50,
                    padding: EdgeInsets.only(left: 40, right: 40, bottom: 10),
                    child: ElevatedButton(
                      style: ElevatedButton.styleFrom(
                        backgroundColor: Colors.blueGrey,
                      ),
                      child: const Text(
                        '??????/Search',
                        style: TextStyle(
                          fontSize: 20, // ??????
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      onPressed: () {
                        switch(rentId){
                          case '1':
                            minRent="0";
                            maxRent="5000";
                            break;
                          case'2':
                            minRent="5000";
                            maxRent="10000";
                            break;
                          case'3':
                            minRent="10000";
                            maxRent="20000";
                            break;
                          case'4':
                            minRent="20000";
                            maxRent="30000";
                            break;
                          case'5':
                            minRent="30000";
                            maxRent="40000";
                            break;
                          case'6':
                            minRent="40000";
                            maxRent=max.toString();
                            break;
                          default :
                            minRent="0";
                            maxRent=max.toString();
                        }

                        if(address==null|| (GetAllData(taipei_district.gettaipei_district()).isEmpty
                            &&GetAllData(newTaipei_district.getnewTaipei_districtlist()).isEmpty)){
                          print("error???address or district is null");
                          Fluttertoast.showToast(
                              backgroundColor: Colors.deepOrangeAccent,
                              msg: "?????????????????????????????????????????????????????????",  // message
                              toastLength: Toast.LENGTH_SHORT, // length
                              gravity: ToastGravity.CENTER,    // location
                              timeInSecForIosWeb: 3            // duration
                          );
                        }else{
                          Getleftdata=[];//?????????????????????
                          receiveData();
                        }
                      },
                    ),
                  ),//??????
                  Container(
                    height: 100,
                    decoration: const BoxDecoration(
                        color: Color.fromRGBO(236, 240, 241, 1) //rgba(236, 240, 241,1.0)
                    ),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: [
                        Container(
                          padding: EdgeInsets.only(left: 15,bottom: 8,top: 10),
                          child: Row(
                            children: const [
                              Text("??????/Rent",
                                style: TextStyle(
                                  fontSize: 20, // ??????
                                  fontWeight: FontWeight.bold,
                                ),),

                            ],),
                        ),
                        FormHelper.dropDownWidget(
                          context,
                          "Select rent",
                          this.rentId,
                          rent,
                              (onChangedVal) {
                            this.rentId = onChangedVal;
                            print("Selected rent:$onChangedVal");
                            setState(() {});
                          },
                              (onChangedVal) {
                            if (onChangedVal == null) {
                              return "please select rent";}
                            return null;},
                          borderColor: Theme.of(context).primaryColor,
                          borderFocusColor: Theme.of(context).primaryColor,
                          borderRadius: 10,
                          optionValue: "pk",
                        ),
                      ],
                    ),
                  ),//??????
                  Container(
                      color: Color.fromRGBO(236, 240, 241, 1),
                      height: 150,
                      padding: EdgeInsets.only(left: 15, top: 10),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          const Text(
                            "????????????/Type of lease",
                            textAlign: TextAlign.left,
                            overflow: TextOverflow.ellipsis,
                            style: TextStyle(
                              fontSize: 20, // ??????
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          Wrap(
                              spacing: 8.0, // ??????(??????)????????????
                              runSpacing: 4.0, // ??????????????????????????????
                              children: <Widget>[
                                for (int i = 0; i < rent_type.length; i++)
                                  InputChip(
                                      selected: rent_type[i][1],
                                      label: Text(rent_type[i][0]),
                                      labelStyle: TextStyle(color: Colors.white),
                                      avatar: Icon(
                                        Icons.add,
                                      ),
                                      backgroundColor: Colors.black54,
                                      selectedColor: Colors.blue,
                                      onPressed: () {
                                        setState(() {
                                          rent_type[i][1] = !rent_type[i][1];
                                          print(
                                            rent_type[i][0] +"test" + ' is ' + (rent_type[i][1]).toString(),
                                          );
                                        });
                                      }),
                              ]),
                        ],
                      )),//????????????
                  Container(
                      color: Color.fromRGBO(236, 240, 241, 1),
                      height: 100,
                      padding: EdgeInsets.only(left: 15),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          const Text(
                            "??????/Pattern",
                            textAlign: TextAlign.left,
                            overflow: TextOverflow.ellipsis,
                            style: TextStyle(
                              fontSize: 20, // ??????
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          Wrap(
                              spacing: 8.0, // ??????(??????)????????????
                              runSpacing: 4.0, // ??????????????????????????????
                              children: <Widget>[
                                for (int i = 0; i < room_type.length; i++)
                                  InputChip(
                                      selected: room_type[i][1],
                                      label: Text(room_type[i][0]),
                                      labelStyle: TextStyle(color: Colors.white),
                                      avatar: Icon(
                                        Icons.add,
                                      ),
                                      backgroundColor: Colors.black54,
                                      selectedColor: Colors.blue,
                                      onPressed: () {
                                        setState(() {
                                          room_type[i][1] = !room_type[i][1];
                                          print(
                                            room_type[i][0] +
                                                ' is ' +
                                                (room_type[i][1]).toString(),
                                          );
                                        });
                                      }),
                              ]),
                        ],
                      )),//??????
                  Container(
                      color: Color.fromRGBO(236, 240, 241, 1),
                      height: 100,
                      padding: EdgeInsets.only(left: 15),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          const Text(
                            "????????????/Type",
                            textAlign: TextAlign.left,
                            overflow: TextOverflow.ellipsis,
                            style: TextStyle(
                              fontSize: 20, // ??????
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          Wrap(
                              spacing: 8.0, // ??????(??????)????????????
                              runSpacing: 4.0, // ??????????????????????????????
                              children: <Widget>[
                                for (int i = 0; i < apartment_type.length; i++)
                                  InputChip(
                                      selected: apartment_type[i][1],
                                      label: Text(apartment_type[i][0]),
                                      labelStyle: TextStyle(color: Colors.white),
                                      avatar: Icon(
                                        Icons.add,
                                      ),
                                      backgroundColor: Colors.black54,
                                      selectedColor: Colors.blue,
                                      onPressed: () {
                                        setState(() {
                                          apartment_type[i][1] =
                                          !apartment_type[i][1];
                                          print(
                                            apartment_type[i][0] +
                                                ' is ' +
                                                (apartment_type[i][1]).toString(),
                                          );
                                        });
                                      }),
                              ]),
                        ],
                      )),//????????????
                  Container(
                      color: Color.fromRGBO(236, 240, 241, 1),
                      height: 150,
                      padding: EdgeInsets.only(left: 15),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          const Text(
                            "??????/Device",
                            textAlign: TextAlign.left,
                            overflow: TextOverflow.ellipsis,
                            style: TextStyle(
                              fontSize: 20, // ??????
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          Wrap(
                              spacing: 8.0, // ??????(??????)????????????
                              runSpacing: 4.0, // ??????????????????????????????
                              children: <Widget>[
                                for (int i = 0; i < device.length; i++)
                                  InputChip(
                                      selected: device[i][1],
                                      label: Text(device[i][0]),
                                      labelStyle: TextStyle(color: Colors.white),
                                      avatar: Icon(
                                        Icons.add,
                                      ),
                                      backgroundColor: Colors.black54,
                                      selectedColor: Colors.blue,
                                      onPressed: () {
                                        setState(() {
                                          device[i][1] = !device[i][1];
                                          print(
                                            device[i][0] +
                                                ' is ' +
                                                (device[i][1]).toString(),
                                          );
                                        });
                                      }),
                              ]),
                        ],
                      )),//??????
                  Container(
                      color: Color.fromRGBO(236, 240, 241, 1),
                      height: 150,
                      padding: EdgeInsets.only(left: 15),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          const Text(
                            "??????/Restrict",
                            textAlign: TextAlign.left,
                            overflow: TextOverflow.ellipsis,
                            style: TextStyle(
                              fontSize: 20, // ??????
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          Wrap(
                              spacing: 8.0, // ??????(??????)????????????
                              runSpacing: 4.0, // ??????????????????????????????
                              children: <Widget>[
                                for (int i = 0; i < restrict.length; i++)
                                  InputChip(
                                      selected: restrict[i][1],
                                      label: Text(restrict[i][0]),
                                      labelStyle: TextStyle(color: Colors.white),
                                      avatar: Icon(
                                        Icons.add,
                                      ),
                                      backgroundColor: Colors.black54,
                                      selectedColor: Colors.blue,
                                      onPressed: () {
                                        setState(() {
                                          restrict[i][1] = !restrict[i][1];
                                          print(
                                            restrict[i][0] +
                                                ' is ' +
                                                (restrict[i][1]).toString(),
                                          );
                                        });
                                      }),
                              ]),
                        ],
                      )),//??????
                ],
              ),
            ),
          ),
        )

    );


  }


}

import 'dart:convert';
import 'dart:io';
import 'package:flutter/material.dart';
import 'package:live_in/page/search_menu/data.dart';
import 'package:snippet_coder_utils/FormHelper.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:getwidget/getwidget.dart';
import 'package:http/http.dart' as http;
// import 'package:basic_utils/basic_utils.dart';

class left_search_menu extends StatefulWidget {
  const left_search_menu({Key? key}) : super(key: key);

  @override
  State<left_search_menu> createState() => _left_search_menuState();
}

class _left_search_menuState extends State<left_search_menu> {


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
  List<dynamic> GetDistrictData(List<dynamic> listTaipei,List<dynamic> listNewTaipei){
    List<dynamic> Returnlist=[];
    if(countryId == '1'){
      for(int i=0;i<listTaipei.length;i++){
        if(listTaipei[i][1]){
          Returnlist.add(i+1);
        }
      }
    }
    if(countryId == '2'){
      for(int i=0;i<listNewTaipei.length;i++){
        if(listNewTaipei[i][1]){
          Returnlist.add(i+13);
        }
      }
    }
    return  Returnlist;
  }
  List<dynamic> GetAllData(List<dynamic> list){
    List<dynamic> Returnlist=[];
    for(int i=0;i<list.length;i++){
      if(list[i][1]){
        Returnlist.add(i+1);
      }
    }
    return  Returnlist;
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

  String? countryId;
  String? address;
  String? rentId;
  int max=1<<32;
  String minRent='';
  String maxRent='';

  taipei taipei_district=new taipei();
  newTaipei newTaipei_district=new newTaipei();

  static var _Getdata=[];
  PostData(Map<String, dynamic> data)async{
    final url ="https://www.live-in.moonnight.software/api/apartment";
    var client=http.Client();
    try{
      final response=await client.post(Uri.parse(url),body:data);

      if (response.statusCode != 200) {
        throw Exception('請求失敗');
      }
    } catch (e) {
      // 处理错误
      print(e);
    } finally {
      // 確保 HttpClient 在不需要時被關閉
      client.close();
    }
  }
  receiveData(Map<String, dynamic> data) async {
    var client = http.Client();

    final headers = {HttpHeaders.contentTypeHeader: 'application/json'};
    var queryString = data.entries.map((e) => '${e.key}=${e.value}').join('&');
    var url = Uri.parse('https://www.live-in.moonnight.software/api/apartments/?$queryString');

    String queryString2 = Uri(queryParameters: data).query;
    var url2 = Uri.https('https://www.live-in.moonnight.software','/api/apartments',data);

    // final stringData = data.map((key, value) => MapEntry('$key', '$value'));
    // final queryString3 = Uri.encodeQueryComponent(stringData);
    // final stringData = data.isEmpty ? '' : data.map((key, value) => MapEntry('$key', '$value'));
    // final queryString3 = Uri.encodeQueryComponent(stringData);

    print(url2);
    try {
      var response = await client.get(url2,headers: headers);// get接收資料

      if (response.statusCode != 200) {// 確保請求成功
        throw Exception('receiveData請求失敗');
      }
      final data = json.decode(response.body);
      print("---分隔線----");
      print(data);
      setState(() {
        _Getdata=data;
      });
    } catch (e) {
      print(e);
    } finally {
      client.close();// 在不需要時被關閉
    }
  }

  @override
  void initState() {
    super.initState();
  }
  @override
  Widget build(BuildContext context) {
    return Container(
      width: 350,
      child: Drawer(
        child: Container(
          child: ListView(
            padding: EdgeInsets.zero,
            children: [
              Container(
                color: const Color.fromRGBO(147, 197, 253, 1),
                height: 80,
                padding: EdgeInsets.only(top: 35),
                child: const Text(
                  "找房子",
                  textAlign: TextAlign.center,
                  overflow: TextOverflow.ellipsis,
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 20, // 大小
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
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
                    color: Color.fromRGBO(236, 240, 241, 1) //rgba(236, 240, 241,1.0)
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
                        ],),
                    ),
                    FormHelper.dropDownWidget(
                      context,
                      "Select County",
                      this.countryId,
                      this.countries,
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
              ),//位置下拉選單
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
              ),//台北
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
              ),//新北
              Container(//收尋
                color: Color.fromRGBO(236, 240, 241, 300),
                height: 50,
                padding: EdgeInsets.only(left: 40, right: 40, bottom: 10),
                child: ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.blueGrey,
                  ),
                  child: const Text(
                    '收尋/Search',
                    style: TextStyle(
                      fontSize: 20, // 大小
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
                      print("error，address or district is null");
                      Fluttertoast.showToast(
                          backgroundColor: Colors.deepOrangeAccent,
                          msg: "錯誤，「目前工作地址」和「位置」為必填",  // message
                          toastLength: Toast.LENGTH_SHORT, // length
                          gravity: ToastGravity.CENTER,    // location
                          timeInSecForIosWeb: 3            // duration
                      );
                    }else{
                      Job job=new Job(
                          address!,
                          GetDistrictData(taipei_district.gettaipei_district(),newTaipei_district.getnewTaipei_districtlist()),
                          minRent,
                          maxRent,
                          GetAllData(rent_type),
                          GetAllData(apartment_type),
                          GetAllData(room_type),
                          GetAllData(restrict),
                          GetAllData(device));
                      final data=job.toJson();
                      print(data);
                      receiveData(data);
                      //PostData(data);
                    }
                  },
                ),
              ),
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
                          Text("租金/Rent",
                            style: TextStyle(
                              fontSize: 20, // 大小
                              fontWeight: FontWeight.bold,
                            ),),

                        ],),
                    ),
                    FormHelper.dropDownWidget(
                      context,
                      "Select rent",
                      this.rentId,
                      this.rent,
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
              ),
              Container(
                  color: Color.fromRGBO(236, 240, 241, 1),
                  height: 150,
                  padding: EdgeInsets.only(left: 15, top: 10),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const Text(
                        "租賃類型/Type of lease",
                        textAlign: TextAlign.left,
                        overflow: TextOverflow.ellipsis,
                        style: TextStyle(
                          fontSize: 20, // 大小
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      Wrap(
                          spacing: 8.0, // 主轴(水平)方向间距
                          runSpacing: 4.0, // 纵轴（垂直）方向间距
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
                  )),//租賃類型
              Container(
                  color: Color.fromRGBO(236, 240, 241, 1),
                  height: 150,
                  padding: EdgeInsets.only(left: 15),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const Text(
                        "格局/Pattern",
                        textAlign: TextAlign.left,
                        overflow: TextOverflow.ellipsis,
                        style: TextStyle(
                          fontSize: 20, // 大小
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      Wrap(
                          spacing: 8.0, // 主轴(水平)方向间距
                          runSpacing: 4.0, // 纵轴（垂直）方向间距
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
                  )),//格局
              Container(
                  color: Color.fromRGBO(236, 240, 241, 1),
                  height: 100,
                  padding: EdgeInsets.only(left: 15),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const Text(
                        "房子型態/Type",
                        textAlign: TextAlign.left,
                        overflow: TextOverflow.ellipsis,
                        style: TextStyle(
                          fontSize: 20, // 大小
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      Wrap(
                          spacing: 8.0, // 主轴(水平)方向间距
                          runSpacing: 4.0, // 纵轴（垂直）方向间距
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
                  )),//房子型態
              Container(
                  color: Color.fromRGBO(236, 240, 241, 1),
                  height: 200,
                  padding: EdgeInsets.only(left: 15),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const Text(
                        "設備/Device",
                        textAlign: TextAlign.left,
                        overflow: TextOverflow.ellipsis,
                        style: TextStyle(
                          fontSize: 20, // 大小
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      Wrap(
                          spacing: 8.0, // 主轴(水平)方向间距
                          runSpacing: 4.0, // 纵轴（垂直）方向间距
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
                  )),//設備
              Container(
                  color: Color.fromRGBO(236, 240, 241, 1),
                  height: 150,
                  padding: EdgeInsets.only(left: 15),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const Text(
                        "限制/Restrict",
                        textAlign: TextAlign.left,
                        overflow: TextOverflow.ellipsis,
                        style: TextStyle(
                          fontSize: 20, // 大小
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      Wrap(
                          spacing: 8.0, // 主轴(水平)方向间距
                          runSpacing: 4.0, // 纵轴（垂直）方向间距
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
                  )),//限制

            ],
          ),
        ),
      ),
    );
  }
}

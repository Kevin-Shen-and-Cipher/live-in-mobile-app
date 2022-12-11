import 'package:flutter/material.dart';
import 'package:live_in/page/search_menu/data.dart';
import 'package:live_in/page/search_menu/righ_search_menu.dart';
import 'search_menu/searchPage_DataDetails.dart';
import 'search_menu/left_search_menu.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

class SearchPage extends StatefulWidget {
  const SearchPage({Key? key}) : super(key: key);

  @override
  State<SearchPage> createState() => _SearchPageState();
}
  var _Getdata=[];
class _SearchPageState extends State<SearchPage> {

  receiveData() async {
    var client = http.Client();
    var url = Uri.parse('https://www.live-in.moonnight.software/api');

    try {
      var response = await client.get(url);// 使用 `get()` 方法接收資料
      if (response.statusCode != 200) {// 確保請求成功
        throw Exception('請求失敗');
      }
      final data = json.decode(response.body)as List;
      setState(() {
        _Getdata=data;
      });
    } catch (e) {
      print(e);// 处理错误
    } finally {
      client.close();// 確保 HttpClient 在不需要時被關閉
    }
  }
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    receiveData();
  }

  int drawerIndex=0;

  List<House> houses = getHouses();
  static const List<dynamic> testdata = [
    {"title": "i am title1", "abc": "i am abc1"},
    {"title": "i am title2", "abc": "i am abc2"},
    {"title": "i am title3", "abc": "i am abc3"},
    {"title": "i am title4", "abc": "i am abc4"},
    {"title": "i am title5", "abc": "i am abc5"},
    {"title": "i am title6", "abc": "i am abc6"},
    {"title": "i am title7", "abc": "i am abc7"},
    {"title": "i am title8", "abc": "i am abc8"},
    {"title": "i am title9", "abc": "i am abc9"},
    {"title": "i am title10", "abc": "i am abc10"},
  ];
  static List<House> getHouses() {
    return testdata.map<House>(House.fromJson).toList();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: const Color.fromRGBO(147, 197, 253, 1),
        title: Text(
          'LiveIn',
        ),
        centerTitle: true,
        leading: Builder(
          builder: (context) {
            return IconButton(
              icon: Icon(Icons.house),
              onPressed: () {
                Scaffold.of(context).openDrawer();
              },
            );
          },
        ),
        actions: <Widget>[
          Builder(
            builder: (context) {
              return IconButton(
                icon: Icon(Icons.work),
                onPressed: () {
                  Scaffold.of(context).openEndDrawer();
                },
              );
            },
          )
        ],
      ),
      drawer: left_search_menu(),
      endDrawer: righ_search_menu(),
      body: Center(
        child: buildJob(getHouses()),
      ),
    );
  }
}

Widget buildJob(List<House> houses) => ListView.builder(
      itemCount: _Getdata.length,
      itemBuilder: (context, index) {
        final house = _Getdata[index];

        return Card(
          child: ListTile(
            leading: CircleAvatar(
              radius: 28,
              backgroundColor: Colors.red,
            ),
            title: Text(house.title),
            subtitle: Text(house.abc),
            onTap:(){
              Navigator.push(context, MaterialPageRoute(
                  builder: (context)=>dataDetail()));},
          ),
        );
      },
    );

class House {
  final String title;
  final String abc;

  House({required this.title, required this.abc});

  // static House.fromJson(Map<String, dynamic> json)
  //     : title = json['title'],
  //       abc = json['abc'];
  static House fromJson(json) => House(
        title: json["title"],
        abc: json["abc"],
      );
  Map<String, dynamic> toJson() => {
        'title': title,
        'abc': abc,
      };
}

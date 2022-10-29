import 'package:flutter/material.dart';

class taipeiDistrict extends StatefulWidget {
  const taipeiDistrict({Key? key}) : super(key: key);

  @override
  State<taipeiDistrict> createState() => _taipeiDistrictState();
}

class _taipeiDistrictState extends State<taipeiDistrict> with SingleTickerProviderStateMixin {
  late AnimationController _controller;


  List<dynamic> district=[["中山區",false],["大安區",false],["信義區",false],["士林區",false],
    ["內湖區",false],["中正區",false],["萬華區",false],["松山區",false],["大同區",false],
    ["文山區",false],["北投區",false],["南港區",false],["板橋區",false],["三重區",false],
    ["淡水區",false],["中和區",false],["永和區",false],["新莊區",false],["新店區",false],
    ["汐止區",false],["林口區",false],["蘆洲區",false],["土城區",false],["三峽區",false],
    ["泰山區",false],["鶯歌區",false],["樹林區",false],["五股區",false],["八里區",false],
    ["深坑區",false],["三芝區",false],["瑞芳區",false],["金山區",false],["萬里區",false],
    ["烏來區",false],["貢寮區",false],["坪林區",false],["石碇區",false],["平溪區",false],
    ["雙溪區",false],["石門區",false],];


  @override
  void initState() {
    super.initState();
    _controller = AnimationController(vsync: this);
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.only(left: 10),
      child: Wrap(
        spacing: 8.0, // 主轴(水平)方向间距
        runSpacing: 4.0, // 纵轴（垂直）方向间距
        children: <Widget>[
          for(int i=0;i<district.length;i++)
            InputChip(
                selected: district[i][1],
                label: Text(district[i][0]),
                labelStyle: TextStyle(color: Colors.white),
                avatar: Icon(Icons.add,),
                backgroundColor: Colors.black54,
                selectedColor: Colors.blue,
                onPressed: () {

                  setState(() {
                    district[i][1] = !district[i][1];
                    print(district[i][0]+' is '+(district[i][1]).toString(),);
                  });
                }
            ),
        ],
      ),
    );
  }
}

import 'package:flutter/material.dart';

class newTaipei_district extends StatefulWidget {
  const newTaipei_district({Key? key}) : super(key: key);

  @override
  State<newTaipei_district> createState() => _newTaipei_districtState();
}

class _newTaipei_districtState extends State<newTaipei_district> {

  List<dynamic> district=[["板橋",false],["三重",false], ["淡水",false],
    ["中和",false],["永和",false],["新莊",false],["新店",false], ["汐止",false],
    ["林口",false],["蘆洲",false],["土城",false],["三峽",false], ["泰山",false],
    ["鶯歌",false],["樹林",false],["五股",false],["八里",false], ["深坑",false],
    ["三芝",false],["瑞芳",false],["金山",false],["萬里",false], ["烏來",false],
    ["貢寮",false],["坪林",false],["石碇",false],["平溪",false], ["雙溪",false],
    ["石門",false],];

  @override
  Widget build(BuildContext context) {
    return  Container(
      color:  Color.fromRGBO(236,240,241,1),
      padding: EdgeInsets.only(left: 30),
      child: Wrap(
        spacing: 8.0, // 主轴(水平)方向间距
        runSpacing: 4.0, // 纵轴（垂直）方向间距
        children: <Widget>[
          for(int i=0;i<district.length;i++)
            InputChip(
                selected: district[i][1],
                label: Text(district[i][0]+"區"),
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

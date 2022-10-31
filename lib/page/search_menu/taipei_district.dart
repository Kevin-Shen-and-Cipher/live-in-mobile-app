import 'package:flutter/material.dart';

class taipeiDistrict extends StatefulWidget {
  const taipeiDistrict({Key? key}) : super(key: key);

  @override
  State<taipeiDistrict> createState() => _taipeiDistrictState();
}
   List<dynamic> taipei_district=[
  ["中山",false],["大安",false],["信義",false],["士林",false],
  ["內湖",false],["中正",false],["萬華",false],["松山",false],
  ["大同",false], ["文山",false],["北投",false],["南港",false]];
class _taipeiDistrictState extends State<taipeiDistrict> with SingleTickerProviderStateMixin {
  late AnimationController _controller;

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
        color:  Color.fromRGBO(236,240,241,1),
        padding: EdgeInsets.only(left: 30),
        child: Wrap(
          spacing: 8.0, // 主轴(水平)方向间距
          runSpacing: 4.0, // 纵轴（垂直）方向间距
          children: <Widget>[
          for(int i=0;i<taipei_district.length;i++)
            InputChip(
                selected: taipei_district[i][1],
                label: Text(taipei_district[i][0]+"區"),
                labelStyle: TextStyle(color: Colors.white),
                avatar: Icon(Icons.add,),
                backgroundColor: Colors.black54,
                selectedColor: Colors.blue,
                onPressed: () {

                  setState(() {
                    taipei_district[i][1] = !taipei_district[i][1];
                    print(taipei_district[i][0]+' is '+(taipei_district[i][1]).toString(),);
                  });
                }
            ),
        ],
      ),
    );
  }
}

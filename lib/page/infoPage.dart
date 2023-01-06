import 'package:flutter/material.dart';
import 'package:live_in/page/turtle.dart';
import 'package:url_launcher/url_launcher.dart';



class infoPage extends StatelessWidget {
  infoPage({Key? key}) : super(key: key);

  final Uri _url = Uri.parse('https://github.com/Kevin-Shen-and-Cipher');

  Future<void> _launchUrl() async {
    if (!await launchUrl(_url)) {
      throw 'Could not launch $_url';
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text('LiveIn',),
          centerTitle: true,
          backgroundColor: Color.fromRGBO(147,197,253,1),
        ),
        body: ListView(
          children: [
            SizedBox(height: 20,),
            Container(
              height: 100,
              padding: EdgeInsets.only(top: 60,left: 80,right: 80,bottom: 0),
              child:ElevatedButton(
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.blueGrey,
                  onPrimary: Colors.white, // foreground
                ),
                onPressed: () =>showAboutUs(context),
                child: Text('About us'),
              ) ,
            ),
            Container(
              height: 100,
              padding: EdgeInsets.only(top: 60,left: 80,right: 80,bottom: 0),
              child:ElevatedButton(
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.blueGrey,
                  onPrimary: Colors.white, // foreground
                ),
                onPressed: () =>Navigator.push(
                    context,MaterialPageRoute(builder: (context) => turtle())),
                child: Text('pet'),
              ) ,
            ),
            Container(
              height: 100,
              padding: EdgeInsets.only(top: 60,left: 80,right: 80,bottom: 0),
              child:ElevatedButton(
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.blueGrey,
                  onPrimary: Colors.white, // foreground
                ),
                onPressed: ()=>showHelp(context),
                child: Text('Help'),
              ) ,
            ),
            Container(
              height: 100,
              padding: EdgeInsets.only(top: 60,left: 80,right: 80,bottom: 0),
              child:ElevatedButton(
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.blueGrey,
                  onPrimary: Colors.white, // foreground
                ),
                onPressed: _launchUrl,
                child: Text('Git Hub'),
              ) ,
            ),

          ],
        )
    );

  }
}




showAboutUs(BuildContext context) {
  // Init
  AlertDialog dialog = AlertDialog(
    title: Text("組員：\n鄭政文、沈育安、劉官瑜、\n丁襄Dragon、許哲晟"),
    actions: [
      ElevatedButton(
        child: Text("Close"),
        onPressed: () =>Navigator.of(context,rootNavigator: true).pop(),
      ),
    ],
  );
  showDialog(
      context: context,
      builder: (BuildContext context) {
        return dialog;
      }
  );
}
showHelp(BuildContext context) {
  // Init
  AlertDialog dialog = AlertDialog(
    title: Text("第一頁(Home)：為公告頁面\n\n第二頁(Search)：為收尋頁面，此頁右上"
        "Icon點擊後顯示搜索工作測攔，左上Icon點擊後顯示房屋搜索側攔，某些欄位標記「*必填」"
        "其他為選填，選好後到側攔最下方點擊搜索按鈕，將顯示結果到頁面\n\n第三頁(info)：匯集許"
        "多資訊和此app的原始碼"),
    actions: [
      ElevatedButton(
        child: Text("Close"),
        onPressed: () =>Navigator.of(context,rootNavigator: true).pop(),
      ),
    ],
  );
  showDialog(
      context: context,
      builder: (BuildContext context) {
        return dialog;
      }
  );
}
showGitHub(BuildContext context) {
  // Init
  AlertDialog dialog = AlertDialog(
    title: Text(""),
    actions: [
      ElevatedButton(
        child: Text("Close"),
        onPressed: () =>Navigator.of(context,rootNavigator: true).pop(),
      ),
    ],
  );
  showDialog(
      context: context,
      builder: (BuildContext context) {
        return dialog;
      }
  );
}
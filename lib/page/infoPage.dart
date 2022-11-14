import 'package:flutter/material.dart';

class infoPage extends StatelessWidget {
  const infoPage({Key? key}) : super(key: key);

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
                onPressed: () { },
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
                onPressed: () { },
                child: Text('Game'),
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
                onPressed: () { },
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
import 'dart:async';
import 'package:flutter/material.dart';


class turtle extends StatefulWidget {
  const turtle({Key? key}) : super(key: key);


  @override
  State<turtle> createState() => _turtleState();
}


class _turtleState extends State<turtle> {

  int count=0;
  int love=0;
  bool love_ing=false;
  var period = const Duration(seconds: 1);

  _turtleFeed(){
    count+=1;
    print(count);
    setState(() {});
  }
  _turtlePlay(){
    if(love<10){
      love+=1;
      setState(() {});
    }
    love_ing=true;
  }
  initState(){
    print("initState()");
    Timer.periodic(Duration(seconds:5), (timer){

      if(love>0){
        love-=1;
        love_ing=false;
        setState(() {});
      }
    }
    );
    Timer.periodic(Duration(seconds:2), (timer){

      if(love>0){
        love_ing=false;
        setState(() {});
      }
    }
    );
  }



  @override
  Widget build(BuildContext context) {

    return WillPopScope(
        onWillPop: () async {
          // if(status==0){
          //   showAlertDialog(context);}
          return true;
        },
        child: Scaffold(
            appBar: AppBar(
              title: Text("寵物"),
              backgroundColor: Colors.green,
              leading: IconButton(
                  onPressed:(){
                    Navigator.of(context).pop();
                    // if(status==0){
                    //   showAlertDialog(context);}
                    // else{
                    //   Navigator.of(context).pop();}
                    },
                  icon: Icon(Icons.arrow_back_ios)
              ),
              actions: <Widget>[
                Builder(
                  builder: (context) {
                    return IconButton(
                      icon: Icon(Icons.help_outline,size: 35,),
                      onPressed: () =>showHelper(context),
                    );
                  },
                )
              ],
            ),
            body: Stack(
              children: [
                Container(
                  color: Color(0xfffad390),
                  child:Column(
                    children: [
                      Container(
                        height: 450,
                        child: Column(
                          children: [
                            if(count<5 )
                              Container(
                                  margin: EdgeInsets.only(top: 165),
                                  alignment: Alignment.center,
                                  child: Column(
                                    children: [
                                      Text("龜龜",
                                        style: TextStyle(fontSize: 20,fontWeight: FontWeight.bold),),
                                      Image.asset('assets/turtle/turtle1.png'),
                                      Text("飽足感：$count /5"),
                                      Text("幸福感：$love /10")
                                    ],
                                  )
                              ),
                            if(5<=count && count<10)
                              Container(
                                  margin: EdgeInsets.only(top: 160),
                                  alignment: Alignment.center,
                                  child: Column(
                                    children: [
                                      Text("龜龜", style: TextStyle(fontSize: 20,fontWeight: FontWeight.bold),),
                                      Image.asset('assets/turtle/turtle2.png'),
                                      Text("飽足感：${count-5} /5"),
                                      Text("幸福感：$love /10")
                                    ],
                                  )
                              ),
                            if(10<=count &&count<20)
                              Container(
                                  margin: EdgeInsets.only(top: 150),
                                  alignment: Alignment.center,
                                  child: Column(
                                    children: [
                                      Text("龜龜", style: TextStyle(fontSize: 20,fontWeight: FontWeight.bold),),
                                      Image.asset('assets/turtle/turtle3.png'),
                                      Text("飽足感：${count-10} /10"),
                                      Text("幸福感：$love /10")
                                    ],
                                  )
                              ),
                            if(20<=count && count<35)
                              Container(
                                  margin: EdgeInsets.only(top: 100),
                                  alignment: Alignment.center,
                                  child: Column(
                                    children: [
                                      Text("龜龜", style: TextStyle(fontSize: 20,fontWeight: FontWeight.bold),),
                                      Image.asset('assets/turtle/turtle4.png'),
                                      Text("飽足感：${count-20} /15"),
                                      Text("幸福感：$love /10")
                                    ],
                                  )
                              ),
                            if(35<=count)
                              Container(
                                  margin: EdgeInsets.only(top: 60),
                                  alignment: Alignment.center,
                                  child: Column(
                                    children: [
                                      Text("龜龜", style: TextStyle(fontSize: 20,fontWeight: FontWeight.bold),),
                                      Image.asset('assets/turtle/turtle5.png'),
                                      Text("幸福感：$love /10"),
                                      Text("")
                                    ],
                                  )
                              ),

                          ],
                        ),
                      ),

                        Row(
                          children: [
                            Container(
                              margin: EdgeInsets.only(left: 80,right: 20),
                              child:ElevatedButton(
                                  style: ElevatedButton.styleFrom(
                                      backgroundColor: Color(0xff808069)),
                                  onPressed: _turtleFeed,
                                  child: Text(
                                      "餵食"
                                  )),
                            ),
                            Container(
                              margin: EdgeInsets.only(left: 80,right: 20),
                              child:ElevatedButton(
                                  style: ElevatedButton.styleFrom(
                                      backgroundColor: Color(0xff808069)),
                                  onPressed: _turtlePlay,
                                  child: Text(
                                      "陪伴"
                                  )
                              ),
                            ),
                          ],
                        )
                    ],
                  ),
                ),



                if(count<5 &&love_ing)
                  Container(
                    child: Image.asset('assets/love.png',),
                    height: 50,
                    width: 100,
                    margin: EdgeInsets.only(top:160,left: 90),
                  ),
                if(5<=count && count<10&&love_ing)
                  Container(
                    child: Image.asset('assets/love.png',),
                    height: 50,
                    width: 100,
                    margin: EdgeInsets.only(top:150,left: 90),
                  ),
                if(10<=count && count<20&&love_ing)
                  Container(
                    child: Image.asset('assets/love.png',),
                    height: 50,
                    width: 100,
                    margin: EdgeInsets.only(top:150,left: 80),
                  ),
                if(20<=count && count<35&&love_ing)
                  Container(
                    child: Image.asset('assets/love.png',),
                    height: 50,
                    width: 100,
                    margin: EdgeInsets.only(top:120,left: 70),
                  ),
                if(35<=count&&love_ing)
                  Container(
                    child: Image.asset('assets/love.png',),
                    height: 50,
                    width: 100,
                    margin: EdgeInsets.only(top:90,left: 50),
                  ),
              ],
            )
        )
    );
  }
}
showHelper(BuildContext context) {
  // Init
  AlertDialog dialog = AlertDialog(
    title: Text("餵食達一定量龜龜會變大隻\n幸福感會隨時間流逝\n離開此頁面龜龜會死亡\n\n(致敬第一隻養的烏龜)"),
    actions: [
      ElevatedButton(
        child: Text("OK"),
        onPressed: () =>Navigator.pop(context),
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
// Show AlertDialog
showAlertDialog(BuildContext context) {
  // Init
  AlertDialog dialog = AlertDialog(
    title: Text("如果退出\n龜龜將死亡"),
    actions: [
      ElevatedButton(
          child: Text("OK"),
          onPressed: () =>Navigator.of(context)..pop()..pop()
      ),
      ElevatedButton(
          child: Text("Cancel"),
          onPressed: () {
            Navigator.pop(context);
          }
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
// Show the dialog


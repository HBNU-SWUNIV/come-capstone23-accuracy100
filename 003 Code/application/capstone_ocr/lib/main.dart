import 'package:capstone_ocr/select_page.dart';
import 'package:capstone_ocr/user/login_page.dart';
import 'package:capstone_ocr/user/register_page.dart';
import 'package:flutter/material.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatefulWidget {
  @override
  _MyAppState createState() => _MyAppState();
}
class MyHomePage extends StatefulWidget {
  static const routeName = '/mainpage';


  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyAppState extends State<MyApp> {


  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      // 화면 오른쪽에 뜨는 디버크 표시 지우기
      debugShowCheckedModeBanner: false,
      title: 'Flutter Demo',
      home: MyHomePage(),
    );
  }
}

class _MyHomePageState extends State<MyHomePage> {
  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();
  @override
  Widget build(BuildContext context) {
    var media = MediaQuery.of(context);
    var size = media.size;
    double width = media.orientation == Orientation.portrait ? size.shortestSide : size.longestSide;
    double height = width;

    return Scaffold(
      key: _scaffoldKey,
      backgroundColor: Colors.black,
      body:
      Stack(
        fit: StackFit.expand,
        children: <Widget>[
          Image(
            image: AssetImage("assets/register_right.png"),
            fit: BoxFit.cover,
            color: Colors.black87,
            colorBlendMode: BlendMode.darken,
          ),
          Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                SizedBox(height: height*0.3),
                Text("OCR APP",style: TextStyle(fontSize: 20,color: Colors.white),),
                SizedBox(height: height*0.2),
                Container(
                  width: double.infinity,
                  margin: EdgeInsets.only(left: 20, right:20),
                  child: ElevatedButton(
                      onPressed: () {
                        Navigator.push(context, MaterialPageRoute(builder: (context) => RegisterPage()));
                      },
                      style: ElevatedButton.styleFrom(
                        backgroundColor: Colors.indigo,
                        shape: RoundedRectangleBorder( //버튼을 둥글게 처리
                            borderRadius: BorderRadius.circular(70)),
                      ),
                      child:Text("가입하기")
                  ),
                ),
                Container(
                  width: double.infinity,
                  margin: EdgeInsets.only(left: 20, right:20),
                  child: ElevatedButton(
                      onPressed: () {
                        Navigator.push(context, MaterialPageRoute(builder: (context) => SelectPage()));
                      },
                      style: ElevatedButton.styleFrom(
                        backgroundColor: Colors.white24,
                        shape: RoundedRectangleBorder( //버튼을 둥글게 처리
                            borderRadius: BorderRadius.circular(70)),
                      ),
                      child:Text("Google로 계속하기")
                  ),
                ),
                Container(
                  width: double.infinity,
                  margin: EdgeInsets.only(left: 20, right:20),
                  child: ElevatedButton(
                      onPressed: () {},
                      style: ElevatedButton.styleFrom(
                        backgroundColor: Colors.white24,
                        shape: RoundedRectangleBorder( //버튼을 둥글게 처리
                            borderRadius: BorderRadius.circular(70)),
                      ),
                      child:Text("Kakao로 계속하기")
                  ),
                ),
                Container(
                  width: double.infinity,
                  margin: EdgeInsets.only(left: 20, right:20),
                  child: ElevatedButton(
                      onPressed: () {
                        Navigator.push(context, MaterialPageRoute(builder: (context) => LoginPage()));
                      },
                      style: ElevatedButton.styleFrom(
                        backgroundColor: Colors.white70,
                        shape: RoundedRectangleBorder( //버튼을 둥글게 처리
                            borderRadius: BorderRadius.circular(70)),
                      ),
                      child:Text("로그인하기")
                  ),
                ),
              ],
            ),
          )

        ],
      ),
    );
  }
}

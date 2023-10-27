import 'package:capstone_ocr/mainpage.dart';
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
                        Navigator.push(context, MaterialPageRoute(builder: (context) => mainpage()));
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
// import 'dart:async';
// import 'dart:io';
// import 'package:edge_detection/edge_detection.dart';
// import 'package:flutter/material.dart';
// import 'package:path/path.dart';
// import 'package:path_provider/path_provider.dart';
// import 'package:permission_handler/permission_handler.dart';
// import 'package:gallery_saver/gallery_saver.dart';
// void main() {
//   runApp(MyApp());
// }
//
// class MyApp extends StatefulWidget {
//   @override
//   _MyAppState createState() => _MyAppState();
// }
//
// class _MyAppState extends State<MyApp> {
//   String? _imagePath;
//
//   @override
//   void initState() {
//     super.initState();
//   }
//
//   Future<void> getImageFromCamera() async {
//     bool isCameraGranted = await Permission.camera.request().isGranted;
//     if (!isCameraGranted) {
//       isCameraGranted =
//           await Permission.camera.request() == PermissionStatus.granted;
//     }
//
//     if (!isCameraGranted) {
//       // Have not permission to camera
//       return;
//     }
//
// // Generate filepath for saving
//     String imagePath = join((await getApplicationSupportDirectory()).path,
//         "${(DateTime.now().millisecondsSinceEpoch / 1000).round()}.jpeg");
//
//     try {
//       //Make sure to await the call to detectEdge.
//       bool success = await EdgeDetection.detectEdge(
//         imagePath,
//         canUseGallery: true,
//         androidScanTitle: 'Scanning', // use custom localizations for android
//         androidCropTitle: 'Crop',
//         androidCropBlackWhiteTitle: 'Black White',
//         androidCropReset: 'Reset',
//       );
//     } catch (e) {
//       print(e);
//     }
//
//     // If the widget was removed from the tree while the asynchronous platform
//     // message was in flight, we want to discard the reply rather than calling
//     // setState to update our non-existent appearance.
//     if (!mounted) return;
//
//     setState(() {
//       _imagePath = imagePath;
//     });
//   }
//
//
//   Future<void> getImageFromGallery() async {
// // Generate filepath for saving
//     String imagePath = join((await getApplicationSupportDirectory()).path,
//         "${(DateTime.now().millisecondsSinceEpoch / 1000).round()}.jpeg");
//
//     print("$imagePath : _imagePath");
//
//     try {
//       //Make sure to await the call to detectEdgeFromGallery.
//       bool success = await EdgeDetection.detectEdgeFromGallery(imagePath,
//         androidCropTitle: 'Crop', // use custom localizations for android
//         androidCropBlackWhiteTitle: 'Black White',
//         androidCropReset: 'Reset',
//       );
//       print("success: $success");
//     } catch (e) {
//       print(e);
//     }
//
//     // If the widget was removed from the tree while the asynchronous platform
//     // message was in flight, we want to discard the reply rather than calling
//     // setState to update our non-existent appearance.
//     if (!mounted) return;
//
//     setState(() {
//       _imagePath = imagePath;
//     });
//   }
//
//   @override
//   Widget build(BuildContext context) {
//     return MaterialApp(
//       home: Scaffold(
//         appBar: AppBar(
//           title: const Text('Plugin example app'),
//         ),
//         body: SingleChildScrollView(
//           child: Column(
//             mainAxisAlignment: MainAxisAlignment.center,
//             crossAxisAlignment: CrossAxisAlignment.center,
//             children: [
//               Center(
//                 child: ElevatedButton(
//                   onPressed: getImageFromCamera,
//                   child: Text('Scan'),
//                 ),
//               ),
//               SizedBox(height: 20),
//               Center(
//                 child: ElevatedButton(
//                   onPressed:()async{
//                     await getImageFromGallery();
//                     print("----------------------save----------------");
//                     GallerySaver.saveImage(_imagePath.toString())
//                         .then((value) => print('>>>> save value= $value'))
//                         .catchError((err) {
//                       print('error :( $err');
//                     }
//                     );
//                     },
//                   // onPressed: getImageFromGallery,
//                   child: Text('Upload'),
//                 ),
//               ),
//               SizedBox(height: 20),
//               Text('Cropped image path:'),
//               Padding(
//                 padding: const EdgeInsets.only(top: 0, left: 0, right: 0),
//                 child: Text(
//                   _imagePath.toString(),
//                   textAlign: TextAlign.center,
//                   style: TextStyle(fontSize: 14),
//                 ),
//               ),
//               Visibility(
//                 visible: _imagePath != null,
//                 child: Padding(
//                   padding: const EdgeInsets.all(8.0),
//                   child: Image.file(
//                     File(_imagePath ?? ''),
//                   ),
//                 ),
//               ),
//             ],
//           ),
//         ),
//       ),
//     );
//   }
// }
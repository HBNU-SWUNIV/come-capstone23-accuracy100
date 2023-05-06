import 'dart:io';
import 'package:flutter/material.dart';
import 'package:camera/camera.dart';
import 'flutter_camera_overlay.dart';
import 'package:flutter_camera_overlay/model.dart';
import 'package:image_cropper/image_cropper.dart';
import '../api/api.dart';
import '../modify/pregnant_page.dart';
import 'package:gallery_saver/gallery_saver.dart';

class CameraOverlayPregnant extends StatefulWidget {

  static const routeName = '/camera-overlay-pregnant-page';
  CameraOverlayPregnant({Key? key}) : super(key: key);

  @override
  CameraOverlayPregnantState createState() => CameraOverlayPregnantState();
}

class CameraOverlayPregnantState extends State<CameraOverlayPregnant> {
  // camera overlay에서 cardID2라는 카메라를 사용
  OverlayFormat format = OverlayFormat.cardID2;

  cropImage(String cameraurl) async {
    File? croppedfile = await ImageCropper().cropImage(
        sourcePath: cameraurl,

        // cropImage 비율 정의
        aspectRatioPresets: [
          CropAspectRatioPreset.square,
          CropAspectRatioPreset.ratio3x2,
          CropAspectRatioPreset.original,
          CropAspectRatioPreset.ratio4x3,
          CropAspectRatioPreset.ratio16x9
        ],
        // cropImage ui 정의
        androidUiSettings: const AndroidUiSettings(
            toolbarTitle: 'Image Cropper',
            toolbarColor: Colors.deepPurpleAccent,
            toolbarWidgetColor: Colors.white,
            initAspectRatio: CropAspectRatioPreset.original,
            lockAspectRatio: false),
        iosUiSettings: const IOSUiSettings(
          minimumAspectRatio: 1.0,
        )
    );
    return croppedfile;
  }

  @override
  Widget build(BuildContext context) {

    var media = MediaQuery.of(context);
    var size = media.size;
    double width = media.orientation == Orientation.portrait
        ? size.shortestSide * .9
        : size.longestSide * .5;
    double height = width * 1.414;

    return MaterialApp(
        debugShowCheckedModeBanner: false,
        home: Scaffold(
          backgroundColor: Colors.white,
          body: FutureBuilder<List<CameraDescription>?>(
            future: availableCameras(),
            builder: (context, snapshot) {
              if (snapshot.hasData) {
                // 카메라가 없는 경우
                if (snapshot.data == null) {
                  return const Align(
                      alignment: Alignment.center,
                      child: Text(
                        'No camera found',
                        style: TextStyle(color: Colors.black),
                      ));
                }
                return CameraOverlay(
                  // 카메라 화면
                    snapshot.data!.first,
                    // snapshot.data!.last,
                    CardOverlay.byFormat(format),
                        (XFile file) => showDialog(
                      context: context,
                      barrierColor: Colors.black,
                      builder: (context) {
                        return Container(
                          child: Stack(
                            children: [
                              Stack(fit: StackFit.expand,children:[
                                Image.file(File(file.path))]),
                              Stack(
                                alignment: Alignment.center,
                                fit: StackFit.loose,
                                children: [
                                  Align(
                                      alignment: Alignment.center,
                                      child: Container(
                                        width: width,
                                        height: height,
                                        decoration: ShapeDecoration(
                                            color: Colors.transparent,
                                            shape: RoundedRectangleBorder(
                                                borderRadius: BorderRadius.zero,
                                                // borderRadius: BorderRadius.circular(radius),
                                                side: const BorderSide(width: 1, color: Colors.white))),
                                      )
                                  ),
                                  ColorFiltered(
                                    colorFilter: const ColorFilter.mode(Colors.black, BlendMode.srcOut),
                                    child: Stack(
                                      children: [
                                        Container(
                                          decoration: const BoxDecoration(
                                            color: Colors.transparent,
                                          ),
                                          child: Align(
                                            alignment: Alignment.center,
                                            child: Container(
                                              width: width,
                                              height:height,
                                              decoration: BoxDecoration(
                                                  color: Colors.black,
                                                  borderRadius: BorderRadius.zero),
                                              // borderRadius: BorderRadius.circular(radius)),
                                            ),
                                          ),
                                        ),
                                      ],
                                    ),
                                  )
                                ],
                              ),
                              Align(
                                alignment: Alignment.topLeft,
                                child: Material(
                                    color: Colors.transparent,
                                    child: Container(
                                        decoration: const BoxDecoration(
                                          color: Colors.black12,
                                          shape: BoxShape.circle,
                                        ),
                                        margin: const EdgeInsets.all(25),
                                        child: IconButton(
                                          enableFeedback: true,
                                          color: Colors.white,
                                          onPressed: () async {
                                            Navigator.of(context).pop();
                                          },
                                          icon: const Icon(
                                            Icons.arrow_back,
                                          ),
                                          iconSize: 30,
                                        ))),
                              ),
                              Align(
                                alignment: Alignment.bottomCenter,
                                child: Material(
                                    color: Colors.transparent,
                                    child: Container(
                                        decoration: const BoxDecoration(
                                          color: Colors.black12,
                                          shape: BoxShape.circle,
                                        ),
                                        margin: const EdgeInsets.all(25),
                                        child: IconButton(
                                          enableFeedback: true,
                                          color: Colors.white,
                                          onPressed: () async {
                                            // 서버로 임신사 사진 list에 넣어서 보내기
                                            showDialog(context: context, builder: (context){
                                              return Container(
                                                padding: const EdgeInsets.fromLTRB(0, 0, 0, 0),
                                                alignment: Alignment.center,
                                                decoration: const BoxDecoration(
                                                  color: Colors.white70,
                                                ),
                                                child: Container(
                                                  // decoration: BoxDecoration(
                                                  //     color: Colors.white,
                                                  //     borderRadius: BorderRadius.circular(10.0)
                                                  // ),
                                                  width: 300.0,
                                                  height: 200.0,
                                                  alignment: AlignmentDirectional.center,
                                                  child: Column(
                                                    crossAxisAlignment: CrossAxisAlignment.center,
                                                    mainAxisAlignment: MainAxisAlignment.center,
                                                    children: <Widget>[
                                                      const Center(
                                                        child: SizedBox(
                                                          height: 50.0,
                                                          width: 50.0,
                                                          child: CircularProgressIndicator( // 로딩화면 애니메이션
                                                            value: null,
                                                            strokeWidth: 7.0,
                                                          ),
                                                        ),
                                                      ),
                                                      Container(
                                                        margin: const EdgeInsets.only(top: 25.0),
                                                        child: const Center(
                                                          child:
                                                          Text(
                                                            "loading.. wait...",
                                                            style: TextStyle(
                                                                color: Colors.blue
                                                            ),
                                                          ),
                                                        ),
                                                      ),
                                                    ],
                                                  ),
                                                ),
                                              );
                                            });
                                            List list = await uploadimg_pregnant(File(file.path));
                                            if(list[1].length==0||(list[1].every((x) => x == ""))){
                                              print("ocr인식오류");

                                              Navigator.pop(context, 'Yep!');
                                              showDialog(context: context, builder: (context){
                                                return Container(
                                                  padding: const EdgeInsets.fromLTRB(0, 0, 0, 0),
                                                  alignment: Alignment.center,
                                                  // decoration: const BoxDecoration(
                                                  //   color: Colors.white70,
                                                  // ),
                                                  child: Container(
                                                    decoration: BoxDecoration(
                                                        color: Colors.white70,
                                                        borderRadius: BorderRadius.circular(10.0)
                                                    ),
                                                    width: 300.0,
                                                    height: 100.0,
                                                    alignment: AlignmentDirectional.center,
                                                    child: Column(
                                                      crossAxisAlignment: CrossAxisAlignment.center,
                                                      mainAxisAlignment: MainAxisAlignment.center,
                                                      children: <Widget>[
                                                        Text(
                                                            "please take the picture again",
                                                            style: TextStyle(
                                                                fontSize: 17,
                                                                fontWeight: FontWeight.bold,
                                                                color: Colors.black
                                                            ))
                                                      ],
                                                    ),
                                                  ),
                                                );
                                              });
                                              await Future.delayed(Duration(seconds: 1));
                                              Navigator.pop(context, 'Yep!');
                                              Navigator.pop(context, 'Yep!');
                                            }

                                            else {
                                              // 찍은 사진 갤러리에 저장
                                              GallerySaver.saveImage(file.path)
                                                  .then((value) => print(
                                                  '>>>> save value= $value'))
                                                  .catchError((err) {
                                                print('error : $err');
                                              });

                                              Navigator.of(context).popUntil((route) => route.isFirst); // 처음 화면으로 돌아가기
                                              await Navigator.push(context,
                                                MaterialPageRoute(builder: (context) => PregnantPage(list)), // PregnantPage 넘어가기
                                              );
                                            }
                                          },
                                          icon: const Icon(
                                            Icons.send,
                                          ),
                                          iconSize: 30,
                                        )
                                    )
                                ),
                              ),
                            ],
                          ),
                        );
                      },
                    ),
                    info:
                    '박스에 맞춰 사진찍어주세요');

              } else {
                return const Align(
                    alignment: Alignment.center,
                    child: Text(
                      '임신사 카메라',
                      style: TextStyle(color: Colors.black),
                    ));
              }
            },
          ),
        )
    );
  }
}



import 'dart:convert';
import 'dart:io';
import 'package:http_parser/http_parser.dart';
import 'package:dio/dio.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:get_rx/get_rx.dart';
import 'package:intl/intl.dart';
import '../entities/Ocr_maternity.dart';
import '../entities/Ocr_pregnant.dart';
import 'package:ntp/ntp.dart';

late final domain = "http://192.168.0.26:5001/";
// late final domain = "http://192.168.1.227:8080/";
// late final domain = "http://10.0.2.2:8080/";
// late final domain = "http://127.0.0.1:8080/";
// late final domain = "http://172.17.0.8:5000/";
// late final domain = "http://210.110.250.118:5000/";


register_api(String name, String email, String password) async{
  final api = domain+"api/members/new";
  final dio = Dio();

  final data={
    "name" : name,
    "email" : email,
    "password" : password
  };
  print(data);
  Response response;
  response = await dio.post(api, data:data);
  print(response);
}

Future<int?> login_api(String email, String password) async{
  final api = domain+"api/members/login";
  final dio = Dio();

  final data={
    "email" : email,
    "password" : password
  };
  print(data);
  Response response;
  response = await dio.post(api, data:data);
  print(response);
  print(response.statusCode);
  return response.statusCode;
}

// 서버로 현재 날짜를 보내고 임신사의 교배복수 총합 받기
send_date_pregnant(List sendlist) async {
  // print("send_date_pregnant");
  final api = domain+'ocrPregnantSendDate';
  final dio = Dio();

  final data={
    'everysunday':sendlist
  };
  Response response;
  // print(data);
  response = await dio.post(api, data:data);
  // if(response.statusCode==200){
  //   print("날짜보내기 성공");
  // }
  // else{
  //   print("날짜보내기 실패");
  // }
  // print("pre-returndata");
  // print(response.data);

  List<dynamic> li = response.data;

  return li;
}

// 서버로 현재 날짜를 보내고 분만사의 총산자수, 포유개시두수, 이유두수의 총합 받기
send_date_maternity(List sendlist) async {
  // print("materntiy");
  final api = domain+'api/ocrMaternitySendDate';
  final dio = Dio();

  final data={
    'everysunday':sendlist
  };
  Response response;
  // print("send_date_maternity");
  // print(data);
  response = await dio.post(api, data:data);
  // if(response.statusCode==200){
  //   print("날짜보내기 성공");
  // }
  // else{
  //   print("날짜보내기 실패");
  // }
  // print("returndata");
  // print(response.data);
  List<dynamic> li = response.data;
  return li;
}

// 서버에 현재 날짜와 교배복수, 총산자수, 포유개시두수, 이유두수의 목표값 보내고 받기
ocrTargetInsertUpdate(String yyyy, String mm, String sow_totalbaby, String sow_feedbaby, String sow_sevrer, String sow_cross) async {
  // print("ocrTargetInsertUpate");
  final api = domain+'ocrTargetInsertUpdate';
  final dio = Dio();

  final data={
    'yyyy': yyyy,
    'mm':mm,
    'sow_totalbaby':sow_totalbaby,
    'sow_feedbaby' : sow_feedbaby,
    'sow_sevrer' : sow_sevrer,
    'sow_cross' : sow_cross,
  };
  Response response;
  // print(data);
  response = await dio.post(api, data:data);
  // if(response.statusCode==200){
  //   print("목표값보내기 성공");
  // }
  // else{
  //   print("목표값보내기 실패");
  // }
  // print("returndata-목표값");
  // print(response.data);
}

// 서버에 현재 날짜 보내고 목표값 받기
ocrTargetSelectedRow(String yyyy, String mm) async {
  final api = domain+'ocrTargetSelectedRow';
  final dio = Dio();

  final data={
    'yyyy': yyyy,
    'mm':mm,
  };
  Response response;
  // print(data);
  response = await dio.post(api, data:data);
  // if(response.statusCode==200){
  //   print("목표값받기 성공");
  // }
  // else{
  //   print("목표값받기 실패");
  // }
  // print(response.data);

  // 총산자수, 포유, 이유, 교배 순으로 계산 값을 받아온다
  return response.data;
}

Future<List> uploadimg_pregnant(File file)async{
  // print("uploadimg_pregnant");
  final api = domain+'api/ocrImageUpload';
  final dio = Dio();

  DateTime currentTime = await NTP.now();
  currentTime = currentTime.toUtc().add(Duration(hours: 9));
  String formatDate = DateFormat('yyyyMMddHHmmss').format(currentTime); //format변경
  String fileName = "pre"+formatDate+'.jpg';
  // print(api);
  // print(fileName);
  FormData _formData = FormData.fromMap({
    "files" : await MultipartFile.fromFile(file.path,
        filename: fileName, contentType : MediaType("image","jpg")),
  });
  Response response = await dio.post(
      api,
      data:_formData,
      onSendProgress: (rec, total) {
        // print('Rec: $rec , Total: $total');
      }
  );

  // Response response = await dio.get(api);

  if(response.statusCode == 200){
    resultToast("upload success");
  }
  else{
    resultToast("upload failed");
  }
  print(response.data);
  // print(response.data.runtimeType);
  // Map<String,dynamic> jsonData = jsonDecode(response.data);
  // print(response.data['filename']);
  // List li = [];
  // li.add(response.data['filename']);
  // li.add(response.data['json_values']);
//{filename: , json_values: [3478-4, 21, 8, 15, 22, 8, 27, 22, 4, 5, 4, 14, 2361-8, 3457-3, 10, 3, 11, 15, , 7, 8, 14, 10, 21, 12, 25]}
  // print('Successfully uploaded');

  // return li;
  return response.data;
}
// 서버로 임신사 사진 보내는 api
// Future<List> uploadimg_pregnant(File file)async{
//   // print("uploadimg_pregnant");
//   final api = domain+'api/ocrImageUpload';
//   final dio = Dio();
//
//   DateTime currentTime = await NTP.now();
//   currentTime = currentTime.toUtc().add(Duration(hours: 9));
//   String formatDate = DateFormat('yyyyMMddHHmm').format(currentTime); //format변경
//   String fileName = "pre"+formatDate+'.jpg';
//   // print(api);
//   // print(fileName);
//   FormData _formData = FormData.fromMap({
//     "file" : await MultipartFile.fromFile(file.path,
//         filename: fileName, contentType : MediaType("image","jpg")),
//   });
//
//   Response response = await dio.post(
//       api,
//       data:_formData,
//       onSendProgress: (rec, total) {
//         // print('Rec: $rec , Total: $total');
//       }
//   );
//   if(response.statusCode == 200){
//     resultToast("upload success");
//   }
//   else{
//     resultToast("upload failed");
//   }
//   // print(response);
//   // print('Successfully uploaded');
//   return response.data;
// }

// 선택한 임신사 기록 불러오기, ocr_seq를 보내고 그 값을 받아옴
pregnant_selectrow(int num) async{
  final api =domain+'ocr_pregnantSelectedRow';
  final data = {
    "ocr_seq": num, //pk
  };
  final dio = Dio();
  Response response;
  response = await dio.post(api,data: data);
  // if(response.statusCode == 200) {
  //   print("col 1.."+response.data[0].toString());
  //   print("col 10.."+response.data[10].toString());
  // }else{
  //   print(" fail..."+response.statusCode.toString());
  // }
  return response.data;
}

// homepage img 불러오기
homepage_img() async {
  List list = [];
  final api =domain+'launchersGetList';
  final dio = Dio();
  Response response = await dio.get(api);

  if(response.statusCode == 200) {
    for(int i = 0 ; i < 26 ; i++){
      list.add(response.data[i]);
    }
  }
  else{
    // print(" fail..."+response.statusCode.toString());
  }
  // print(list);
  return list;
}

pregnant_deleterow(int num) async{
  final api =domain+'ocr_pregnantDelete';
  final data = {
    "ocr_seq": num, //pk
  };
  final dio = Dio();
  Response response;
  // print("행 삭제 합니다");
  response = await dio.post(api,data: data);
  if(response.statusCode == 200) {
    resultToast("Successfully deleted");
    //   print("행 삭제");
    //   print("*******************");
  }else{
    resultToast("fail to delete");
    //   print(" fail..."+response.statusCode.toString());
  }
}

// 임신사 전체 기록 불러오기
pregnant_getocr() async {
  var pregnants = <Ocr_pregnant>[].obs;
  List<int> list_ocr_seq = [];
  List<String> list_sow_no = [];
  List<String> list_upload_day = [];
  List<dynamic> list_add = [];

  final api =domain+'getOcr_pregnant';
  // final data = {
  // };
  final dio = Dio();
  // Response response = await dio.post(api,data: data);
  Response response = await dio.get(api);

  if(response.statusCode == 200) {

    List<dynamic> result = response.data;
    pregnants.assignAll(result.map((data) => Ocr_pregnant.fromJson(data)).toList());
    pregnants.refresh();
    for(int i=0; i<pregnants.length; i++){
      if(i == 0) {
        // print(" success..." + pregnants[i].ocr_seq.toString() + " " + pregnants[i].sow_no.toString());
        list_ocr_seq.add(pregnants.length);
        list_sow_no.add(pregnants.length.toString());
        list_upload_day.add(pregnants.length.toString());
      }
      // print(" success!"+ pregnants[i].ocr_seq.toString()+" " +pregnants[i].sow_no.toString());
      list_ocr_seq.add(pregnants[i].ocr_seq!.toInt());
      list_sow_no.add(pregnants[i].sow_no!.toString());
      list_upload_day.add(pregnants[i].input_date.toString()+" "+pregnants[i].input_time.toString().split(":")[0]+":"+pregnants[i].input_time.toString().split(":")[1]);
    }
  }
  else{
    // print(" fail..."+response.statusCode.toString());
  }

  for( int i=0; i< list_ocr_seq.length; i++){
    list_add += [[list_ocr_seq[i],list_sow_no[i],list_upload_day[i]]];
  }

  // print(list_add);
  // print("Return");
  return list_add;
}

// 임신사 리스트 삭제
delete_pregnant() async{
  final api =domain+'ocrDeleteAll';
  // final data = {
  // };
  final dio = Dio();
  Response response = await dio.get(api);
  // Response response = await dio.post(api,data: data);
  // if(response.statusCode == 200) {
  //   print("successfully deleted");
  // }else{
  //   print("failed to delete");
  // }
}

// 서버로 분만사 사진 보내는 api
Future<List> uploadimg_maternity(File file)async{
  final api =domain+'api/ocrImageUpload';
  final dio = Dio();

  DateTime currentTime = await NTP.now();

  currentTime = currentTime.toUtc().add(Duration(hours: 9));
  String formatDate = DateFormat('yyyyMMddHHmmss').format(currentTime); //format변경
  String fileName = "mat"+formatDate+'.jpg';

  FormData _formData = FormData.fromMap({
    "files" : await MultipartFile.fromFile(file.path,
        filename: fileName, contentType : MediaType("image","jpg")),
  });
  print(_formData);
  Response response = await dio.post(
      api,
      data:_formData,
      onSendProgress: (rec, total) {
        print('Rec: $rec , Total: $total');
      }
  );
  if(response.statusCode == 200){
    resultToast("upload success");
  }
  else{
    resultToast("upload failed");
  }
  print(response.data);
  List li = [];
  li.add(response.data['filename']);
  li.add(response.data['json_values']);

  return li;
  return response.data;
}

// 선택한 분만사 기록 불러오기, ocr_seq를 보내고 그 값을 받아옴
maternity_selectrow(int num) async {
  final api =domain+'ocr_maternitySelectedRow';
  final data = {
    "ocr_seq":num,
  };
  final dio = Dio();
  Response response;
  response = await dio.post(api,data: data);
  // if(response.statusCode == 200) {
  //   print("col 1.."+response.data[0].toString());
  //   print("col 10.."+response.data[10].toString());
  // }else{
  //   print(" fail..."+response.statusCode.toString());
  // }
  // print(response.data);
  return response.data;
}

// 분만사 전체 기록 불러오기
maternity_getocr() async {
  var maternity = <Ocr_maternity>[].obs;
  List<int> list_ocr_seq = [];
  List<String> list_sow_no = [];
  List<String> list_upload_day = [];
  List<dynamic> list_add = [];

  final api =domain+'getOcr_maternity';
  // final data = {
  // };
  final dio = Dio();
  Response response;
  // response = await dio.post(api,data: data);
  response = await dio.get(api);

  if(response.statusCode == 200) {
    List<dynamic> result = response.data;
    maternity.assignAll(result.map((data) => Ocr_maternity.fromJson(data)).toList());
    maternity.refresh();
    for(int i=0; i<maternity.length; i++){
      if(i == 0) {
        // print(" success..." + maternity[i].ocr_seq.toString() + " " + maternity[i].sow_no.toString());
        list_ocr_seq.add(maternity.length);
        list_sow_no.add(maternity.length.toString());
        list_upload_day.add(maternity.length.toString());
      }
      // print(" success!"+ maternity[i].ocr_seq.toString()+" " +maternity[i].sow_no.toString());
      list_ocr_seq.add(maternity[i].ocr_seq!.toInt());
      list_sow_no.add(maternity[i].sow_no!.toString());
      list_upload_day.add(maternity[i].input_date.toString()+"  "+maternity[i].input_time.toString().split(":")[0]+":"+maternity[i].input_time.toString().split(":")[1]);
    }
  }
  else{
    // print(" fail..."+response.statusCode.toString());
  }

  for( int i=0; i< list_ocr_seq.length; i++){
    list_add += [[list_ocr_seq[i],list_sow_no[i],list_upload_day[i]]];
  }

  // print(list_add);
  return list_add;
}

// 분만사 리스트삭제
maternity_deleterow(int num) async{
  final api =domain+'ocr_maternityDelete';
  final data = {
    "ocr_seq": num, //pk
  };
  final dio = Dio();
  Response response;
  // print("행 삭제 합니다");
  response = await dio.post(api,data: data);
  // print(response.data);
  if(response.statusCode == 200) {
    resultToast("Successfully deleted");
    //   print("행 삭제");
  //   print("*******************");
  }else{
    resultToast("fail to delete");
  //   print(" fail..."+response.statusCode.toString());
  }
  // print(response);
}

// 결과를 toast로 띄우는 함수
resultToast(String msg) {
  Fluttertoast.showToast(
      msg: msg,
      toastLength: Toast.LENGTH_LONG,
      gravity: ToastGravity.BOTTOM,
      timeInSecForIosWeb: 3,
      fontSize: 16.0
  );
}

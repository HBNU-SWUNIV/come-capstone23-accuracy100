import 'package:flutter/material.dart';
import 'package:dio/dio.dart';
import 'package:flutter/cupertino.dart';
import '../api/api.dart';

late int ocr_seq;
late String sow_no;
late String sow_birth;
late String sow_buy;
late String sow_expectdate;
late String sow_givebirth;
late String sow_totalbaby;
late String sow_feedbaby;
late String sow_babyweight;
late String sow_sevrerdate;
late String sow_sevrerqty;
late String sow_sevrerweight;
late String vaccine1;
late String vaccine2;
late String vaccine3;
late String vaccine4;
late String memo;
late String filename;

class MaternityPage extends StatefulWidget{
  static const routeName = '/OcrMaternityPage';
  // const MaternityPage({Key? key, this.title}) : super(key: key);
  final List listfromserver_mat;
  MaternityPage(this.listfromserver_mat);

  @override
  MaternityPageState createState() => MaternityPageState();
}

class MaternityPageState extends State<MaternityPage>{

  late String sowID1;
  late String sowID2;

  late String birth_year;
  late String birth_month;
  late String birth_day;

  late String adoption_year;
  late String adoption_month;
  late String adoption_day;

  late String expect_month;
  late String expect_day;

  late String teen_month;
  late String teen_day;

  late String givebirth_month;
  late String givebirth_day;

  late String totalbaby;

  late String feedbaby;

  late String weight;

  late String totalteen;
  late String teenweight;

  Widget showImage() {

    return Container(
        margin: EdgeInsets.only(left: 20,right: 20),
        color: Colors.white,
        width: MediaQuery
            .of(context)
            .size
            .width,
        height: MediaQuery
            .of(context)
            .size
            .width*1.414,
        child: Container(
            alignment: Alignment.topCenter,
            child: Image.network(domain+"api/ocrGetImage/ocrmatimages/"+widget.listfromserver_mat[0].split("/").last.toString())));
            // child: Image.network(domain+"api/ocrGetImage/OCR/test_img/maternity/test.jpg")));
  }

  final Controller1 = TextEditingController();
  final Controller2 = TextEditingController();
  final Controller3 = TextEditingController();
  final Controller4 = TextEditingController();
  final Controller5 = TextEditingController();
  final Controller6 = TextEditingController();
  final Controller7 = TextEditingController();
  final Controller8 = TextEditingController();
  final Controller9 = TextEditingController();
  final Controller10 = TextEditingController();
  final Controller11 = TextEditingController();
  final Controller12 = TextEditingController();
  final Controller13 = TextEditingController();
  final Controller14 = TextEditingController();
  final Controller15 = TextEditingController();
  final Controller16 = TextEditingController();

  //모돈번호
  final sowID1_Controller = TextEditingController();
  final sowID2_Controller = TextEditingController();

  //출생일
  final birth_year_Controller = TextEditingController();
  final birth_month_Controller = TextEditingController();
  final birth_day_Controller = TextEditingController();

  //구입일
  final adoption_year_Controller = TextEditingController();
  final adoption_month_Controller = TextEditingController();
  final adoption_day_Controller = TextEditingController();

  //분만예정일
  final expect_month_Controller = TextEditingController();
  final expect_day_Controller = TextEditingController();

  //이유일
  final teen_month_Controller = TextEditingController();
  final teen_day_Controller = TextEditingController();

  //분만일
  final givebirth_month_Controller = TextEditingController();
  final givebirth_day_Controller = TextEditingController();

  //총산자수
  final totalbaby_Controller = TextEditingController();
  final feedbaby_Controller = TextEditingController();
  //생시체중
  final weight_Controller = TextEditingController();

  //이유두수
  final totalteen_Controller = TextEditingController();

  //이유체중
  final teenweight_Controller = TextEditingController();

  final vaccine1_fir_Controller = TextEditingController();
  final vaccine1_sec_Controller = TextEditingController();
  final vaccine2_fir_Controller = TextEditingController();
  final vaccine2_sec_Controller = TextEditingController();
  final vaccine3_fir_Controller = TextEditingController();
  final vaccine3_sec_Controller = TextEditingController();
  final vaccine4_fir_Controller = TextEditingController();
  final vaccine4_sec_Controller = TextEditingController();

  final memo_Controller = TextEditingController();

  var flag = 0; // 서버에서 가져온 값을 한번만 표에 넣기 위함
  @override
  Widget build(BuildContext context) {
    if(widget.listfromserver_mat.isNotEmpty){
      if(flag==0) {
        flag++;
        // print(widget.listfromserver_mat);
        Controller1.text ="모돈번호";
        Controller2.text ="출생일";
        Controller3.text ="구입일";
        Controller4.text ="분만  예정일";
        Controller5.text ="분만일";
        Controller6.text ="총산  자수";
        Controller7.text ="포유개시두수";
        Controller8.text ="생시체중(kg)";
        Controller9.text ="이유일";
        Controller10.text ="이유  두수";
        Controller11.text ="이유체중(kg)";
        Controller12.text ="백신1";
        Controller13.text ="백신2";
        Controller14.text ="백신3";
        Controller15.text ="백신4";
        Controller16.text ="-";

        // sowID1_Controller.text = widget.listfromserver_mat[1][0].split('-')[0];
        // sowID2_Controller.text = widget.listfromserver_mat[1][0].split('-')[1];
        sowID1_Controller.text = widget.listfromserver_mat[1][0].toString()[0]+widget.listfromserver_mat[1][0].toString()[1]+widget.listfromserver_mat[1][0].toString()[2]+widget.listfromserver_mat[1][0].toString()[3];
        sowID2_Controller.text = widget.listfromserver_mat[1][0].toString()[4];

        birth_year_Controller.text = widget.listfromserver_mat[1][1].toString();
        birth_month_Controller.text = widget.listfromserver_mat[1][2].toString();
        birth_day_Controller.text = widget.listfromserver_mat[1][3].toString();

        adoption_year_Controller.text = widget.listfromserver_mat[1][4].toString();
        adoption_month_Controller.text = widget.listfromserver_mat[1][5].toString();
        adoption_day_Controller.text = widget.listfromserver_mat[1][6].toString();

        expect_month_Controller.text = widget.listfromserver_mat[1][7].toString();
        expect_day_Controller.text = widget.listfromserver_mat[1][8].toString();

        givebirth_month_Controller.text = widget.listfromserver_mat[1][9].toString();
        givebirth_day_Controller.text = widget.listfromserver_mat[1][10].toString();

        totalbaby_Controller.text = widget.listfromserver_mat[1][11].toString();
        feedbaby_Controller.text = widget.listfromserver_mat[1][12].toString();
        weight_Controller.text = widget.listfromserver_mat[1][13].toString();

        teen_month_Controller.text = widget.listfromserver_mat[1][14].toString();
        teen_day_Controller.text = widget.listfromserver_mat[1][15].toString();

        totalteen_Controller.text = widget.listfromserver_mat[1][16].toString();
        teenweight_Controller.text = widget.listfromserver_mat[1][17].toString();

        vaccine1_fir_Controller.text = widget.listfromserver_mat[1][18].toString();
        vaccine1_sec_Controller.text = widget.listfromserver_mat[1][19].toString();
        vaccine2_fir_Controller.text = widget.listfromserver_mat[1][20].toString();
        vaccine2_sec_Controller.text = widget.listfromserver_mat[1][21].toString();
        vaccine3_fir_Controller.text = widget.listfromserver_mat[1][22].toString();
        vaccine3_sec_Controller.text = widget.listfromserver_mat[1][23].toString();
        vaccine4_fir_Controller.text = widget.listfromserver_mat[1][24].toString();
        vaccine4_sec_Controller.text = widget.listfromserver_mat[1][25].toString();

        filename = widget.listfromserver_mat[0].toString();
      }
      return Scaffold(
          appBar: AppBar(
            title: Text("분만사"),
            backgroundColor: Colors.grey,
          ),
          body: Scrollbar(
              thumbVisibility: true, //always show scrollbar
              thickness: 10, //width of scrollbar
              radius: Radius.circular(20), //corner radius of scrollbar
              scrollbarOrientation: ScrollbarOrientation.right, //which side to show scrollbar
              child: GestureDetector( // 키보드 닫기 이벤트
                  onVerticalDragDown: (DragDownDetails details){ FocusScope.of(context).unfocus();},
                  onTap: () { FocusManager.instance.primaryFocus?.unfocus(); },
                  child: SingleChildScrollView(
                      child: Column(children:<Widget>[
                        Container(
                          margin: const EdgeInsets.only(left: 20,right: 20,top: 20),
                          child: Table(
                            textBaseline: TextBaseline.alphabetic,
                            border: const TableBorder(
                              left:BorderSide( color: Colors.black, style: BorderStyle.solid, width: 3,),
                              right:BorderSide( color: Colors.black, style: BorderStyle.solid, width: 3,),
                              top: BorderSide( color: Colors.black, style: BorderStyle.solid, width: 3,),
                              verticalInside: BorderSide( color: Colors.black, style: BorderStyle.solid, width: 1,),
                              // borderRadius: BorderRadius.only(bottomLeft:Radius.circular(50),topLeft:Radius.circular(50)),
                            ),
                            columnWidths: const {0: FractionColumnWidth(.0),1: FractionColumnWidth(.4), 2: FractionColumnWidth(.4), 3: FractionColumnWidth(.1),4: FractionColumnWidth(.1)},
                            children: [
                              TableRow(
                                children: [
                                  const TableCell(
                                    child: SizedBox(height: 30,),
                                  ),
                                  Column(children:[
                                    TextField(controller: Controller1,
                                      enabled: false,
                                      decoration: const InputDecoration(hintText: " ",border: InputBorder.none,),style: TextStyle(fontSize: 20),keyboardType: TextInputType.number,textAlign: TextAlign.center,),
                                    // Text('모돈번호',style: TextStyle(fontSize: 20),textAlign: TextAlign.center,)
                                  ]),
                                  Column(children:[
                                    TextField(controller: sowID1_Controller,
                                      decoration: const InputDecoration(hintText: " ",border: InputBorder.none,),style: TextStyle(fontSize: 20,fontWeight: FontWeight.w500),keyboardType: TextInputType.number,textAlign: TextAlign.center,),
                                  ]),
                                  Column(children:[
                                    TextField(controller: Controller16,
                                      enabled: false,
                                      decoration: const InputDecoration(hintText: " ",border: InputBorder.none,),style: TextStyle(fontSize: 20,fontWeight: FontWeight.w500),keyboardType: TextInputType.number,textAlign: TextAlign.center,),
                                    // Text('모돈번호',style: TextStyle(fontSize: 20),textAlign: TextAlign.center,)
                                  ]),
                                  Column(children:[
                                    TextField(controller: sowID2_Controller,
                                      decoration: const InputDecoration(hintText: " ",border: InputBorder.none,),style: TextStyle(fontSize: 20,fontWeight: FontWeight.w500),keyboardType: TextInputType.number,textAlign: TextAlign.center,),
                                  ]),

                                ],),
                            ],
                          ),
                        ),
                        Container(
                          margin: EdgeInsets.only(left: 20,right: 20),
                          child: Table(
                            border: const TableBorder(
                              left:BorderSide( color: Colors.black, style: BorderStyle.solid, width: 3,),
                              right:BorderSide( color: Colors.black, style: BorderStyle.solid, width: 3,),
                              top: BorderSide( color: Colors.black, style: BorderStyle.solid, width: 1,),
                              verticalInside: BorderSide( color: Colors.black, style: BorderStyle.solid, width: 1,),
                            ),
                            // borderRadius: BorderRadius.all(Radius.circular(10)),
                            columnWidths: {0:FractionColumnWidth(0),1: FractionColumnWidth(.15), 2: FractionColumnWidth(.25), 3: FractionColumnWidth(.3),4: FractionColumnWidth(.3)},
                            children: [
                              TableRow( children: [
                                TableCell(
                                  child: SizedBox(height: 30,),
                                ),
                                Column(
                                    children:[
                                      TextField(controller: Controller2,
                                        enabled: false,
                                        decoration: const InputDecoration(hintText: " ",border: InputBorder.none,),style: TextStyle(fontSize: 15),keyboardType: TextInputType.number,textAlign: TextAlign.center,),
                                    ]),
                                Column(children:[
                                  TextField(controller: birth_year_Controller,
                                    decoration: const InputDecoration(hintText: " ",border: InputBorder.none,),style: TextStyle(fontSize: 20,fontWeight: FontWeight.w500),keyboardType: TextInputType.number,textAlign: TextAlign.center,),
                                ]),
                                Column(children:[
                                  TextField(controller: birth_month_Controller,
                                    decoration: const InputDecoration(hintText: " ",border: InputBorder.none,),style: TextStyle(fontSize: 20,fontWeight: FontWeight.w500),keyboardType: TextInputType.number,textAlign: TextAlign.center,),
                                ]),
                                Column(children:[
                                  TextField(controller: birth_day_Controller,
                                    decoration: const InputDecoration(hintText: " ",border: InputBorder.none,),style: TextStyle(fontSize: 20,fontWeight: FontWeight.w500),keyboardType: TextInputType.number,textAlign: TextAlign.center,),
                                ]),
                              ],),
                            ],
                          ),
                        ),
                        Container(
                          margin: EdgeInsets.only(left: 20,right: 20),
                          child: Table(
                            border: const TableBorder(
                              left:BorderSide( color: Colors.black, style: BorderStyle.solid, width: 3,),
                              right:BorderSide( color: Colors.black, style: BorderStyle.solid, width: 3,),
                              top: BorderSide( color: Colors.black, style: BorderStyle.solid, width: 1,),
                              verticalInside: BorderSide( color: Colors.black, style: BorderStyle.solid, width: 1,),
                            ),
                            columnWidths: {0:FractionColumnWidth(0),1: FractionColumnWidth(.15), 2: FractionColumnWidth(.25), 3: FractionColumnWidth(.3),4: FractionColumnWidth(.3)},                  children: [
                            TableRow( children: [
                              TableCell(
                                child: SizedBox(height: 30,),
                              ),
                              Column(children:[
                                TextField(controller: Controller3,
                                  enabled: false,
                                  decoration: const InputDecoration(hintText: " ",border: InputBorder.none,),style: TextStyle(fontSize: 15),keyboardType: TextInputType.number,textAlign: TextAlign.center,),

                              ]),
                              Column(children:[
                                TextField(controller: adoption_year_Controller,
                                  decoration: const InputDecoration(hintText: " ",border: InputBorder.none,),style: TextStyle(fontSize: 20,fontWeight: FontWeight.w500),keyboardType: TextInputType.number,textAlign: TextAlign.center,),
                              ]),
                              Column(children:[
                                TextField(controller: adoption_month_Controller,
                                  decoration: const InputDecoration(hintText: " ",border: InputBorder.none,),style: TextStyle(fontSize: 20,fontWeight: FontWeight.w500),keyboardType: TextInputType.number,textAlign: TextAlign.center,),
                              ]),
                              Column(children:[
                                TextField(controller: adoption_day_Controller,
                                  decoration: const InputDecoration(hintText: " ",border: InputBorder.none,),style: TextStyle(fontSize: 20,fontWeight: FontWeight.w500),keyboardType: TextInputType.number,textAlign: TextAlign.center,),
                              ]),
                            ],),
                          ],
                          ),
                        ),
                        Container(
                          margin: EdgeInsets.only(left: 20,right: 20),
                          child: Table(
                            border: const TableBorder(
                              left:BorderSide( color: Colors.black, style: BorderStyle.solid, width: 3,),
                              right:BorderSide( color: Colors.black, style: BorderStyle.solid, width: 3,),
                              top: BorderSide( color: Colors.black, style: BorderStyle.solid, width: 1,),
                              verticalInside: BorderSide( color: Colors.black, style: BorderStyle.solid, width: 1,),
                            ),
                            columnWidths: {0:FractionColumnWidth(.0),1: FractionColumnWidth(.15), 2: FractionColumnWidth(.43), 3: FractionColumnWidth(.42)},
                            children:[TableRow( children: [
                              TableCell(
                                child: SizedBox(height: 30,),
                              ),
                              Column(children:[
                                TextField(controller: Controller4,
                                  enabled: false,
                                  maxLines: null,
                                  decoration: const InputDecoration(hintText: " ",border: InputBorder.none,),style: TextStyle(fontSize: 15),keyboardType: TextInputType.number,textAlign: TextAlign.center,),

                              ]),
                              Column(children:[
                                TextField(controller: expect_month_Controller,

                                  decoration: const InputDecoration(hintText: " ",border: InputBorder.none,),style: TextStyle(fontSize: 20,fontWeight: FontWeight.w500),keyboardType: TextInputType.number,textAlign: TextAlign.center,)
                              ]),
                              Column(children:[
                                TextField(controller: expect_day_Controller,
                                  decoration: const InputDecoration(hintText: " ",border: InputBorder.none,),style: TextStyle(fontSize: 20,fontWeight: FontWeight.w500),keyboardType: TextInputType.number,textAlign: TextAlign.center,),
                              ])]),
                            ],
                          ),
                        ),
                        Container(
                          margin: EdgeInsets.only(left: 20,right: 20),
                          child: Table(
                            border: const TableBorder(
                              left:BorderSide( color: Colors.black, style: BorderStyle.solid, width: 3,),
                              right:BorderSide( color: Colors.black, style: BorderStyle.solid, width: 3,),
                              top: BorderSide( color: Colors.black, style: BorderStyle.solid, width: 1,),
                              verticalInside: BorderSide( color: Colors.black, style: BorderStyle.solid, width: 1,),
                            ),
                            columnWidths: {0:FractionColumnWidth(.0),1: FractionColumnWidth(.15), 2: FractionColumnWidth(.43), 3: FractionColumnWidth(.42)},
                            children: [
                              TableRow( children: [
                                TableCell(
                                  child: SizedBox(height: 30,),
                                ),
                                Column(children:[
                                  TextField(controller: Controller5,
                                    enabled: false,
                                    maxLines: null,
                                    decoration: const InputDecoration(hintText: " ",border: InputBorder.none,),style: TextStyle(fontSize: 15),keyboardType: TextInputType.number,textAlign: TextAlign.center,),

                                ]),
                                Column(children:[
                                  TextField(controller: givebirth_month_Controller,
                                    decoration: const InputDecoration(hintText: " ",border: InputBorder.none,),style: TextStyle(fontSize: 20,fontWeight: FontWeight.w500),keyboardType: TextInputType.number,textAlign: TextAlign.center,),
                                ]),
                                Column(children:[
                                  TextField(controller: givebirth_day_Controller,
                                    decoration: const InputDecoration(hintText: " ",border: InputBorder.none,),style: TextStyle(fontSize: 20,fontWeight: FontWeight.w500),keyboardType: TextInputType.number,textAlign: TextAlign.center,),
                                ]),
                              ],),
                            ],
                          ),
                        ),
                        Container(
                          margin: EdgeInsets.only(left: 20,right: 20),
                          child: Table(
                            border: const TableBorder(
                              left:BorderSide( color: Colors.black, style: BorderStyle.solid, width: 3,),
                              right:BorderSide( color: Colors.black, style: BorderStyle.solid, width: 3,),
                              top: BorderSide( color: Colors.black, style: BorderStyle.solid, width: 1,),
                              verticalInside: BorderSide( color: Colors.black, style: BorderStyle.solid, width: 1,),
                            ),
                            columnWidths: {0:FractionColumnWidth(.0), 1: FractionColumnWidth(.15), 2: FractionColumnWidth(.175), 3: FractionColumnWidth(.175),4: FractionColumnWidth(.15), 5: FractionColumnWidth(.175), 6: FractionColumnWidth(.175)},
                            children: [
                              TableRow( children: [
                                TableCell(
                                  child: SizedBox(height: 30,),
                                ),
                                Column(children:[
                                  TextField(controller: Controller6,
                                    enabled: false,
                                    maxLines: null,
                                    decoration: const InputDecoration(hintText: " ",border: InputBorder.none,),style: TextStyle(fontSize: 15),keyboardType: TextInputType.number,textAlign: TextAlign.center,),

                                ]),
                                Column(children:[
                                  TextField(controller: totalbaby_Controller,
                                    decoration: const InputDecoration(hintText: " ",border: InputBorder.none,),style: TextStyle(fontSize: 20,fontWeight: FontWeight.w500),keyboardType: TextInputType.number,textAlign: TextAlign.center,),
                                ]),
                                Column(children:[
                                  TextField(controller: Controller7,
                                    enabled: false,
                                    maxLines: null,
                                    decoration: const InputDecoration(hintText: " ",border: InputBorder.none,),style: TextStyle(fontSize: 15),keyboardType: TextInputType.number,textAlign: TextAlign.center,),

                                ]),
                                Column(children:[
                                  TextField(controller: feedbaby_Controller,
                                    decoration: const InputDecoration(hintText: " ",border: InputBorder.none,),style: TextStyle(fontSize: 20,fontWeight: FontWeight.w500),keyboardType: TextInputType.number,textAlign: TextAlign.center,),
                                ]),
                                Column(children:[
                                  TextField(controller: Controller8,
                                    enabled: false,
                                    maxLines: null,
                                    decoration: const InputDecoration(hintText: " ",border: InputBorder.none,),style: TextStyle(fontSize: 15),keyboardType: TextInputType.number,textAlign: TextAlign.center,),

                                ]),
                                Column(children:[
                                  TextField(controller: weight_Controller,
                                    decoration: const InputDecoration(hintText: " ",border: InputBorder.none,),style: TextStyle(fontSize: 20,fontWeight: FontWeight.w500),keyboardType: TextInputType.number,textAlign: TextAlign.center,),
                                ]),
                              ],),
                            ],
                          ),
                        ),
                        Container(
                          margin: EdgeInsets.only(left: 20,right: 20),
                          child: Table(
                            border: const TableBorder(
                              left:BorderSide( color: Colors.black, style: BorderStyle.solid, width: 3,),
                              right:BorderSide( color: Colors.black, style: BorderStyle.solid, width: 3,),
                              top: BorderSide( color: Colors.black, style: BorderStyle.solid, width: 1,),
                              verticalInside: BorderSide( color: Colors.black, style: BorderStyle.solid, width: 1,),
                            ),                            columnWidths: {0:FractionColumnWidth(.0),1: FractionColumnWidth(.15), 2: FractionColumnWidth(.43), 3: FractionColumnWidth(.42)},
                            children: [

                              TableRow( children: [
                                TableCell(
                                  child: SizedBox(height: 30,),
                                ),
                                Column(children:[
                                  TextField(controller: Controller9,
                                    enabled: false,
                                    maxLines: null,
                                    decoration: const InputDecoration(hintText: " ",border: InputBorder.none,),style: TextStyle(fontSize: 15),keyboardType: TextInputType.number,textAlign: TextAlign.center,),

                                ]),
                                Column(children:[
                                  TextField(controller:  teen_month_Controller,
                                    decoration: const InputDecoration(hintText: " ",border: InputBorder.none,),style: TextStyle(fontSize: 20,fontWeight: FontWeight.w500),keyboardType: TextInputType.number,textAlign: TextAlign.center,),
                                ]),
                                Column(children:[
                                  TextField(controller: teen_day_Controller,
                                    decoration: const InputDecoration(hintText: " ",border: InputBorder.none,),style: TextStyle(fontSize: 20,fontWeight: FontWeight.w500),keyboardType: TextInputType.number,textAlign: TextAlign.center,),
                                ]),
                              ],),
                            ],
                          ),
                        ),
                        Container(
                          margin: EdgeInsets.only(left: 20,right: 20),
                          child: Table(
                            border: const TableBorder(
                              left:BorderSide( color: Colors.black, style: BorderStyle.solid, width: 3,),
                              right:BorderSide( color: Colors.black, style: BorderStyle.solid, width: 3,),
                              top: BorderSide( color: Colors.black, style: BorderStyle.solid, width: 1,),
                              verticalInside: BorderSide( color: Colors.black, style: BorderStyle.solid, width: 1,),
                            ),                            columnWidths: {0: FractionColumnWidth(.0),1: FractionColumnWidth(.15), 2: FractionColumnWidth(.35), 3: FractionColumnWidth(.15),4: FractionColumnWidth(.35)},
                            children: [
                              TableRow( children: [
                                TableCell(
                                  child: SizedBox(height: 30,),
                                ),
                                Column(children:[
                                  TextField(controller: Controller10,
                                    enabled: false,
                                    maxLines: null,
                                    decoration: const InputDecoration(hintText: " ",border: InputBorder.none,),style: TextStyle(fontSize: 15),keyboardType: TextInputType.number,textAlign: TextAlign.center,),

                                ]),
                                Column(children:[
                                  TextField(controller: totalteen_Controller,
                                    decoration: const InputDecoration(hintText: " ",border: InputBorder.none,),style: TextStyle(fontSize: 20,fontWeight: FontWeight.w500),keyboardType: TextInputType.number,textAlign: TextAlign.center,),
                                ]),
                                Column(children:[
                                  TextField(controller: Controller11,
                                    enabled: false,
                                    maxLines: null,
                                    decoration: const InputDecoration(hintText: " ",border: InputBorder.none,),style: TextStyle(fontSize: 15),keyboardType: TextInputType.number,textAlign: TextAlign.center,),

                                ]),
                                Column(children:[
                                  TextField(controller: teenweight_Controller,
                                    decoration: const InputDecoration(hintText: " ",border: InputBorder.none,),style: TextStyle(fontSize: 20,fontWeight: FontWeight.w500),keyboardType: TextInputType.number,textAlign: TextAlign.center,),
                                ]),
                              ],),
                            ],
                          ),
                        ),
                        Container(
                          margin: EdgeInsets.only(left: 20,right: 20),
                          child: Table(
                            border: const TableBorder(
                              left:BorderSide( color: Colors.black, style: BorderStyle.solid, width: 3,),
                              right:BorderSide( color: Colors.black, style: BorderStyle.solid, width: 3,),
                              top: BorderSide( color: Colors.black, style: BorderStyle.solid, width: 1,),
                              verticalInside: BorderSide( color: Colors.black, style: BorderStyle.solid, width: 1,),
                            ),                            columnWidths: {0:FractionColumnWidth(.0), 1: FractionColumnWidth(.15), 2: FractionColumnWidth(.175), 3: FractionColumnWidth(.175),4: FractionColumnWidth(.15), 5: FractionColumnWidth(.175), 6: FractionColumnWidth(.175)},
                            children: [
                              TableRow( children: [
                                TableCell(
                                  child: SizedBox(height: 30,),
                                ),
                                Column(children:[
                                  TextField(controller: Controller12,
                                    enabled: false,
                                    maxLines: null,
                                    decoration: const InputDecoration(hintText: " ",border: InputBorder.none,),style: TextStyle(fontSize: 15),keyboardType: TextInputType.number,textAlign: TextAlign.center,),

                                ]),
                                Column(children:[
                                  TextField(controller: vaccine1_fir_Controller,
                                    decoration: const InputDecoration(hintText: " ",border: InputBorder.none,),style: TextStyle(fontSize: 20,fontWeight: FontWeight.w500),keyboardType: TextInputType.number,textAlign: TextAlign.center,),
                                ]),
                                Column(children:[
                                  TextField(controller: vaccine1_sec_Controller,
                                    decoration: const InputDecoration(hintText: " ",border: InputBorder.none,),style: TextStyle(fontSize: 20,fontWeight: FontWeight.w500),keyboardType: TextInputType.number,textAlign: TextAlign.center,),
                                ]),
                                Column(children:[
                                  TextField(controller: Controller13,
                                    enabled: false,
                                    maxLines: null,
                                    decoration: const InputDecoration(hintText: " ",border: InputBorder.none,),style: TextStyle(fontSize: 15),keyboardType: TextInputType.number,textAlign: TextAlign.center,),

                                ]),
                                Column(children:[
                                  TextField(controller: vaccine2_fir_Controller,
                                    decoration: const InputDecoration(hintText: " ",border: InputBorder.none,),style: TextStyle(fontSize: 20,fontWeight: FontWeight.w500),keyboardType: TextInputType.number,textAlign: TextAlign.center,),
                                ]),
                                Column(children:[
                                  TextField(controller: vaccine2_sec_Controller,
                                    decoration: const InputDecoration(hintText: " ",border: InputBorder.none,),style: TextStyle(fontSize: 20,fontWeight: FontWeight.w500),keyboardType: TextInputType.number,textAlign: TextAlign.center,),
                                ]),
                              ],),
                            ],
                          ),
                        ),
                        Container(
                          margin: EdgeInsets.only(left: 20,right: 20),
                          child: Table(
                            border: const TableBorder(
                              left:BorderSide( color: Colors.black, style: BorderStyle.solid, width: 3,),
                              right:BorderSide( color: Colors.black, style: BorderStyle.solid, width: 3,),
                              top: BorderSide( color: Colors.black, style: BorderStyle.solid, width: 1,),
                              bottom: BorderSide( color: Colors.black, style: BorderStyle.solid, width: 3,),
                              verticalInside: BorderSide( color: Colors.black, style: BorderStyle.solid, width: 1,),
                            ),                           columnWidths: {0: FractionColumnWidth(.0), 1: FractionColumnWidth(.15), 2: FractionColumnWidth(.175), 3: FractionColumnWidth(.175), 4: FractionColumnWidth(.15), 5: FractionColumnWidth(.175), 6: FractionColumnWidth(.175)},
                            children: [
                              TableRow( children: [
                                TableCell(
                                  child: SizedBox(height: 30,),
                                ),
                                Column(children:[
                                  TextField(controller: Controller14,
                                    enabled: false,
                                    maxLines: null,
                                    decoration: const InputDecoration(hintText: " ",border: InputBorder.none,),style: TextStyle(fontSize: 15),keyboardType: TextInputType.number,textAlign: TextAlign.center,),

                                ]),
                                Column(children:[
                                  TextField(controller: vaccine3_fir_Controller,
                                    decoration: const InputDecoration(hintText: " ",border: InputBorder.none,),style: TextStyle(fontSize: 20,fontWeight: FontWeight.w500),keyboardType: TextInputType.number,textAlign: TextAlign.center,),
                                ]),
                                Column(children:[
                                  TextField(controller: vaccine3_sec_Controller,
                                    decoration: const InputDecoration(hintText: " ",border: InputBorder.none,),style: TextStyle(fontSize: 20,fontWeight: FontWeight.w500),keyboardType: TextInputType.number,textAlign: TextAlign.center,),
                                ]),
                                Column(children:[
                                  TextField(controller: Controller15,
                                    enabled: false,
                                    maxLines: null,
                                    decoration: const InputDecoration(hintText: " ",border: InputBorder.none,),style: TextStyle(fontSize: 15),keyboardType: TextInputType.number,textAlign: TextAlign.center,),

                                ]),
                                Column(children:[
                                  TextField(controller: vaccine4_fir_Controller,
                                    decoration: const InputDecoration(hintText: " ",border: InputBorder.none,),style: TextStyle(fontSize: 20,fontWeight: FontWeight.w500),keyboardType: TextInputType.number,textAlign: TextAlign.center,),
                                ]),
                                Column(children:[
                                  TextField(controller: vaccine4_sec_Controller,
                                    decoration: const InputDecoration(hintText: " ",border: InputBorder.none,),style: TextStyle(fontSize: 20,fontWeight: FontWeight.w500),keyboardType: TextInputType.number,textAlign: TextAlign.center,),
                                ]),
                              ],),
                            ],
                          ),
                        ),
                        SizedBox(height: 10.0), // 위에 여백
                        showImage(),
                        SizedBox(
                          height: 15.0,
                        ),
                        Row(
                            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                            children: <Widget>[
                              FloatingActionButton(
                                heroTag: 'send_button',
                                tooltip: 'send changed ocr',
                                onPressed: () async{
                                },
                                child: Icon(Icons.arrow_circle_right_sharp),
                              ),
                            ]
                        )
                      ])
                  )
              )
          )
      );
    }
    else{
      return Container(
          padding: const EdgeInsets.fromLTRB(0, 0, 0, 0),
          alignment: Alignment.center,
          decoration: const BoxDecoration(
            color: Colors.black,
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              CircularProgressIndicator( // 로딩화면 애니메이션
                value: null,
                strokeWidth: 7.0,
                color: Colors.white,
              ),
              SizedBox(height: 20,),
              Text(
                "Loading...",
                style: TextStyle(
                    fontSize: 20,
                    color: Colors.white,
                    decoration: TextDecoration.none
                ),
              ),
            ],
          )
      );
    }

  }

}
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import '../api/api.dart';
import '../modify/maternity_modify_page.dart';

class MaternityListPage extends StatefulWidget {
  MaternityListPage({Key? key, this.title}) : super(key: key);
  final String? title;


  @override
  MaternityListPageState createState() => MaternityListPageState();
}

class MaternityListPageState extends State<MaternityListPage> {
  int num  = 0;
  late List listfromserver_list_mat;
  final List<int> ocr_seq = <int>[];
  final List<String> sow_no = <String>[];
  final List<String> upload_day = <String>[];

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    prepareList();
  }
  prepareList() async{
    // listfromserver_list_mat = await maternity_getocr();
    listfromserver_list_mat = [[20],
      [1,'1259-1','2023-05-01 09:01'],[2,'7186-2','2023-05-01 10:23'],[3,'2367-1','2023-04-28 20:18'],[4,'3179-6','2023-04-28 10:59'],
      [5,'7591-2','2023-04-25 15:09'],[6,'1090-9','2023-04-27 14:27'],[7,'1922-8','2023-04-10 10:11'],[8,'5879-6','2023-04-03 16:47'],
      [9,'1026-3','2023-03-27 19:21'],[10,'1167-7','2023-03-26 17:50'],[11,'1697-3','2023-03-25 18:19'],[12,'6399-7','2023-03-21 17:55'],
      [5,'7591-2','2023-04-25 15:09'],[6,'1090-9','2023-04-27 14:27'],[7,'1922-8','2023-04-10 10:11'],[8,'5879-6','2023-04-03 16:47'],
    [9,'1026-3','2023-03-27 19:21'],[10,'1167-7','2023-03-26 17:50'],[11,'1697-3','2023-03-25 18:19'],[12,'6399-7','2023-3-21 17:55']

    ];
    setState(() {
      // print(listfromserver_list_mat);
      num = listfromserver_list_mat[0][0];
      sow_no.add("모돈번호");
      upload_day.add("업로드 시간");
      for (int i = 1; i < num + 1; i ++) {
        ocr_seq.add(listfromserver_list_mat[i][0]);
        sow_no.add(listfromserver_list_mat[i][1]);
        upload_day.add(listfromserver_list_mat[i][2]);
      }
    });
  }
  @override
  Widget build(BuildContext context) {
    WidgetsFlutterBinding.ensureInitialized();
    SystemChrome.setSystemUIOverlayStyle( SystemUiOverlayStyle( statusBarColor: Colors.black));

    return
      Scaffold(
            // appBar: AppBar(
            //   automaticallyImplyLeading: true,
            //   backgroundColor: Colors.white10,
            // ),
            body: Scrollbar(
        thumbVisibility: true, //always show scrollbar
        thickness: 10, //width of scrollbar
        radius: Radius.circular(20), //corner radius of scrollbar
    scrollbarOrientation: ScrollbarOrientation.right, //which side to show scrollbar
    child: Column(
                children: [
                  Expanded(
                    child: ListView(
                      children: [
                        _createDataTable(),
                      ],
                    ),
                  )
                ]
            )
        )
    );
  }
  Widget _createDataTable() {
    return Container(
      child: Column(
        children: [
          SizedBox(height: 20,),
          Text('분만사 List',textAlign: TextAlign.start,style: TextStyle(
              fontWeight: FontWeight.bold, color: Colors.black54),),
          SizedBox(height: 10,),
          FittedBox(
              fit: BoxFit.fitWidth,
              child: DataTable(
                border: TableBorder.all(
                  width: 1,
                  borderRadius: BorderRadius.circular(10),
                ),
                columns: _createColumns(),
                // columnSpacing: 30,
                rows: _createRows(),
                headingTextStyle: TextStyle(
                  fontWeight: FontWeight.bold,
                  color: Colors.white,

                ),
                headingRowColor: MaterialStateProperty.resolveWith(
                        (states) => Colors.grey
                ),
              )
          )
        ],
      ),
    );
  }

  List<DataColumn> _createColumns() {
    return [
      DataColumn(label: Expanded(child: Text( '모돈번호', textAlign: TextAlign.center,))),
      DataColumn(label: Expanded(child: Text( '업로드 시간', textAlign: TextAlign.center,))),
      DataColumn(label: Expanded(child: Text( 'Option', textAlign: TextAlign.center,))),
    ];
  }


  List<DataRow> _createRows() {
    List<DataRow> list = <DataRow>[];
    for (int i = 0; i < ocr_seq.length; i++) {
      list.add(
        DataRow(cells: [
          DataCell(
              Container(
                // width: 70,
                child: Row(
                  children: [
                    OutlinedButton(
                      onPressed: () {
                      },
                      child: Text(sow_no[i+1]),
                      style: OutlinedButton.styleFrom(
                          padding: EdgeInsets.symmetric(horizontal: 16),
                          shape: const RoundedRectangleBorder(
                              borderRadius:
                              BorderRadius.all(Radius.circular(15))
                          )
                      ),
                    ),
                  ],
                ),
              )
          ),
          DataCell(
              Container(
                // width: 70,
                child: Row(
                  children: [
                    OutlinedButton(
                      onPressed: () {
                      },
                      child: Text(upload_day[i+1]),
                      style: OutlinedButton.styleFrom(
                          padding: EdgeInsets.symmetric(horizontal: 16),
                          shape: const RoundedRectangleBorder(
                              borderRadius:
                              BorderRadius.all(Radius.circular(15))
                          )
                      ),
                    ),
                  ],
                ),
              )
          ),
          DataCell(
              Container(
                child: Row(
                  children: [
                    InkWell(
                      onTap: () {
                        Navigator.push(context, MaterialPageRoute(builder: (context) => MaternityModifyPage(ocr_seq[i])));
                      },
                      child: Ink.image(
                        image: AssetImage('assets/wrench.png'),
                        // fit: BoxFit.cover,
                        width: 15,
                        height: 15,
                      ),
                    ),
                    SizedBox(
                      width: 10,
                    ),
                    InkWell(
                      onTap: () {
                        _showdialogDelete(context,i,sow_no[i+1]);
                      },
                      child: Ink.image(
                        image: AssetImage('assets/trash-bin.png'),
                        // fit: BoxFit.cover,
                        width: 20,
                        height: 20,
                      ),
                    ),
                  ],
                ),
              )
          ),
        ]),
      );
    }
    return list;
  }
  Future<dynamic> _showdialogDelete(BuildContext context,int index,String name) async{
    return showDialog(
      context: context,
      builder: (BuildContext context) => AlertDialog(
        title: Text(name+' 삭제'),
        content: Text('선택한 모돈을 삭제하시겠습니까?'),

        actions: [
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              ElevatedButton(
                  onPressed: () async => {
                    Navigator.pop(context, false),
                    await pregnant_deleterow(ocr_seq[index]),//서버로 사용자가 삭제하길 원한 행의 index값 보내기
                    Navigator.push(context, MaterialPageRoute(builder: (context) =>
                        MaternityListPage()))
                  },
                  style: ElevatedButton.styleFrom(
                    foregroundColor: Colors.white,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(15.0),
                    ),
                  ),
                  child: Text('삭제')),
              SizedBox(width: 10,),
              ElevatedButton(
                  onPressed: () => {
                    Navigator.pop(context, false),
                  },
                  style: ElevatedButton.styleFrom(
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(15.0),
                    ),
                    foregroundColor: Colors.black54,
                    primary: Colors.white,
                  ),
                  child: Text('취소')
              ),
            ],
          )
        ],
      ),
    );
  }

}
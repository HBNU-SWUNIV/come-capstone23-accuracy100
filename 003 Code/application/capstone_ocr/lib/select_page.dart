import 'package:flutter/material.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/services.dart';

import 'camera/camera_overlay_maternity.dart';
import 'camera/camera_overlay_pregnant.dart';
import 'graph/graph_page.dart';
import 'graph/graph_target_page.dart';
import 'list/maternity_list_page.dart';
import 'list/pregnant_list_page.dart';


final imageList = [
  Image.asset('assets/welcome_gfarm.png', fit: BoxFit.scaleDown),
  Image.asset('assets/home_mobile.jpeg', fit: BoxFit.scaleDown),
  Image.asset('assets/home_desktop.jpeg', fit: BoxFit.scaleDown),
];

class SelectPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Test Application',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: _SelectPage(),
    );
  }
}

class _SelectPage extends StatefulWidget {
  @override
  _SelectPageState createState() => _SelectPageState();
}

class _SelectPageState extends State<_SelectPage> {
  int _index = 0;
  List<StatelessWidget> _pageList = [
    HomePage(),
    ServicePage(),
    ProfilePage(),
  ];
  FocusNode focusNode = FocusNode();
  @override
  Widget build(BuildContext context) {

    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white,
        centerTitle: true,
        title: Text(
          'OCR Application',
          style: TextStyle(color: Colors.black),
        ),
        // actions: <Widget>[
        // IconButton(
        //   icon: Icon(
        //     Icons.add,
        //     color: Colors.black,
        //   ),
        //   onPressed: () {},
        // ),
        // ],
      ),
      body: _pageList[_index],
      bottomNavigationBar: BottomNavigationBar(
        items: [
          BottomNavigationBarItem(
            icon: Icon(Icons.home),
            label: 'Home',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.assignment),
            label: 'Service',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.account_circle),
            label: 'Profiles',
          ),
        ],
        onTap: (index) {
          setState(() {
            _index = index;
          });
        },
        currentIndex: _index,
        selectedItemColor: Colors.black,
        unselectedItemColor: Colors.grey,
      ),
    );

  }
}

class HomePage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {

    return ListView(
      children: <Widget>[
        _buildTop(context),
        _buildMiddle(),
        _buildBottom(),
      ],
    );
  }

  Widget _buildTop(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(top: 20, bottom: 20),
      child: Column(
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              GestureDetector(
                child: Column(
                  children: <Widget>[
                    Icon(
                      Icons.camera_alt,
                      size: 40,
                    ),
                    Text('임신사 OCR'),
                  ],
                ),
                onTap: () {
                  Navigator.push(context, MaterialPageRoute(builder: (context) => CameraOverlayPregnant())); // PregnantListPage로 넘어가기
                },
              ),
              GestureDetector(
                child: Column(
                  children: <Widget>[
                    Icon(
                      Icons.camera_alt,
                      size: 40,
                    ),
                    Text('분만사 OCR'),
                  ],
                ),
                onTap: () {
                  Navigator.push(context, MaterialPageRoute(builder: (context) => CameraOverlayMaternity())); // PregnantListPage로 넘어가기
                },
              ),
              GestureDetector(
                child: Column(
                  children: <Widget>[
                    Icon(
                      Icons.list_alt,
                      size: 40,
                    ),
                    Text('임신사 리스트'),
                  ],
                ),
                onTap: () {
                  Navigator.push(context, MaterialPageRoute(builder: (context) => PregnantListPage())); // PregnantListPage로 넘어가기
                },
              ),
              GestureDetector(
                child: Column(
                  children: <Widget>[
                    Icon(
                      Icons.list_alt,
                      size: 40,
                    ),
                    Text('분만사 리스트'),
                  ],
                ),
                onTap: () {
                  Navigator.push(context, MaterialPageRoute(builder: (context) => MaternityListPage())); // PregnantListPage로 넘어가기
                },
              ),
            ],
          ),
          SizedBox(
            height: 20,
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              GestureDetector(
                child: Column(
                  children: <Widget>[
                    Icon(
                      Icons.bar_chart_outlined,
                      size: 40,
                    ),
                    Text('통계'),
                  ],
                ),
                onTap: () {
                  Navigator.push(context, MaterialPageRoute(builder: (context) => GraphPage())); // PregnantListPage로 넘어가기
                },
              ),
              GestureDetector(
                child: Column(
                  children: <Widget>[
                    Icon(
                      Icons.mode_edit_outline_outlined,
                      size: 40,
                    ),
                    Text('목표값 수정'),
                  ],
                ),
                onTap: () {
                  Navigator.push(context, MaterialPageRoute(builder: (context) => TargetValueView())); // PregnantListPage로 넘어가기
                },
              ),
              Opacity(
                opacity: 0.0,
                child: Column(
                  children: <Widget>[
                    Icon(
                      Icons.local_taxi,
                      size: 40,
                    ),
                    Text('자동차7'),
                  ],
                ),
              ),
              Opacity(
                opacity: 0.0,
                child: Column(
                  children: <Widget>[
                    Icon(
                      Icons.local_taxi,
                      size: 40,
                    ),
                    Text('자동차8'),
                  ],
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildMiddle() {
    return CarouselSlider(
      options: CarouselOptions(height: 200.0, autoPlay: true),
      items: imageList.map((image) {
        return Builder(
          builder: (BuildContext context) {
            return Container(
              width: MediaQuery.of(context).size.width,
              margin: EdgeInsets.symmetric(horizontal: 5.0),
              child: ClipRRect(
                borderRadius: BorderRadius.circular(10.0),
                child: image,
              ),
            );
          },
        );
      }).toList(),
    );
  }

  Widget _buildBottom() {
    final _itemList = List.generate(7, (i) {
      return ListTile(
        leading: Icon(Icons.notifications_none),
        title: Text('[이벤트] 공지 사항이 있습니다.'),
      );
    });


    return ListView(
      physics: NeverScrollableScrollPhysics(),
      shrinkWrap: true,
      children: _itemList,
    );
  }
}

class ServicePage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Center(
      child: Text(
        'Service',
        style: TextStyle(fontSize: 40),
      ),
    );
  }
}

class ProfilePage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Center(
      child: Text(
        'Profile',
        style: TextStyle(fontSize: 40),
      ),
    );
  }
}
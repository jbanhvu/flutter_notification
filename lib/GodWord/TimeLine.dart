import 'package:flutter/material.dart';
import 'package:date_util/date_util.dart';
import 'package:flutter/rendering.dart';
import 'package:intl/intl.dart';
import 'package:scroll_to_index/scroll_to_index.dart';

class TimeLine_Screen extends StatefulWidget {
  @override
  TimeLine_ScreenState createState() => TimeLine_ScreenState();
}
class TimeLine_ScreenState extends State<TimeLine_Screen> {
  double defaultSize = 10;
  Color kPrimaryColor = Colors.blue;
  Color kTextColor = Colors.blue;
  Color kTextLigntColor = Colors.blue;
  AutoScrollController controller;
  final scrollDirection=Axis.vertical;
  int i=1;
  @override
  void initState(){
    super.initState();
    controller=AutoScrollController(
        viewportBoundaryGetter: ()=>
            Rect.fromLTRB(0, 0, 0, MediaQuery.of(context).padding.top),
        axis: scrollDirection
    );
    scrollToToday();
  }
  Future scrollToToday() async{

    var pos=38*(60)-50;
    var value=pos.toString();
    await controller.animateTo(double.parse(value),duration: Duration(milliseconds: 500), curve: Curves.easeOut);
    i++;
  }

  @override
  Widget build(BuildContext context) {
    SizeConfig().init(context);
    return Scaffold(
      appBar: buildAppBar(),
      body: SingleChildScrollView(
        scrollDirection: scrollDirection,
        controller: controller,
        child: buildTimeLine(),
      ),
      //bottomNavigationBar: MyBottomNavBar(),
    );
  }
  Widget buildTimeLine() {
    var dateUtility = DateUtil();
    List<Widget> list = new List<Widget>();
    for(var i = 0; i < 12; i++){
      //list.add(buildMonth());
      for(var j=0;j<dateUtility.daysInMonth((i+1), 2021);j++){
        list.add(buildDay(DateFormat.d().format(DateTime.utc(2021, i+1, 1).add(Duration(days: j)))+' tháng '+DateFormat.M().format(DateTime.utc(2021, i+1, 1).add(Duration(days: j))),""));
      }
    }
    return new Column(children: list);
  }
  InkWell buildDay(String p_date, String p_des) {
    return InkWell(
      onTap: () {scrollToToday() ;},
      child: Padding(
        padding: EdgeInsets.symmetric(
            horizontal: defaultSize * 2, vertical: defaultSize * 1),
        child: SafeArea(
          child: Row(
            children: <Widget>[
              Text(p_date),
              SizedBox(width: defaultSize * 2),
              Text(p_des,
                style: TextStyle(
                  fontSize: defaultSize * 1.6, //16
                  color: kTextLigntColor,
                ),
              ),
              Spacer(),
              Icon(
                Icons.arrow_forward_ios,
                size: defaultSize * 1.6,
                color: kTextColor,
              )
            ],
          ),
        ),
      ),
    );
  }
  Container buildMonth(){
    return Container(
      margin: EdgeInsets.only(bottom: defaultSize), //10
      height: defaultSize * 12, //140
      width:  MediaQuery. of(context). size. width,
      decoration: BoxDecoration(
        border: Border.all(
          color: Colors.white,
          width: defaultSize * 0.5, //8
        ),
        image: DecorationImage(
          fit: BoxFit.cover,
          image:  NetworkImage("http://192.5.1.21:3000/images/VuAvatar.jpg"),
        ),
      ),
    );
  }
  AppBar buildAppBar() {
    return AppBar(
      backgroundColor: kPrimaryColor,
      leading: SizedBox(),
      // On Android it's false by default
      centerTitle: true,
      title: Text("Profile"),
      actions: <Widget>[
        FlatButton(
          onPressed: () {},
          child: Text(
            "Edit",
            style: TextStyle(
              color: Colors.white,
              fontSize: SizeConfig.defaultSize * 1.6, //16
              fontWeight: FontWeight.bold,
            ),
          ),
        ),
      ],
    );
  }
}

class SizeConfig {
  static MediaQueryData _mediaQueryData;
  static double screenWidth;
  static double screenHeight;
  static double defaultSize;
  static Orientation orientation;

  void init(BuildContext context) {
    _mediaQueryData = MediaQuery.of(context);
    screenWidth = _mediaQueryData.size.width;
    screenHeight = _mediaQueryData.size.height;
    orientation = _mediaQueryData.orientation;
    // On iPhone 11 the defaultSize = 10 almost
    // So if the screen size increase or decrease then our defaultSize also vary
    defaultSize = orientation == Orientation.landscape
        ? screenHeight * 0.024
        : screenWidth * 0.024;
  }
}
class CustomShape extends CustomClipper<Path> {
  @override
  Path getClip(Size size) {
    var path = Path();
    double height = size.height;
    double width = size.width;
    path.lineTo(0, height - 100);
    path.quadraticBezierTo(width / 2, height, width, height - 100);
    path.lineTo(width, 0);
    path.close();
    return path;
  }

  @override
  bool shouldReclip(CustomClipper<Path> oldClipper) {
    return true;
  }
}

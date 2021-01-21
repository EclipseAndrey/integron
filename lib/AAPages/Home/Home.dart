import 'package:flutter/material.dart';
import 'package:integron/Utils/IconDataForCategory.dart';
import 'package:integron/Style.dart';
import 'package:integron/Pages/GeneralControllerPages/Home/Settings.dart';
import 'package:integron/AAPages/Home/PageTovar/BodyHome.dart';
import 'package:integron/Utils/DB/Category/Category.dart';
import 'package:integron/AAPages/Home/Search/Search.dart';
import 'package:integron/Utils/fun/TabPanel/TabPanel.dart';

class Home extends StatefulWidget {

  Color  colorPanelText1 = c5894bc;
  Color  colorPanelText2 = Colors.white;
  double radiusPanelLeft = 0;
  double radiusPanelRight = 6;
  double paddingPanel = 0;
  int    durationAnimatePanel = 100;

  PageController controller;
  Home(this.controller);
  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<Home>with AutomaticKeepAliveClientMixin<Home> {
  List<Widget> pages;

  List<Category> selectedCategory = [];
  bool searchFocus = false;

  TabBarProductController tabBarProductController;


  @override
  void initState() {
    tabBarProductController = TabBarProductController();
    tabBarProductController.addListener((index) {
      widget.controller.animateToPage(index, duration: Duration(milliseconds: 200), curve: Curves.ease);
    });
    pages = [
      HomeBody(type: 0,),
      HomeBody(type: 1,),
      HomeBody(type: 2,),
    ];
    widget.controller.addListener(() {
      if(widget.controller.page.round() != tabBarProductController.currentPage){
         tabBarProductController.jumpToPage(widget.controller.page.round());
      }
      setState(() {
      });
    });
  }
  @override
  void dispose() {
    widget.controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {

    super.build(context);

    return Theme(
      data: ThemeData(primaryColor: Colors.transparent),
      child: Scaffold(
        resizeToAvoidBottomInset: false,
        resizeToAvoidBottomPadding: false,
        extendBodyBehindAppBar: true,

        body: Container(
          height: MediaQuery.of(context).size.height,
          width: MediaQuery.of(context).size.width,
          child: Content(),
        ),
      ),
    );
  }

  Widget Content(){
    return Stack(
      children: [
        Align(
          alignment: Alignment.topCenter,
          child: Background(),
        ),
        Align(
          alignment: Alignment.topCenter,
          child: SafeArea(
            bottom: false,
            child: Column(
              children: [
                SizedBox(height: 6,),
                Head(),
                SizedBox(height: 6,),
                SearchWidget(),

                SizedBox(height: 12,),
                Body(),
              ],
            ),
          ),
        ),
      ],
    );
  }

  Widget Background(){
    return Stack(
      children: [
        Align(
          alignment: Alignment.topCenter,
          child: Container(
            //todo image
            height: MediaQuery.of(context).size.width *1.3,
            width: MediaQuery.of(context).size.width,
            child: Image.asset(
              "lib/assets/images/complex.png",
              fit: BoxFit.fill,
            ),
          ),
        ),
        Align(
          alignment: Alignment.bottomCenter,
          child: Container(
            color: cBG,
            width: MediaQuery.of(context).size.width,
            height: MediaQuery.of(context).size.height - MediaQuery.of(context).size.width/2 ,
          ),
        ),
      ],
    );
  }

  Widget Head(){
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
      children: [
        Row(),
        Text(
          "I N T E G R O N",
          style: TextStyle(
            color: Colors.white,
            fontSize: 25,
          ),
        ),
        Row()
      ],
    );
  }
  Widget SearchWidget(){
    return InkWell(
      onTap: ()async{
        searchFocus= true;
        setState(() {

        });
        await Navigator.push(context, Search(context),);
        setState(() {
          searchFocus = false;
        });
      },
      child: Container(
        width: MediaQuery.of(context).size.width * 0.98,

        decoration: BoxDecoration(
          color: Colors.transparent,
          borderRadius: BorderRadius.circular(60),
          border: Border.all(width: 2, color: searchFocus?Colors.transparent:Colors.white),
        ),
        child: Center(child:
        Padding(
          padding: const EdgeInsets.all(8.0),
          child: getIconSvg(id: 42, color: searchFocus?Colors.transparent:Colors.white, size: 24,),
        )
          ,),
      ),
    );
  }

  Widget Body(){

    return Column(
      mainAxisAlignment: MainAxisAlignment.end,
      children: [
       TabBarProducts(
         names: ['Товары','Услуги', 'Обучение'],
         controller: tabBarProductController,
       ),
        Container(
          color: cBG,
          height: 6,
          width: MediaQuery.of(context).size.width,
        ),
        Container(
          color: cBG,
          width: MediaQuery.of(context).size.width,
          height: MediaQuery.of(context).size.height - MediaQuery.of(context).size.width/3-60 ,
          child:PageView(
            // physics: NeverScrollableScrollPhysics(),
            controller: widget.controller,
            children: pages,
          ),
        )
      ],
    );
  }

  @override
  bool get wantKeepAlive => true;

}




// ignore: must_be_immutable

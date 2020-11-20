import 'dart:math';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:omega_qick/Authorization/Pages/PageNum2/Style.dart';
import 'package:omega_qick/Pages/GeneralControllerPages/Home/PageTovar/Tovars.dart';
import 'package:omega_qick/Pages/GeneralControllerPages/Home/PageUslig/Uslugi.dart';
import 'package:omega_qick/Pages/GeneralControllerPages/Home/Search/PageSelectedCategory/PageSelectedCategory.dart';
import 'package:omega_qick/Pages/GeneralControllerPages/Home/Settings.dart';
import 'package:omega_qick/Pages/Login2/Style.dart';
import 'package:omega_qick/Utils/DB/Items/Category.dart';
import 'package:omega_qick/Utils/DB/Items/CategoryPath.dart';
import 'package:omega_qick/Utils/DB/Items/Product.dart';
import 'package:omega_qick/Utils/IconDataForCategory.dart';

import 'package:omega_qick/presentation/integron_icons.dart' as customIcons;

import 'Search/Search.dart';

class Home extends StatefulWidget {

  Color  colorPanelText1 = c5894bc;
  Color  colorPanelText2 = Colors.white;
  double radiusPanelLeft = 0;
  double radiusPanelRight = 6;
  double paddingPanel = 0;
  int    durationAnimatePanel = 100;
  int    pagePanel = 1;

  PageController controllerPages;
  Home(this.controllerPages);



  @override
  _HomeState createState() => _HomeState();
}




class _HomeState extends State<Home> with AutomaticKeepAliveClientMixin<Home> {

  double minusIconsSize = 0;
  double minusFontsSize = 0;
  double heightAppBar = 0.42;

  bool searchFocus = false;

  static final controller = PageController(
    keepPage: true,
    initialPage: 0,
  );






  void clickEmpty(){
    print("Start ${widget.pagePanel}");

    if(widget.pagePanel == 0){
      setState(() {

      });
      controller.animateToPage(1, duration: Duration(milliseconds: 200), curve: Curves.ease);

    }
    else if(widget.pagePanel == 1){
      setState(() {

      });
      controller.animateToPage(0, duration: Duration(milliseconds: 200), curve: Curves.ease);



      setState(() {

      });
      widget.pagePanel = 0;
    }
  }


  List<Category> selectedCategory = [];


  void callBackCategory(Category category,){


    print("Select category ${category.route}");
    if(selectedCategory.length>0){
      selectedCategory = [];
    }else {
      selectedCategory.add(category);
    }


    if(selectedCategory.length == 0){
      pages = [
        Tovars(callBackCategory,widget.controllerPages),
        Uslugi(callBackCategory,widget.controllerPages),
      ];
    }else {
      pages = [
        PageSelectedCategory(selectedCategory, callBackCategory),
        PageSelectedCategory(selectedCategory, callBackCategory),
      ];
    }
    setState(() {

    });

  }


  List<Widget> pages;

  @override
  void initState() {
    pages = [
      Tovars(callBackCategory, widget.controllerPages),
      Uslugi(callBackCategory,widget.controllerPages),
    ];
    setState(() {

    });
  }

  @override
  Widget build(BuildContext context) {

    double shortestSide = MediaQuery.of(context).size.shortestSide;

    if(shortestSide < 400){
      heightAppBar = 0.55;
      minusIconsSize = minusIconsSizeHome400;
      minusFontsSize = minusFontsSizeHome400;
    }




    super.build(context);
    controller.addListener(() {
      widget.paddingPanel = controller.offset/2;
      //print(controller.page);
      widget.pagePanel = controller.page.round();
      if(widget.pagePanel == 1){
        widget.colorPanelText1 = Colors.white;
        widget.colorPanelText2 = c5894bc;
        widget.radiusPanelLeft = 6;
        widget.radiusPanelRight = 0;

      }else{
        widget.colorPanelText1 = c5894bc;
        widget.colorPanelText2 = Colors.white;
        widget.radiusPanelLeft = 0;
        widget.radiusPanelRight = 6;
      }

      setState(() {

      });
    });






    return Theme(
      data: ThemeData(primaryColor: Colors.transparent),
      child: Scaffold(
        extendBodyBehindAppBar: true,
        appBar: AppBar(
          centerTitle: true,
          // leading:  Padding(
          //   padding: const EdgeInsets.all(16.0),
          //   child: getIconForId(id: 41, color: cBG, size: 24),
          // ),
          // leading: Padding(
          //   padding: EdgeInsets.only(
          //     bottom: 20,
          //     right: 13,
          //   ),
          //   child: Icon(Icons.attach_money, size: 24),
          // ),
          // actions: [
          //   Padding(
          //     padding: EdgeInsets.only(bottom: 20, right: 10),
          //     child: Icon(Icons.attach_money, size: 24),
          //   )
          // ],
          title: Padding(
            padding: const EdgeInsets.only(bottom: 0),
            child: Text(
              "I N T E G R O N",
              style: TextStyle(
                color: Colors.white,
                fontSize: 25,
              ),
            ),
          ),
          backgroundColor: Colors.transparent,
          elevation: 0.0,
        ),
        body: SingleChildScrollView(child: Content(heightAppBar, minusFontsSize)),
      ),
    );
  }

  Widget Content(double heightAppBar, double minusFontSize) {

    return Container(
      width: MediaQuery.of(context).size.width,
      height: MediaQuery.of(context).size.height,
      color: cBG,
      child: Stack(
        children: [
          Container(
              height: MediaQuery.of(context).size.width *1.3,
              width: MediaQuery.of(context).size.width,
              child: Image.asset(
                "lib/assets/images/complex.png",
                fit: BoxFit.fill,
              )),
          Align(
            alignment: Alignment.topCenter,
            child: AspectRatio(
              aspectRatio: (MediaQuery.of(context).size.width) /
                  (MediaQuery.of(context).size.width * heightAppBar ),
              child: Container(
                width: MediaQuery.of(context).size.width,
                child: Stack(
                  children: [

                    Align(
                        alignment: Alignment.bottomCenter,
                        child: GestureDetector(
                          onTapUp: (we){},
                          onTap: (){
                            clickEmpty();
                            print("click");
                          },
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.end,
                            children: [
                              GestureDetector(
                                onTap:()async{
                                  searchFocus= true;
                                  setState(() {

                                  });
                                  await Navigator.push(
                                    context,
                                    TutorialOverlay(),
                                  );
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
                                      child: getIconForId(id: 42, color: searchFocus?Colors.transparent:Colors.white, size: 24,),
                                    )
                                    ,),
                                ),
                              ),
                              SizedBox(height: 15,),
                              Container(
                                color: Colors.transparent,
                                height: 50,
                                width: MediaQuery.of(context).size.width,
                                child: Stack(
                                  children: [
                                    AnimatedPadding(
                                      duration: Duration(milliseconds: widget.durationAnimatePanel),
                                      padding:  EdgeInsets.only(left:widget.paddingPanel),
                                      child: Container(
                                        color: Colors.transparent,
                                        width: MediaQuery.of(context).size.width * 0.50,
                                        child: GestureDetector(
                                          onTapUp: (d){},
                                          onTap: (){},
                                          child: AnimatedContainer(
                                            duration: Duration(milliseconds: widget.durationAnimatePanel),
                                            decoration: BoxDecoration(
                                              color: cBG,
                                              borderRadius: BorderRadius.only(
                                                topLeft:
                                                  Radius.circular(widget.radiusPanelLeft),
                                                topRight: Radius.circular(widget.radiusPanelRight)
                                              ),
                                            ),
                                            height: 50,
                                            width:
                                                MediaQuery.of(context).size.width * 0.30,

                                          ),
                                        ),
                                      ),
                                    ),
                                    Row(
                                      crossAxisAlignment: CrossAxisAlignment.center,
                                      children: [
                                        Spacer(),
                                        Column(
                                          mainAxisAlignment: MainAxisAlignment.center,
                                          children: [
                                            Text("Товары", style: TextStyle(color: widget.colorPanelText1, fontSize: 16- minusFontSize, fontWeight: FontWeight.w600, fontStyle: FontStyle.normal, fontFamily: fontFamily),),
                                          ],
                                        ),
                                        Spacer(),
                                        Spacer(),
                                        Column(
                                          mainAxisAlignment: MainAxisAlignment.center,
                                          children: [
                                            Text("Услуги", style: TextStyle(color: widget.colorPanelText2, fontSize: 16 - minusFontSize, fontWeight: FontWeight.w600, fontStyle: FontStyle.normal, fontFamily: fontFamily),),
                                          ],
                                        ),
                                        Spacer(),
                                      ],
                                    ),
                                  ],
                                ),
                              ),
                            ],
                          ),
                        )),

                  ],
                ),
              ),
            ),
          ),
          Catalog(heightAppBar, minusFontSize),
        ],
      ),
    );
  }

  Widget Catalog(double heightAppBar, double minusFontSize){
    return Container(
      width: (MediaQuery.of(context).size.width),
      child: Column(
        children: [
          AspectRatio(
            aspectRatio: (MediaQuery.of(context).size.width) /
                (MediaQuery.of(context).size.width * heightAppBar),),
          Container(
            height: MediaQuery.of(context).size.height - MediaQuery.of(context).size.width * heightAppBar,
            child: PageView(
              controller: controller,
              children: pages,
            ),
          )

        ],
      ),
    );
  }

  @override
  bool get wantKeepAlive => true;

}




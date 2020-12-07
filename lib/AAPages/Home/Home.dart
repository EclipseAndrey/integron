import 'package:flutter/material.dart';
import 'package:omega_qick/Utils/IconDataForCategory.dart';
import 'package:omega_qick/Style.dart';
import 'package:omega_qick/Pages/GeneralControllerPages/Home/Settings.dart';
import 'package:omega_qick/AAPages/Home/PageTovar/Tovars.dart';
import 'package:omega_qick/AAPages/Home/PageUslig/Uslugi.dart';
import 'package:omega_qick/Utils/fun/Callbcks.dart';
import 'package:omega_qick/Utils/DB/Category/Category.dart';
import 'package:omega_qick/AAPages/Home/Search/Search.dart';

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



  void clickEmpty(){

    if(widget.controller.page.round() == 0){
      widget.controller.animateToPage(1, duration: Duration(milliseconds: 200), curve: Curves.ease);
    }
    else if(widget.controller.page.round() == 1){
      widget.controller.animateToPage(0, duration: Duration(milliseconds: 200), curve: Curves.ease);

    }
  }


  @override
  void initState() {
    pages = [
      Tovars(),
      Uslugi(),
    ];
    setState(() {

    });
  }

  @override
  Widget build(BuildContext context) {

    super.build(context);


    widget.controller.addListener(() {
      widget.paddingPanel = widget.controller.offset/2;
      // widget.pagePanel = widget.controller.page.round();
      if(widget.controller.page.round() == 1){
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

    Widget tabBar(){
      return InkWell(
        onTap: (){
          clickEmpty();
        },
        /// стеку вкладок
        child: Stack(
          children: [
            AnimatedPadding(
              duration: Duration(milliseconds: widget.durationAnimatePanel),
              padding:  EdgeInsets.only(left:widget.paddingPanel),
              child: InkWell(
                onTap: (){
                  /// исключает нажатие на белую хуйню
                },
                /// белая хуйня
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
            ),
            /// разметка текста ыкладок
            Container(
              height: 50,
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Spacer(),
                  Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text("Товары", style: TextStyle(color: widget.colorPanelText1, fontSize: 16/*- minusFontSize*/, fontWeight: FontWeight.w600, fontStyle: FontStyle.normal, fontFamily: fontFamily),),
                    ],
                  ),
                  Spacer(),
                  Spacer(),
                  Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text("Услуги", style: TextStyle(color: widget.colorPanelText2, fontSize: 16/* - minusFontSize*/, fontWeight: FontWeight.w600, fontStyle: FontStyle.normal, fontFamily: fontFamily),),
                    ],
                  ),
                  Spacer(),
                ],
              ),
            ),
          ],
        ),
      );
    }




    return Column(
      mainAxisAlignment: MainAxisAlignment.end,
      children: [
        tabBar(),
        // Container(
        //   color: cBG,
        //   height: 6,
        //   width: MediaQuery.of(context).size.width,
        // ),
        Container(
          color: cBG,
          width: MediaQuery.of(context).size.width,
          height: MediaQuery.of(context).size.height - MediaQuery.of(context).size.width/2 ,
          child:PageView(
            controller: widget.controller,
            children: pages,
          ),
        )
      ],
    );
  }

  @override
  // TODO: implement wantKeepAlive
  bool get wantKeepAlive => true;

}

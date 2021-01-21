import 'package:flutter/material.dart';
import 'package:integron/Pages/GeneralControllerPages/Home/Settings.dart';
import 'package:integron/Style.dart';

class TabBarProducts extends StatefulWidget {

  final Color colorActive;
  final Color colorInactive;
  final List<String> names;
  final int initPage;
  final Function (int index) onChange;
  final TabBarProductController controller;
  final Color colorHideCoach;
  final double heightHideCoach;


  TabBarProducts({
    this.initPage = 0,
    this.onChange,
    this.controller,
    this.colorActive = c5894bc,
    this.colorInactive = cWhite,
    this.colorHideCoach = cButtons,
    this.heightHideCoach = 5,
    @required this.names
  }) : assert (names!= null && names.length > 1, "Names не может быть null и его длина не должна быть < 2 ");

  @override
  _TabBarProductsState createState() => _TabBarProductsState();
}

class _TabBarProductsState extends State<TabBarProducts> {

  bool hide = true;
  int currentPage;

  @override
  void initState() {

    if(widget.controller!= null){
      widget.controller.setTabBarProductState(this);
    }
    currentPage = widget.initPage;

    super.initState();
  }


  @override
  Widget build(BuildContext context) {
    return tabBar();
  }

  _setPage(int index){
    currentPage = index;
    setState(() {

    });

    if(widget.controller!= null){
      widget.controller.onChange(index);
    }
  }

  setHide(bool hide){
    this.hide = hide;
    setState(() {});
  }




  Widget tabBar(){

    double wo = MediaQuery.of(context).size.width/widget.names.length;
    double wl = wo + (wo*0.3);
    double ws = (MediaQuery.of(context).size.width - wl)/(widget.names.length-1);

    return Stack(
      children: [
        AnimatedPositioned(
          duration: Duration(milliseconds: 200),
          left: currentPage*ws,
          child: Container(
            color: Colors.transparent,
            width: wl,
            child: GestureDetector(
              onTapUp: (d){},
              onTap: (){},
              child: AnimatedContainer(
                duration: Duration(milliseconds:200),
                decoration: BoxDecoration(
                  color: hide?widget.colorHideCoach:cBG,
                  borderRadius: BorderRadius.only(
                      topLeft:
                      Radius.circular(6),
                      topRight: Radius.circular(6)
                  ),
                ),
                height: hide?(widget.heightHideCoach):50,
                width:
                MediaQuery.of(context).size.width * 0.30,

              ),
            ),
          ),
        ),
        Row(
          children: List.generate(widget.names.length, (index){
            return GestureDetector(
              behavior: HitTestBehavior.translucent,
              onTap:(){
                // currentPage = index;
                // setState(() {
                //
                // });
                try {
                  widget.controller.tap(index);
                }catch(e){}
                // widget.onChange(index);
              } ,
              child: AnimatedContainer(
                duration: Duration(milliseconds: 200),
                height: hide?(widget.heightHideCoach):50,
                width: index==currentPage?wl:ws,
                //color: index == currentPage?widget.colorActive:widget.colorInactive,
                child: hide?SizedBox():Center(child: Text(widget.names[index], style: TextStyle(color: index==currentPage?widget.colorActive:widget.colorInactive, fontSize: 16/*- minusFontSize*/, fontWeight: FontWeight.w600, fontStyle: FontStyle.normal, fontFamily: fontFamily))),
              ),
            );
          }),
        ),
      ],
    );
  }
}


class TabBarProductController {
  _TabBarProductsState _tabBarProductsState;

  int currentPage;

  Function (int index) listener;


  addListener(Function (int index) listener){
    this.listener = listener;
  }

  void hide(bool hide){
    _tabBarProductsState.setHide(hide);
  }


  void onChange(int index){
    currentPage = index;
  }
  void tap(int index){
    if(listener != null)listener(index);
  }


  void setTabBarProductState(_TabBarProductsState state){
    _tabBarProductsState = state;
    currentPage = _tabBarProductsState.currentPage;
  }

  void jumpToPage(int index){
    currentPage = index;
    _tabBarProductsState._setPage(index);
  }


}


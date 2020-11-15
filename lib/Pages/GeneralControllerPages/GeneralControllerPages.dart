import 'dart:convert';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:http/http.dart' as http;
import 'package:omega_qick/Contacts/Pages/PageContacts.dart';
import 'package:omega_qick/EmptyPage.dart';
import 'package:omega_qick/Pages/GeneralControllerPages/Home/Home.dart';
import 'package:omega_qick/Pages/GeneralControllerPages/Purchase/Purchase.dart';

import 'package:omega_qick/Pages/Login2/Style.dart';
import 'package:omega_qick/Style.dart';
import 'package:omega_qick/Utils/IconDataForCategory.dart';

import 'My/My.dart';
import 'Wallets/Wallets.dart';

class GeneralControllerPages extends StatefulWidget {
  @override
  _GeneralControllerPagesState createState() => _GeneralControllerPagesState();
}




class _GeneralControllerPagesState extends State<GeneralControllerPages> {
  List<Widget> pageList = List<Widget>();

  PageController controllerPage = PageController(initialPage: 0);


  DateTime backbuttonpressTime;
  int _selectedIndex = 0;

  @override
  void initState() {
    pageList.add(Home());
    pageList.add(Wallet());
    pageList.add(Cart());
    pageList.add(EmptyPage());
    pageList.add(MyPage());

    setState(() {

    });
    super.initState();
  }

  void _onItemTapped(int index) {
    // controllerPage.jumpTo(index.toDouble());
    setState(() {
      _selectedIndex = index;
    });
  }


  void bottomTapped(int index) {
    setState(() {
      _selectedIndex = index;
      controllerPage.animateToPage(index, duration: Duration(milliseconds: 300), curve: Curves.ease);
    });
  }

  StatefulWidget currentWidget() {
    if (_selectedIndex == 0) return Home();
    if (_selectedIndex == 1) return Wallet();
    if (_selectedIndex == 2) return Cart();
    if (_selectedIndex == 3) return EmptyPage();
    if (_selectedIndex == 3) return MyPage();
  }

  double blurSide = 10;

  Future<bool> onWillPop()async{
    DateTime currentTime = DateTime.now();
    bool back = backbuttonpressTime == null ||currentTime.difference(backbuttonpressTime)> Duration(seconds: 3);

    if(back){
      backbuttonpressTime = currentTime;
      Fluttertoast.showToast(
          msg: "Нажмите еще раз для выхода",
          toastLength: Toast.LENGTH_SHORT,
          gravity: ToastGravity.SNACKBAR,
          timeInSecForIosWeb: 1,
          backgroundColor: Colors.white,
          textColor: Colors.black,
          fontSize: 16.0
      );
      return false;
    }
    return true;
  }


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      extendBodyBehindAppBar: true,
      body: WillPopScope(
        onWillPop: onWillPop,
        child: Stack(
          children: [
            // IndexedStack(
            //   index: _selectedIndex,
            //   children: pageList,
            // ),
            PageView(
              physics: NeverScrollableScrollPhysics(),
              children: pageList,
              controller: controllerPage,
              onPageChanged: (index){
                _onItemTapped(index);
              },
            ),
            Align(
              alignment: Alignment.bottomCenter,
              child: Theme(
                data: Theme.of(context)
                    .copyWith(canvasColor: cBG.withOpacity(0.7)),
                child: BottomNavigationBar(
                  elevation: 0,

                  // backgroundColor: Color.fromRGBO(22, 26, 31, 1),

                  items:  <BottomNavigationBarItem>[
                    BottomNavigationBarItem(
                      activeIcon: getIconForId(id: 52, color: c6287A1),
                      icon: getIconForId(id: 21, color: c6287A1),
                      title: Text(
                        'Главная',
                      ),
                    ),
                    BottomNavigationBarItem(
                      activeIcon: getIconForId(id: 54, color: c6287A1),
                      icon: getIconForId(id: 49, color: c6287A1),
                      title: Text(
                        'Кошельки',
                      ),
                    ),
                    BottomNavigationBarItem(
                      activeIcon: getIconForId(id: 51, color: c6287A1),
                      icon: getIconForId(id: 55, color: c6287A1),
                      title: Text(
                        'Покупки',
                      ),
                    ),
                    BottomNavigationBarItem(
                      activeIcon: getIconForId(id: 50, color: c6287A1),
                      icon: getIconForId(id: 5, color: c6287A1),
                      title: Text(
                        'Бизнесы',
                      ),
                    ),
                    BottomNavigationBarItem(
                      activeIcon: getIconForId(id: 53, color: c6287A1),
                      icon: getIconForId(id: 48, color: c6287A1),
                      title: Text(
                        'Мое',
                      ),
                    ),
                  ],
                  unselectedItemColor: c6287A1,
                  // selectedFontSize: 12,
                  // unselectedFontSize: 12,
                  type: BottomNavigationBarType.fixed,
                  showUnselectedLabels: true,
                  currentIndex: _selectedIndex,
                  selectedItemColor: c6287A1,
                  onTap: bottomTapped,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:omega_qick/Contacts/Pages/PageContacts.dart';
import 'package:omega_qick/EmptyPage.dart';
import 'package:omega_qick/HomePage/Home.dart';
import 'package:omega_qick/Style.dart';
import 'Account/AccountPage.dart';
import 'Head/ControllerHeader.dart';
import 'JsonParse.dart';
import 'ToolsPanel/Panel.dart';



class PageBalance extends StatefulWidget {




  @override
  _PageBalanceState createState() => _PageBalanceState();
}

class _PageBalanceState extends State<PageBalance> {

  List<Widget> pageList = List<Widget>();

  int _selectedIndex = 0;

  @override
  void initState() {

    pageList.add(Home());
    pageList.add(ContactsPage());
    pageList.add(EmptyPage());
    pageList.add(AccountPage());

    super.initState();
  }

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  StatefulWidget currentWidget(){
    if(_selectedIndex == 0)return Home();
    if(_selectedIndex == 1)return ContactsPage();
    if(_selectedIndex == 2)return EmptyPage();
    if(_selectedIndex == 3)return AccountPage();
  }





  double blurSide = 10;
  @override
  Widget build(BuildContext context) {




    return Scaffold(
      bottomNavigationBar: Theme(
        data: Theme.of(context)
            .copyWith(canvasColor: Color.fromRGBO(22, 26, 31, 1)),
        child: BottomNavigationBar(

          // backgroundColor: Color.fromRGBO(22, 26, 31, 1),

          items: const <BottomNavigationBarItem>[
            BottomNavigationBarItem(
              icon: Icon(Icons.home, ),
              title: Text('Главная',),
            ),
            BottomNavigationBarItem(
              icon: Icon(Icons.perm_contact_calendar,),
              title: Text('Контакты',),
            ),
            BottomNavigationBarItem(
              icon: Icon(Icons.import_export, ),
              title: Text('История', ),
            ),
            BottomNavigationBarItem(
              icon: Icon(Icons.person, ),
              title: Text('Аккаунт', ),
            ),
          ],
          unselectedItemColor: Colors.white,
          currentIndex: _selectedIndex,
          selectedItemColor: Color.fromRGBO(140 , 90, 252, 1),
          onTap: _onItemTapped,
        ),
      ),

      body:  IndexedStack(
      index: _selectedIndex,
      children: pageList,
    ),
    );
  }
}


import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:integron/AAPages/Blocs/Cart/CartCubit.dart';
import 'package:integron/AAPages/Blocs/Category/CategoryCubit.dart';
import 'package:integron/AAPages/Blocs/Feed/TovarsCubit.dart';
import 'package:integron/AAPages/Blocs/History/HistoryCubit.dart';
import 'package:integron/Pages/GeneralControllerPages/AboutIntegron/AboutReferal.dart';
import 'package:integron/Pages/GeneralControllerPages/My/My.dart';
import 'package:integron/Pages/GeneralControllerPages/Purchase/Purchase.dart';
import 'package:integron/Pages/GeneralControllerPages/Wallets/Wallets.dart';
import 'package:integron/Style.dart';
import 'package:integron/Utils/IconDataForCategory.dart';
import 'package:integron/main.dart';
import 'Blocs/Balance/BalanceCubit.dart';
import 'Blocs/Feed/UslugiCubit.dart';
import 'GeneralCubit.dart';
import 'package:integron/AAPages/Home/Home.dart';


class GeneralControllerPages extends StatefulWidget {
  @override
  _GeneralControllerPagesState createState() => _GeneralControllerPagesState();
}


class _GeneralControllerPagesState extends State<GeneralControllerPages> {

  List<Widget> pageList;

  PageController controllerPage = PageController(initialPage: 0);
  static final controllerHome = PageController(
    keepPage: true,
    initialPage: 0,
  );

  DateTime backbuttonpressTime;
  int _selectedIndex = 0;

  // @override
  // void initState() {
  //   // getCart();
  //
  //   pageList.add(Home(controllerPage));
  //   pageList.add(Wallet());
  //   pageList.add(Cart(context));
  //   pageList.add(AboutReferal());
  //   pageList.add(MyPage());
  //
  //   setState(() {
  //
  //   });
  //   super.initState();
  // }

  void _onItemTapped(int index) {
    // controllerPage.jumpTo(index.toDouble());
    setState(() {
      _selectedIndex = index;
    });
  }


  void bottomTapped(int index) {
    // setState(() {});
      //_selectedIndex = index;
     // controllerPage.animateToPage(index, duration: Duration(milliseconds: 300), curve: Curves.ease);

  }

  // StatefulWidget currentWidget() {
  //   if (_selectedIndex == 0) return Home(controllerPage);
  //   if (_selectedIndex == 1) return Wallet();
  //   if (_selectedIndex == 2) return Cart();
  //   if (_selectedIndex == 3) return EmptyPage();
  //   if (_selectedIndex == 3) return MyPage();
  // }

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

  List<BottomNavigationBarItem> listButtons;

  @override
  void initState() {

    listButtons = FullVersion?[
      BottomNavigationBarItem(
        activeIcon: getIconSvg(id: 52, color: c6287A1),
        icon: getIconSvg(id: 21, color: c6287A1),
        title: Text(
          'Главная',
        ),
      ),
      BottomNavigationBarItem(
        activeIcon: getIconSvg(id: 54, color: c6287A1),
        icon: getIconSvg(id: 49, color: c6287A1),
        title: Text(
          'Кошельки',
        ),
      ),
      BottomNavigationBarItem(
        activeIcon: getIconSvg(id: 51, color: c6287A1),
        icon: getIconSvg(id: 55, color: c6287A1),
        title: Text(
          'Покупки',
        ),
      ),
      BottomNavigationBarItem(
        activeIcon: getIconSvg(id: 50, color: c6287A1),
        icon: getIconSvg(id: 5, color: c6287A1),
        title: Text(
          'Бизнесы',
        ),
      ),
      BottomNavigationBarItem(
        activeIcon: getIconSvg(id: 53, color: c6287A1),
        icon: getIconSvg(id: 48, color: c6287A1),
        title: Text(
          'Мое',
        ),
      ),
    ]:[
      BottomNavigationBarItem(
        activeIcon: getIconSvg(id: 52, color: c6287A1),
        icon: getIconSvg(id: 21, color: c6287A1),
        title: Text(
          'Главная',
        ),
      ),
      BottomNavigationBarItem(
        activeIcon: getIconSvg(id: 50, color: c6287A1),
        icon: getIconSvg(id: 5, color: c6287A1),
        title: Text(
          'Бизнесы',
        ),
      ),
      BottomNavigationBarItem(
        activeIcon: getIconSvg(id: 53, color: c6287A1),
        icon: getIconSvg(id: 48, color: c6287A1),
        title: Text(
          'Мое',
        ),
      ),
    ];


    super.initState();
  }


  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider<GeneralCubit>(create: (BuildContext context) => GeneralCubit()),
        BlocProvider<BalanceCubit>(create: (BuildContext context) => BalanceCubit()),
        BlocProvider<CategoryCubit>(create: (BuildContext context) => CategoryCubit()),
        BlocProvider<TovarsCubit>(create: (BuildContext context) => TovarsCubit()),
        BlocProvider<UslugiCubit>(create: (BuildContext context) => UslugiCubit()),
        BlocProvider<HistoryCubit>(create: (BuildContext context) => HistoryCubit()),
        BlocProvider<CartCubit>(create: (BuildContext context) => CartCubit()),
    ],
      child: BlocBuilder<GeneralCubit,GeneralState>(
        builder: (context, state){
          if(state is GeneralCurrentPage) {
            if (state.index != _selectedIndex) {
              controllerPage.animateToPage(state.index, duration: Duration(milliseconds: 300), curve: Curves.ease);
              _selectedIndex = state.index;

            }
          }
          return Content(context, state);
        }
      ),
    );
  }







  Widget Content(BuildContext context1,var state ){
    pageList = FullVersion?[
      Home(controllerHome),
      Wallet(),
      Cart(context1, false),
      AboutReferal(),
      MyPage()
    ]:[
      Home(controllerHome),
      AboutReferal(),
      MyPage()
    ];
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

                  items:  listButtons,
                  unselectedItemColor: c6287A1,
                  // selectedFontSize: 12,
                  // unselectedFontSize: 12,
                  type: BottomNavigationBarType.fixed,
                  showUnselectedLabels: true,
                  currentIndex: state.index,
                  selectedItemColor: c6287A1,
                  onTap: (index){
                    if(index == 0){
                      controllerHome.animateToPage(0, duration: Duration(milliseconds: 300), curve: Curves.ease);

                      SystemChrome.setSystemUIOverlayStyle(
                        SystemUiOverlayStyle(
                          //statusBarColor: cBackground,
                          systemNavigationBarColor: Color(0x00cccccc),
                          systemNavigationBarDividerColor: Color(0x00cccccc),
                          systemNavigationBarIconBrightness: Brightness.dark,
                          statusBarColor: Color(0xFFdae8ef),
                          statusBarIconBrightness: Brightness.dark,
                          statusBarBrightness: Brightness.dark,
                        ),
                      );
                      BlocProvider.of<TovarsCubit>(context1).load();
                      BlocProvider.of<UslugiCubit>(context1).load();
                    }else if(index == 1){
                      SystemChrome.setSystemUIOverlayStyle(
                        SystemUiOverlayStyle(
                          //statusBarColor: cBackground,
                          systemNavigationBarColor: Color(0x00cccccc),
                          systemNavigationBarDividerColor: Color(0x00cccccc),
                          systemNavigationBarIconBrightness: Brightness.dark,
                          statusBarColor: Color(0xFFdae8ef),
                          statusBarIconBrightness: Brightness.dark,
                          statusBarBrightness: Brightness.dark,
                        ),
                      );

                    }else if (index == 2){
                      SystemChrome.setSystemUIOverlayStyle(
                        SystemUiOverlayStyle//.dark
                          (
                          //statusBarColor: cBackground,
                          systemNavigationBarColor: Color(0x00cccccc),
                          systemNavigationBarDividerColor: Color(0x00cccccc),
                          systemNavigationBarIconBrightness: Brightness.dark,
                          statusBarColor: Color(0xFFffffff),
                          statusBarIconBrightness: Brightness.dark,
                          statusBarBrightness: Brightness.dark,
                        ),
                      );
                      BlocProvider.of<CartCubit>(context1).load();

                    }else if(index == 3){
                      SystemChrome.setSystemUIOverlayStyle(
                        SystemUiOverlayStyle//.dark
                          (
                          //statusBarColor: cBackground,
                          systemNavigationBarColor: Color(0x00cccccc),
                          systemNavigationBarDividerColor: Color(0x00cccccc),
                          systemNavigationBarIconBrightness: Brightness.dark,
                          statusBarColor: Color(0xFFffffff),
                          statusBarIconBrightness: Brightness.dark,
                          statusBarBrightness: Brightness.dark,
                        ),
                      );
                    }else if (index == 4){
                      SystemChrome.setSystemUIOverlayStyle(
                        SystemUiOverlayStyle//.dark
                          (
                          //statusBarColor: cBackground,
                          systemNavigationBarColor: Color(0x00cccccc),
                          systemNavigationBarDividerColor: Color(0x00cccccc),
                          systemNavigationBarIconBrightness: Brightness.dark,
                          statusBarColor: Color(0xFFffffff),
                          statusBarIconBrightness: Brightness.dark,
                          statusBarBrightness: Brightness.dark,
                        ),
                      );
                    }
                    BlocProvider.of<GeneralCubit>(context1).selectPage(index);
                  },
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

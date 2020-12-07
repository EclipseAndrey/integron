import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:omega_qick/AAPages/Blocs/Balance/BalanceCubit.dart';
import 'package:omega_qick/AAPages/Blocs/Cart/CartCubit.dart';
import 'package:omega_qick/AAPages/GeneralCubit.dart';
import 'package:omega_qick/Pages/GeneralControllerPages/AboutIntegron/AboutIntegron.dart';
import 'package:omega_qick/Pages/GeneralControllerPages/Home/ItemGetter.dart';
import 'package:omega_qick/Pages/GeneralControllerPages/Home/Settings.dart';
import 'package:omega_qick/Pages/GeneralControllerPages/Home/SwiperSets.dart';
import 'package:omega_qick/Providers/WalletProvider/WalletProvider.dart';
import 'package:omega_qick/Style.dart';
import 'package:omega_qick/Utils/DB/Category/Category.dart';
import 'package:omega_qick/Utils/DB/Products/Product.dart';
import 'package:omega_qick/Utils/DB/Products/Set.dart';
import 'package:omega_qick/Utils/DB/Wallet/Balance.dart';
import 'package:omega_qick/Utils/IconDataForCategory.dart';
import 'package:omega_qick/main.dart';

class MainPanel extends StatefulWidget {
  BuildContext context1;
  ProductShort product;
  Category category;

  MainPanel(this.context1, this.product,this.category,);

  @override
  _MainPanelState createState() => _MainPanelState();
}

class _MainPanelState extends State<MainPanel> with TickerProviderStateMixin {

  /// [c] - отсуп по центру между элементами
  /// [edge] - отступ по краям
  /// [h2] - высота блока 2
  /// [h1] - высота блока 1
  /// [h0] - высота блока 0
  /// [w] - стандартная ширина элемента
  /// [p] - отступ в 4%

  double c = 12;
  double edge = 18;
  double h2= 0;
  double h1= 0;
  double h0= 0;
  double w =0;
  double p =0;

  double minusIconsSize = 0;
  double minusFontsSize = 0;


 @override
  Widget build(BuildContext context) {


   p  = MediaQuery.of(widget.context1).size.width*0.04;

   w =  MediaQuery.of(context).size.width/2 - c/2 - edge;
   h2  = w*1.50;
   h1  = w*0.72;
   h0  = w*0.33;




   double shortestSide = MediaQuery.of(context).size.shortestSide;

   if(shortestSide < 400){
     minusIconsSize = minusIconsSizeHome400;
     minusFontsSize = minusFontsSizeHome400;
   }


   return Container(
      width: MediaQuery.of(widget.context1).size.width,
      child:
      Padding(
        padding:  EdgeInsets.symmetric(vertical: c),
        child: Column(
          children: [
            Row(
               mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [

                //swiper(minusFontsSize),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    balance(),
                    SizedBox(height: c, width: c,),
                    operationWithTokens(minusFontsSize),
                    //cat(),
                  ],
                )
              ],
            ),
            // Padding(
            //   padding: const EdgeInsets.symmetric(vertical: 6.0, horizontal: 8),
            //   child: panelIcons(),
            // )
            SizedBox(height: p,),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                info(),
                SizedBox(width: c,),
                referal(),
              ],
            ),

          ],
        ),
      ),
    );
  }
  Widget info(){
    return GestureDetector(
      onTap: (){
        Navigator.push(context, MaterialPageRoute(builder: (BuildContext context) => AboutIntegron()));

      },
      child: Container(
        height: h2,
        width: w,
        child: Container(
            decoration: BoxDecoration(
              boxShadow: shadowContainer,
              borderRadius: BorderRadius.circular(6),
              color:Colors.white ,
            ),

            child: Column(
              children: [
                Container(

                  width: MediaQuery.of(context).size.width*0.45,
                  height: MediaQuery.of(context).size.width*0.30,
                  child: Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: ClipRRect(
                        borderRadius: BorderRadius.only(topLeft: Radius.circular(6), topRight: Radius.circular(6)),
                        child: Image.asset("lib/assets/icons/IconApp/128x128.png", fit: BoxFit.contain,)),
                  ),
                ),
                Spacer(),
                Container(
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Text("Что такое Integron", style: TextStyle(color: cMainText, fontFamily: fontFamily, fontStyle: FontStyle.normal, fontWeight: FontWeight.w700, fontSize: 16),),
                    ],
                  ),
                ),
                Spacer()
              ],
            ),
        ),
      ),
    );
  }

  Widget referal(){
    return GestureDetector(
      onTap: (){
        // widget.controller.animateToPage(3, duration: Duration(milliseconds: 200), curve: Curves.ease);
        BlocProvider.of<GeneralCubit>(context).selectPage(3);

      },
      child: Container(
        height: h2,
        width: w,
        child: Container(
          decoration: BoxDecoration(
            boxShadow: shadowContainer,
            borderRadius: BorderRadius.circular(6),
            color:Colors.white ,
          ),

          child: Column(
            children: [
              Container(
                width: MediaQuery.of(context).size.width*0.45,
                height: MediaQuery.of(context).size.width*0.30,
                child: ClipRRect(
                    borderRadius: BorderRadius.only(topLeft: Radius.circular(6), topRight: Radius.circular(6)),
                    child: Image.asset("lib/assets/images/welcome.png", fit: BoxFit.cover,)),
              ),
              Spacer(),
              Container(
                child: Center(
                  child: Text("Зарабатывай\nВместе с нами", style: TextStyle(color: cMainText, fontFamily: fontFamily, fontStyle: FontStyle.normal, fontWeight: FontWeight.w700, fontSize: 16),),
                ),
              ),
              Spacer(),
            ],
          ),
        ),
      ),
    );
  }
  
  Widget swiper(double minusFontSize){
    List<SetBloc> list =[
      SetBloc(name: "Костюмы на хеллоуин",image: "https://i.pinimg.com/originals/fb/15/de/fb15de452e440f7dbf150b3bf379c116.jpg",route:  1),
      SetBloc(name: "Школьная форма",image: "https://static.zerochan.net/Unasaka.Ryou.full.2113277.jpg",route:  1),
      SetBloc(name: "Топ вейпов",image: "https://ae01.alicdn.com/kf/HTB1eXg8bh_rK1RkHFqDq6yJAFXaK/Vapeonly-PD1865-TC-Subohm-3-6-vape-mod.jpg",route:  1)

    ];
    return Container(
      height: h2,
      width: w,
      child: Container(
          decoration: BoxDecoration(
            boxShadow: [
              BoxShadow(
                color: Colors.grey.withOpacity(0.5),
                spreadRadius: 5,
                blurRadius: 7,
                offset: Offset(0, 3), // changes position of shadow
              ),
            ],
            borderRadius: BorderRadius.circular(6),
            color:Colors.white ,
          ),

          child: SwiperSets(list, minusFontSize)),
    );
  }

  Widget balance(){
    return GestureDetector(
      onTap: (){
        BlocProvider.of<GeneralCubit>(context).selectPage(1);
        // widget.controller.animateToPage(1, duration: Duration(milliseconds: 200), curve: Curves.ease);
      },
      child: Container(
        decoration: BoxDecoration(
            boxShadow: [
              BoxShadow(
                color: Color.fromRGBO(122, 139, 163, 0.3),
                spreadRadius: 0,
                blurRadius: 20,
                offset: Offset(0, 0), // changes position of shadow
              ),
            ],
            borderRadius: BorderRadius.circular(6),
            color: Colors.white
        ),
        width: w,
        height: h0,
        child: BlocBuilder<BalanceCubit,BalanceState>(
          builder: (context, state){
            if(state is BalanceComplete){
              return Padding(
                    padding:  EdgeInsets.only(top: 8.0, bottom: 8, left: c, right: c),
                    child: Row(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        getIconSvg(id:49, color: cMainText, size: 24,),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.end,
                          children: [
                            Text(state.balance.balance.toString(), style: TextStyle(color: cMainText, fontStyle: FontStyle.normal, fontSize: 16 - minusFontsSize, fontWeight: FontWeight.w700),),
                            Text(" DEL", style: TextStyle(color: c6287A1, fontStyle: FontStyle.normal, fontSize: 16 - minusFontsSize, fontWeight: FontWeight.w400)),
                          ],
                        ),
                      ],
                    ),
                  );
            }else{
              return Center(child: CircularProgressIndicator());
            }
          },
        ),
        // child: loadingBalance?Center(child: CircularProgressIndicator()):Padding(
        //   padding: const EdgeInsets.only(top: 8.0, bottom: 8, left: 12, right: 12),
        //   child: Row(
        //     crossAxisAlignment: CrossAxisAlignment.center,
        //     mainAxisAlignment: MainAxisAlignment.spaceBetween,
        //     children: [
        //       getIconSvg(id:49, color: cMainText, size: 24,),
        //       Row(
        //         mainAxisAlignment: MainAxisAlignment.end,
        //         children: [
        //           Text(BALANCE.toString(), style: TextStyle(color: cMainText, fontStyle: FontStyle.normal, fontSize: 16 - minusFontsSize, fontWeight: FontWeight.w700),),
        //           Text(" DEL", style: TextStyle(color: c6287A1, fontStyle: FontStyle.normal, fontSize: 16 - minusFontsSize, fontWeight: FontWeight.w400)),
        //         ],
        //       ),
        //
        //
        //     ],
        //   ),
        // ),
      ),
    );
  }

  Widget operationWithTokens(double minusFontSize){
    return GestureDetector(
      onTap: (){
        // widget.controller.animateToPage(1, duration: Duration(milliseconds: 200), curve: Curves.ease);
        BlocProvider.of<GeneralCubit>(context).selectPage(1);

      },
      child: Container(
        decoration: BoxDecoration(
            boxShadow: [
              BoxShadow(
                color: Color.fromRGBO(122, 139, 163, 0.3),
                spreadRadius: 0,
                blurRadius: 20,
                offset: Offset(0, 0), // changes position of shadow
              ),
            ],
            borderRadius: BorderRadius.circular(6),
          color: c8dcde0
        ),
        width: w,
        height: h0,
        child: Padding(
          padding: const EdgeInsets.only(top: 8.0, bottom: 8, left: 12, right: 12),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Expanded(
                flex: 7,

                  child: Container(child: Text("Операции с токенами",style: TextStyle(color: Colors.white, fontStyle: FontStyle.normal, fontSize: 16 - minusFontSize, fontWeight: FontWeight.w700)))),
              Expanded(
                  flex: 1,
                  child: getIconSvg(id:3, size: 22, color: Colors.white,))
            ],
          ),
        ),
      ),
    );
  }

  Widget cat(){
    return
      ItemGetter(widget.category, widget.context1, minusFontsSize,minusIconsSize)
    ;
  }

  Widget panelIcons(){
    double size = 50 - minusIconsSize;

    return Container(
      decoration: BoxDecoration(
          boxShadow: [
            BoxShadow(
              color: Colors.grey.withOpacity(0.5),
              spreadRadius: 5,
              blurRadius: 7,
              offset: Offset(0, 3), // changes position of shadow
            ),
          ],
          borderRadius: BorderRadius.circular(6),
          color: Colors.white
      ),
      child: Padding(
        padding: const EdgeInsets.all(6.0),
        child: Column(
          children: [
            SizedBox(height: 8,),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Icon(Icons.category, color: Colors.redAccent.withOpacity(0.2), size: size,),
                Icon(Icons.category, color: Colors.redAccent.withOpacity(0.2), size: size,),
                Icon(Icons.category, color: Colors.redAccent.withOpacity(0.2), size: size,),
                Icon(Icons.category, color: Colors.redAccent.withOpacity(0.2), size: size,),
                Icon(Icons.category, color: Colors.redAccent.withOpacity(0.2), size: size,),
                Icon(Icons.category, color: Colors.redAccent.withOpacity(0.2), size: size,),
              ],
            ),

            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Text("Подписки на приложения за любой токен", style: TextStyle(color: cMainText, fontWeight: FontWeight.w700, fontSize: 16 - minusFontsSize, fontStyle: FontStyle.normal),),
            ),
          ],
        ),
      ),
    );
  }
  

  
  
  
  
}

import 'package:flutter/material.dart';
import 'package:focused_menu/modals.dart';
import 'package:integron/Pages/GeneralControllerPages/Home/Settings.dart';
import 'package:integron/Style.dart';
import 'package:integron/Utils/IconDataForCategory.dart';
import 'package:integron/Utils/FilterWidget/Filter.dart';
import 'package:integron/AAPages/Blocs/History/HistoryCubit.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:integron/Utils/DB/Wallet/Filters.dart';


class MyDynamicHeader extends SliverPersistentHeaderDelegate {
  int index = 0;

  @override
  Widget build(
      BuildContext context, double shrinkOffset, bool overlapsContent) {

    return LayoutBuilder(
      builder: (context, constraints) {
        final Color color = Colors.primaries[index];
        final double percentage = 1;
        if (++index > Colors.primaries.length - 1) index = 0;

        return Container(
          color: Color.fromRGBO(250, 250, 250, 1),
          height: constraints.maxHeight,
          child: Padding(
            padding: const EdgeInsets.only(top: 35.0, left: 12, right: 24),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Column(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    TextHistory(),
                    TypeTxText()
                  ],
                ),
                Column(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    FilterWidget(context),
                    Padding(
                      padding:  EdgeInsets.only(right: 0.0),
                      child: Summ(),
                    ),
                  ],
                )
              ],
            ),
          ),
        );
      },
    );
  }



  Widget TextHistory(){
    return Text("История транзакций",
        style: TextStyle(
            fontSize: 16,
            fontWeight: FontWeight.w700,
            color: cMainText,
            fontFamily: "Open Sans"));
  }


  Widget FilterWidget(BuildContext context){

    int currentItem(HistoryState state){
      if(state is HistoryLoading){
        return 0;
      }else if(state is HistoryComplete){
        if(state.filter is All){return 0;}
        else if(state.filter is PayToken){return 1;}
        else if(state.filter is TokenSale){return 2;}
        else if(state.filter is TransferTokens){return 3;}
        else if(state.filter is ExchangeTokens){return 4;}
        else if(state.filter is Delegate){return 5;}
        else if(state.filter is PayProduct){return 1;}
        else if(state.filter is PayService){return 2;}
        else return 0;
      }else return 0;
    }
    String currentName(HistoryState state){
      if(state is HistoryLoading){
        return "Без фильтра";
      }else if(state is HistoryComplete){
        if(state.filter is All){return "Без фильтра";}
        else if(state.filter is PayToken){return "Покупка токенов";}
        else if(state.filter is TokenSale){return "Продажа токенов";}
        else if(state.filter is TransferTokens){return "Перевод токенов";}
        else if(state.filter is ExchangeTokens){return "Обмен токенов";}
        else if(state.filter is Delegate){
          print("Делегирование");
          return "Делегирование";}
        else if(state.filter is PayProduct){return "Оплата товара";}
        else if(state.filter is PayService){return "Оплата услуги";}
        else return "Без фильтра";
      }else return "Без фильтра";
    }

    double menuW = 0;
    if(MediaQuery.of(context).size.width < 400){
      menuW = MediaQuery.of(context).size.width*0.50;
    }else{
      menuW = MediaQuery.of(context).size.width*0.40;
    }


    return BlocBuilder<HistoryCubit,HistoryState>(
      builder: (context, state)=> Row(
        children: [
          FilterMenuHolder(
            menuWidth:menuW ,
            blurSize: 0.0,
            menuItemExtent: 50,
            onPressed: (){},
            menuOffset: -30.0, // Offset value to show menuItem from the selected item
            bottomOffsetHeight: 50.0, // Offset height to consider, for showing the menu item ( for example bottom navigation bar), so that the popup menu will be shown on top of selected item.

            menuItems: [
              FocusedMenuItem(title: Text("Без фильтра", style: TextStyle(color: cLinks, fontSize: 14, fontWeight: FontWeight.w400, fontFamily: fontFamily),), onPressed: (){BlocProvider.of<HistoryCubit>(context).setFilter(Filter.all);}),
              // FocusedMenuItem(title: Text("Покупка токенов", style: TextStyle(color: cLinks, fontSize: 14, fontWeight: FontWeight.w400, fontFamily: fontFamily),), onPressed: (){BlocProvider.of<HistoryCubit>(context).setFilter(Filter.payToken);}),
              // FocusedMenuItem(title: Text("Продажа токенов", style: TextStyle(color: cLinks, fontSize: 14, fontWeight: FontWeight.w400, fontFamily: fontFamily),), onPressed: (){BlocProvider.of<HistoryCubit>(context).setFilter(Filter.tokenSale);}),
              // FocusedMenuItem(title: Text("Перевод токенов", style: TextStyle(color: cLinks, fontSize: 14, fontWeight: FontWeight.w400, fontFamily: fontFamily),), onPressed: (){BlocProvider.of<HistoryCubit>(context).setFilter(Filter.transferTokens);}),
              // FocusedMenuItem(title: Text("Обмен токенов", style: TextStyle(color: cLinks, fontSize: 14, fontWeight: FontWeight.w400, fontFamily: fontFamily),), onPressed: (){BlocProvider.of<HistoryCubit>(context).setFilter(Filter.exchangeTokens);}),
              // FocusedMenuItem(title: Text("Делегирование", style: TextStyle(color: cLinks, fontSize: 14, fontWeight: FontWeight.w400, fontFamily: fontFamily),), onPressed: (){BlocProvider.of<HistoryCubit>(context).setFilter(Filter.delegate);}),
              FocusedMenuItem(title: Text("Оплата товара", style: TextStyle(color: cLinks, fontSize: 14, fontWeight: FontWeight.w400, fontFamily: fontFamily),), onPressed: (){BlocProvider.of<HistoryCubit>(context).setFilter(Filter.payProduct);}),
              FocusedMenuItem(title: Text("Оплата услуги", style: TextStyle(color: cLinks, fontSize: 14, fontWeight: FontWeight.w400, fontFamily: fontFamily),), onPressed: (){BlocProvider.of<HistoryCubit>(context).setFilter(Filter.payService);}),

            ],
            currentItem: currentItem(state),
            child: Container(
              child:  Row(
              children: [
                Text(
                  currentName(state),
                  style: TextStyle(
                      fontSize: 14,
                      fontWeight: FontWeight.w400,
                      fontFamily: "Open Sans",
                      color: Color.fromRGBO(88, 148, 168, 1)),
                ),
                SizedBox(width: 6,),
                getIconSvg(id:19,
                  color: c6287A1,
                  size: 22,
                ),
              ],
            ),
          ),
          ),

        ],
      ),
    );
  }


  Widget TypeTxText(){
    return Text("Дата Контрагент / Операция",
        style: TextStyle(fontSize: 12, color: Colors.grey, fontWeight: FontWeight.w400));
  }
  Widget Summ(){
    return Text("Сумма Токен",
        style: TextStyle(fontSize: 12, color: Colors.grey));
  }



  @override
  bool shouldRebuild(SliverPersistentHeaderDelegate _) => true;

  @override
  double get maxExtent => 120.0;

  @override
  double get minExtent => 120.0;
}

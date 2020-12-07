import 'package:flutter/material.dart';
import 'package:omega_qick/Style.dart';
import 'package:omega_qick/Utils/IconDataForCategory.dart';

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
            padding: const EdgeInsets.only(top: 35.0, left: 12, right: 12),
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
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Filter(),
                    Padding(
                      padding: const EdgeInsets.only(right: 35.0),
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
  Widget Filter(){
    return Row(
      children: [
        Text(
          "Без фильтра",
          style: TextStyle(
              fontSize: 14,
              fontWeight: FontWeight.w400,
              fontFamily: "Open Sans",
              color: Color.fromRGBO(88, 148, 168, 1)),
        ),
        SizedBox(width: 4,),
        getIconSvg(id:19,
          color: c6287A1,
          size: 22,
        ),
      ],
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

import 'package:flutter/material.dart';

class HeadLogo extends SliverPersistentHeaderDelegate {
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
          color: Colors.transparent,
          height: constraints.maxHeight,
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Padding(
                padding: const EdgeInsets.all(12.0),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Padding(
                      padding: const EdgeInsets.only(
                        left: 10,
                        top: 3,
                      ),
                      child: Text("История транзакций",
                          style: TextStyle(
                              fontSize: 16,
                              fontWeight: FontWeight.w700,
                              color: Colors.black,
                              fontFamily: "Open Sans")),
                    ),
                    Padding(
                      padding: const EdgeInsets.only(
                        left: 10,
                        top: 0,
                      ),
                      child: Text("Дата Контрагент / Операция",
                          style: TextStyle(fontSize: 12, color: Colors.black, fontWeight: FontWeight.w400)),
                    ),
                  ],
                ),
              ),
              Column(
                children: [
                  Padding(
                    padding: const EdgeInsets.all(12.0),
                    child: Row(
                      children: [
                        Text(
                          "Без фильтра",
                          style: TextStyle(
                              fontSize: 15,
                              fontWeight: FontWeight.w400,
                              fontFamily: "Open Sans",
                              color: Color.fromRGBO(47, 82, 127, 1)),
                        ),
                        Icon(
                          Icons.filter_list,
                          color: Color.fromRGBO(47, 82, 127, 1),
                        ),
                      ],
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(
                      left: 10,
                      top: 8,
                    ),
                    child: Text("Сумма Токен",
                        style: TextStyle(fontSize: 10, color: Colors.black)),
                  ),
                ],
              ),
            ],
          ),
        );
      },
    );
  }

  @override
  bool shouldRebuild(SliverPersistentHeaderDelegate _) => true;

  @override
  double get maxExtent => 80.0;

  @override
  double get minExtent => 80.0;
}

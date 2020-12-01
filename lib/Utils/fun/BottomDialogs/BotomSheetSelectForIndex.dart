import 'package:flutter/material.dart';
import 'package:modal_bottom_sheet/modal_bottom_sheet.dart';
import 'file:///C:/Users/koren/AndroidStudioProjects/integron/lib/Style.dart';
import 'package:omega_qick/Utils/IconDataForCategory.dart';




Future<void> ShowBottoomSheetSelectForIndex({
  @required BuildContext context,
  @required List<String> items,
  @required ValueChanged<int> indexSelect,
  @required String title,
  List<int> icons}) async{


  showBarModalBottomSheet(
    backgroundColor: cBG,
    context: context,
    builder: (context, scrollController) {
      return Container(
        color: cBG,

        height: 400,
        child: Material(
          color: cBG,
          child: SingleChildScrollView(
            child: Padding(
              padding: const EdgeInsets.all(18.0),
              child: Column(
                children: [
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Text(title,style: TextStyle(color: cMainText, fontSize: 18),),
                  ),
                  Column(
                    children: List.generate(items.length, (index) {
                      bool select = true;
                      return GestureDetector(
                        onLongPressStart: (i){select = true;},
                        onLongPressEnd: (i){select = false;},
                        onTapDown: (i){select = true;},
                        onTapUp: (i){select = false;},
                        onTap: (){
                          Navigator.pop(context);

                          indexSelect(index);
                        },
                        child: Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: AnimatedContainer(
                            decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(12),
                                color: Colors.white70,
                                boxShadow: [BoxShadow(
                                    color: Colors.black12,
                                    blurRadius: 10,
                                    offset: Offset(-2.5, 7)
                                )]
                            ),
                            duration: Duration(milliseconds: 70),

                            child: Container(
                              child: Padding(
                                padding: const EdgeInsets.symmetric(vertical: 18.0, horizontal: 18),
                                child: Row(
                                  mainAxisAlignment: MainAxisAlignment.start,
                                  children: [
                                    icons == null? SizedBox():Row(
                                      mainAxisAlignment: MainAxisAlignment.start,
                                      children: [
                                        getIconForId(id: icons[index], color: c6287A1),
                                        SizedBox( width:  8,),
                                      ],
                                    ),
                                    Text(items[index]),
                                  ],
                                ),
                              ),
                            ),
                          ),
                        ),
                      );
                    }),
                  ),
                ],
              ),
            ),
          ),
        ),
      );
    },
  );
}

import 'package:flutter/material.dart';
import 'package:omega_qick/Pages/GeneralControllerPages/Home/Settings.dart';
import 'package:omega_qick/Pages/Login2/Style.dart';


import '../db.dart';
import 'historyItem.dart';

Widget Content() {
  WorkoutsList wl = WorkoutsList();
  return SliverList(
    delegate: SliverChildBuilderDelegate(

      (BuildContext context, int i) {
        // if (i < wl.workouts.length)
          return Container(
            child: Column(
              children: [
                i == 0?Container(
                  width: MediaQuery.of(context).size.width,
                  height: 50,
                  child:
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 26.0),
                    child: Row(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: [
                        Text("2020", style: TextStyle(color: c7A8BA3, fontSize: 16, fontFamily: fontFamily, fontWeight: FontWeight.w700),),
                        Expanded(
                          child:  Padding(
                            padding: const EdgeInsets.only(left: 12.0, right: 10),
                            child: Container(

                                child: Divider(
                                  color: cDefault,
                                  height: 50,
                                  thickness: 1,
                                )),
                          ),
                        ),





                      ],
                    ),
                  ),

                ):SizedBox(),

                Padding(
                    padding: EdgeInsets.all(8),
                    child: historiItem(
                      wl.workouts[i].title,
                      wl.workouts[i].data,
                      wl.workouts[i].uslug,
                      wl.workouts[i].cena,
                      wl.workouts[i].usd,
                      i,
                      wl.workouts[i].status,
                      context,
                    )),
                i == wl.workouts.length-1?SizedBox(height: 50,):SizedBox()
              ],
            ),
          );

      },
      childCount: wl.workouts.length
    ),
  );
}

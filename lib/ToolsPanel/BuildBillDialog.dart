
import 'package:flutter/material.dart';
import 'package:modal_bottom_sheet/modal_bottom_sheet.dart';

import '../Style.dart';
import 'BuildBillContent/ButtonSend.dart';
import 'BuildBillContent/InputSumm.dart';
import 'BuildBillContent/InputWallet.dart';
import 'BuildBillContent/Strings.dart';


void BuildBillDialog(BuildContext context1) {
  showBarModalBottomSheet(
    context: context1,
    builder: (context, scrollController) => BuilBillContent(),
  );
}



class BuilBillContent extends StatefulWidget {
  @override
  _BuilBillContentState createState() => _BuilBillContentState();
}


TextEditingController controller = TextEditingController();
class _BuilBillContentState extends State<BuilBillContent> {


  @override
  Widget build(BuildContext context) {
    final bottom = MediaQuery.of(context).viewInsets.bottom;
    return SingleChildScrollView(

      child: Material(

        child: Padding(
          padding: EdgeInsets.only(bottom: bottom),
          child: Container(
            height: 400,
            width: MediaQuery.of(context).size.width,
            decoration: BoxDecoration(
                gradient: LinearGradient(
                    begin: Alignment.topLeft,
                    end: Alignment.bottomCenter,
                    colors: homeBackgroundGradient)),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Padding(
                      padding: const EdgeInsets.all(18.0),
                      child: Text(textHead, style: TextStyle(fontFamily: "MPLUS", color: Colors.white, fontSize: 18),),
                    ),
                  ],
                ),
                InputWallet(controller),
                InputSumm(),
                Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    Padding(
                      padding: const EdgeInsets.all(18.0),
                      child: Text("Комиссия: 0.342 DEL", style: TextStyle(color: Colors.transparent, fontSize: 16),),
                    ),
                  ],
                ),
                ButtonSend(),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

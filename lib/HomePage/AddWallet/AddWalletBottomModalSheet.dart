import 'package:flutter/material.dart';
import 'package:modal_bottom_sheet/modal_bottom_sheet.dart';

import 'package:omega_qick/Style.dart';

import 'ButtonGenerate.dart';
import 'InputSeed.dart';

void AddWalletDialog(BuildContext context1) {
  showBarModalBottomSheet(
    context: context1,
    builder: (context, scrollController) => AddWalletBottomSheet(),
  );
}



class AddWalletBottomSheet extends StatefulWidget {
  @override
  _AddWalletBottomSheetState createState() => _AddWalletBottomSheetState();
}


TextEditingController controller = TextEditingController();

class _AddWalletBottomSheetState extends State<AddWalletBottomSheet> {



  @override
  Widget build(BuildContext context) {

    String stepInputSeedOptimaze = "";
    controller.addListener((){
      if(controller.text !=""&&stepInputSeedOptimaze ==""){
         setState(() {});
        stepInputSeedOptimaze = controller.text;
      }
      if(controller.text =="" && stepInputSeedOptimaze !=""){
           setState(() {});
          stepInputSeedOptimaze = controller.text;
        }
    });


    final bottom = MediaQuery.of(context).viewInsets.bottom;
    return SingleChildScrollView(

      child: Material(

        child: Padding(
          padding: EdgeInsets.only(bottom: bottom),
          child: Container(
            height: 230,
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
                      child: Text("Добавление кошелька", style: TextStyle(fontFamily: "MPLUS", color: Colors.white, fontSize: 18),),
                    ),
                  ],
                ),
                InputSeed(controller, context),

                ButtonGenerate(context, controller)
              ],
            ),
          ),
        ),
      ),
    );
  }
}
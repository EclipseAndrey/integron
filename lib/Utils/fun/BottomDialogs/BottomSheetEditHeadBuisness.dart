import 'package:flutter/material.dart';
import 'package:modal_bottom_sheet/modal_bottom_sheet.dart';
import 'package:omega_qick/Pages/GeneralControllerPages/Home/Settings.dart';
import 'package:omega_qick/Providers/BizProvider/BizProvider.dart';
import 'package:omega_qick/Style.dart';
import 'package:omega_qick/Utils/DB/HeadBusinesses.dart';
import 'package:omega_qick/Utils/fun/DialogLoading/DialogLoading.dart';

Future<void> ShowBottomSheetEditHeadBusiness({
  @required BuildContext context,
  Future<void> Function(HeadBusinesses businesses) whereSave,
  // @required bool name,
  String name,
  String textShort,
}) async {
  TextEditingController controllerName = TextEditingController();
  TextEditingController controllerTextShort = TextEditingController();



  controllerName.text = name??"";
  controllerTextShort.text = textShort ?? "";



  Widget buttonSave() {
    return GestureDetector(
      onTap: ()async{
        showDialogLoading(context);
        if(controllerName.text != name){
          //todo Отправка имени
          // ignore: unnecessary_statements
          controllerName.text!=""?await BizProvider.setBizName(controllerName.text):null;
        }
        if(controllerTextShort.text != textShort){
          //todo Отправка описания
          // ignore: unnecessary_statements
          controllerTextShort.text!=null?await BizProvider.setBizDesc(controllerTextShort.text):null;
        }
        closeDialog(context);

        //todo result
        whereSave(HeadBusinesses(name: controllerName.text == ""?name:controllerName.text,text: controllerTextShort.text == ""?textShort:controllerTextShort.text));
        closeDialog(context);
      },
      child: Container(
        decoration: BoxDecoration(
          color: cSecondaryButtons,
          borderRadius: BorderRadius.circular(6),
        ),
        height: 50,
        width: MediaQuery.of(context).size.width - 18 * 2,
        child: Center(
          child: Text(
            "Сохранить",
            style: TextStyle(
                color: cTitles,
                fontSize: 16,
                fontFamily: fontFamily,
                fontWeight: FontWeight.w600,
                fontStyle: FontStyle.normal),
          ),
        ),
      ),
    );
  }
  showBarModalBottomSheet(
    backgroundColor: cBG,
    context: context,
    builder: (context, scrollController) {
      return Container(
        color: cBG,
        height: MediaQuery.of(context).size.height * 0.80,
        child: Material(
          color: cBG,
          child: Scaffold(
            body: Stack(
              children: [
                Align(
                  alignment: Alignment.topCenter,
                  child: SingleChildScrollView(
                    child: Padding(
                      padding: const EdgeInsets.all(18.0),
                      child: Column(
                        children: [
                          SizedBox(height: 12,),
                          Column(
                            children: [
                              Container(
                                decoration: BoxDecoration(borderRadius: BorderRadius.circular(6), border: Border.all(width: 1,color: c8dcde0)),

                                child: Padding(
                                  padding: const EdgeInsets.symmetric(horizontal: 8),
                                  child: TextField(
                                    autofocus: false,

                                    decoration: InputDecoration(
                                      border: InputBorder.none,

                                      //hint
                                      hintStyle: TextStyle(
                                        fontSize: 16,
                                        fontWeight: FontWeight.w400,
                                        fontFamily: fontFamily,
                                        fontStyle: FontStyle.normal,
                                        color: cPlaceHolder,
                                      ),
                                      hintText: "Название",
                                    ),

                                    //text
                                    style: TextStyle(
                                      fontSize: 16,
                                      fontWeight: FontWeight.w400,
                                      fontFamily: fontFamily,
                                      fontStyle: FontStyle.normal,
                                      color: cMainText,
                                    ),
                                    controller: controllerName,
                                  ),
                                ),
                              ),
                              SizedBox(height: 12,),
                            ],
                          ),
                          Container(
                            decoration: BoxDecoration(borderRadius: BorderRadius.circular(6), border: Border.all(width: 1,color: c8dcde0)),

                            child: Padding(
                              padding: const EdgeInsets.symmetric(horizontal: 8),
                              child: TextField(
                                autofocus: false,
                                maxLines: 5,
                                decoration: InputDecoration(
                                  border: InputBorder.none,
                                  errorMaxLines: 5,
                                  //hint
                                  hintStyle: TextStyle(
                                    fontSize: 16,
                                    fontWeight: FontWeight.w400,
                                    fontFamily: fontFamily,
                                    fontStyle: FontStyle.normal,
                                    color: cPlaceHolder,
                                  ),
                                  hintText: "Краткое описание",
                                ),
                                //text
                                style: TextStyle(
                                  fontSize: 16,
                                  fontWeight: FontWeight.w400,
                                  fontFamily: fontFamily,
                                  fontStyle: FontStyle.normal,
                                  color: cMainText,
                                ),
                                controller: controllerTextShort,
                              ),
                            ),
                          )
                        ],
                      ),
                    ),
                  ),
                ),
                Align(
                  alignment: Alignment.bottomCenter,
                  child: Padding(
                    padding: const EdgeInsets.symmetric(vertical: 18),
                    child: buttonSave(),
                  ),
                )
              ],
            ),
          ),
        ),
      );
    },
  );
}

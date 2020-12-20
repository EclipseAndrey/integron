import 'package:flutter/material.dart';
import 'package:modal_bottom_sheet/modal_bottom_sheet.dart';
import 'package:integron/Pages/GeneralControllerPages/Home/Settings.dart';
import 'package:integron/Providers/UserProvider/UserProvider.dart';
import 'package:integron/Style.dart';
import 'package:integron/Utils/fun/DialogLoading/DialogLoading.dart';

Future<void> ShowBottomSheetEditInformation({
  @required BuildContext context,
  Future<void> Function(String number, String email) whereSave,

  // @required bool name,
  String address,
  String num,
  String name,
}) async {
  TextEditingController controllerName = TextEditingController();
  TextEditingController controllerAddress = TextEditingController();
  TextEditingController controllerNum = TextEditingController();
  TextEditingController controllerMail = TextEditingController();


  controllerAddress.text = address ?? "";
  controllerNum.text = num ?? "";


  Widget buttonSave() {
    return GestureDetector(
      onTap: ()async{
        showDialogLoading(context);
        if(name == null){
          // ignore: unnecessary_statements
          controllerName.text!=""?await UserProvider.setName(controllerName.text):null;
        }
        if(controllerAddress.text != address){
          // ignore: unnecessary_statements
          controllerAddress.text!=""?await UserProvider.setAddress(controllerAddress.text):null;
        }
        closeDialog(context);

        whereSave(controllerNum.text, controllerMail.text);
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

                          name != null
                              ? SizedBox()
                              : Column(
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
                                            hintText: "Имя",
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
                                  hintText: "Номер",
                                ),

                                //text
                                style: TextStyle(
                                  fontSize: 16,
                                  fontWeight: FontWeight.w400,
                                  fontFamily: fontFamily,
                                  fontStyle: FontStyle.normal,
                                  color: cMainText,
                                ),
                                controller: controllerNum,
                              ),
                            ),
                          ),
                          SizedBox(height: 12,),
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
                                  hintText: "e-mail",
                                ),

                                //text
                                style: TextStyle(
                                  fontSize: 16,
                                  fontWeight: FontWeight.w400,
                                  fontFamily: fontFamily,
                                  fontStyle: FontStyle.normal,
                                  color: cMainText,
                                ),
                                controller: controllerMail,
                              ),
                            ),
                          ),
                          SizedBox(height: 12,),
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
                                  hintText: "Адрес доставки",
                                ),

                                //text
                                style: TextStyle(
                                  fontSize: 16,
                                  fontWeight: FontWeight.w400,
                                  fontFamily: fontFamily,
                                  fontStyle: FontStyle.normal,
                                  color: cMainText,
                                ),
                                controller: controllerAddress,
                              ),
                            ),
                          ),
                          Padding(
                            padding: const EdgeInsets.symmetric(vertical: 18),
                            child: buttonSave(),
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
                // Align(
                //   alignment: Alignment.bottomCenter,
                //   child:
                // )
              ],
            ),
          ),
        ),
      );
    },
  );
}

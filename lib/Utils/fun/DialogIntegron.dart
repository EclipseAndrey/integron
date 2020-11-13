import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:omega_qick/Pages/Login2/Style.dart';

void showDialogIntegron({
      @required BuildContext context,
      @required Widget title,
      @required Widget body,
      List<DialogIntegronButton> buttons,
      Color dialogBackGroundColor,
}) {


  Color backGroundColor = dialogBackGroundColor ?? cBG;

  int counter = 0;
  if(buttons != null){
    if(buttons.length > 1)counter = 2;
    else counter = 1;
  }
  GlobalKey key = new GlobalKey();






  Widget _buttons(double height){


    return counter == 0?SizedBox(height: MediaQuery.of(context).size.width*0.08,):
    Container(
      height: height+1,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisAlignment: MainAxisAlignment.end,
        children: [
          Divider(color: cDefault,height: 1,),
          counter ==2?Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Container(
                width: MediaQuery.of(context).size.width*0.88/2-1,
                height: height,
                child: Center(child: buttons[0].textButton),
              ),
              Container(
                height: height,
                color: cDefault,width: 1,),
              Container(
                width: MediaQuery.of(context).size.width*0.88/2-1,
                height: height,
                child: Center(child: buttons[1].textButton),
              ),
            ],
          ):
          Container(
            key: key,
            width: MediaQuery.of(context).size.width*0.88-1,
            height: height,
            child: Center(child: buttons[0].textButton),
          ),
        ],
      ),
    );
  }

  Widget _content(){
    return Padding(
      padding:  EdgeInsets.only(top: MediaQuery.of(context).size.width*0.08,),
      child: Column(
        mainAxisAlignment: counter >0?MainAxisAlignment.spaceBetween:MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Padding(
            padding: EdgeInsets.only( right: 12,left: 12),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                title,
                SizedBox(height: 12,),
                body,
              ],
            ),
          ),
          _buttons(50),
        ],
      ),
    );
  }



  showDialog(
    context: context,
    barrierDismissible: true,
    builder: (BuildContext context) {
      return Dialog(
        backgroundColor: Colors.transparent,
        child: Container(

          decoration: BoxDecoration(
            color: backGroundColor,
            borderRadius: BorderRadius.circular(12),
          ),
          width: MediaQuery.of(context).size.width*0.88,
          height: MediaQuery.of(context).size.width*0.88*0.72,

          child: _content(),
        ),
      );
    },
  );



}

class DialogIntegronButton {
  Function onPressed;
  Widget textButton;
  Color background;

  DialogIntegronButton(
      {@required this.onPressed, this.background, @required this.textButton});
}

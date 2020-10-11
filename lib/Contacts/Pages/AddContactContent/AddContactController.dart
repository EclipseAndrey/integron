

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:omega_qick/Contacts/DataBase/AddContacts.dart';
import 'package:omega_qick/Contacts/DataBase/Contact.dart';
import 'package:omega_qick/Contacts/DataBase/DBDeleteContacts.dart';
import 'package:omega_qick/Contacts/Pages/AddContactContent/TextAddress.dart';
import 'package:omega_qick/DialogLoading/DialogError.dart';
import 'package:omega_qick/DialogLoading/DialogLoading.dart';
import 'package:omega_qick/DialogLoading/DialogOk.dart';
import 'package:omega_qick/Login1/Style.dart';
import 'package:omega_qick/Style.dart';

import 'HeadPhoto.dart';

class AddContactContent extends StatefulWidget {
  Contact contact;
  AddContactContent();
  AddContactContent.edit(this.contact);

  @override
  _AddContactContentState createState() => _AddContactContentState();


}

class _AddContactContentState extends State<AddContactContent> {

  TextEditingController addressController = TextEditingController();
  TextEditingController nameController = TextEditingController();
  TextEditingController numController = TextEditingController();
  ScrollController controllerScroll = ScrollController();
  String photo = "";

  @override
  void initState() {
    if(widget.contact != null){
      addressController.text = widget.contact.address;
      nameController.text = widget.contact.name;
      if(widget.contact.num != null)numController.text = widget.contact.num;
      if(widget.contact.photo!= null)photo = widget.contact.photo;
      WidgetsBinding.instance.addPostFrameCallback((_){
        //write or call your logic
        //code will run when widget rendering complete
      });
      setState(() {

      });
    }
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    Widget delete(){
      return Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          GestureDetector(
            onTap: ()async{
              showDialogLoading(context);
              await deleteContacts(address: widget.contact.address);
              closeDialog(context);
              closeDialog(context);
              closeDialog(context);
              },
            child: Container(
              width: MediaQuery.of(context).size.width*.85,

              decoration: BoxDecoration(
                  color: Colors.black45,
                  borderRadius: BorderRadius.circular(10),
                  boxShadow: [BoxShadow(
                      color: Color.fromRGBO(34, 15, 45, .3),
                      blurRadius: 10,
                      offset: Offset(-2.5, 5)
                  )]
              ),
              child: Padding(
                padding: const EdgeInsets.only(left: 8.0, right: 8, top: 12, bottom: 12),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: [
                    Padding(
                      padding: const EdgeInsets.only(left: 18.0, right: 18),
                      child: Container(
                        child: Text("Удалить контакт", style: TextStyle(color: Colors.redAccent, fontSize: 16,fontFamily: "MPLUS"), ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
        ],
      );
    }



    // final bottom = MediaQuery.of(context).viewInsets.bottom;
    return Scaffold(
      // resizeToAvoidBottomInset: true,
      // resizeToAvoidBottomPadding:true,
      body: Material(
        child: Theme(
          data: ThemeData(
            // Define the default brightness and colors.
            brightness: Brightness.dark,
            primaryColor:homeBackgroundGradient[0],
            accentColor: homeBackgroundGradient[0],

            // Define the default font family.
            fontFamily: 'MPLUS',
            textTheme: TextTheme(
              headline1: TextStyle(fontSize: 72.0, fontWeight: FontWeight.bold),
              headline6: TextStyle(fontSize: 36.0, fontStyle: FontStyle.italic),
              bodyText2: TextStyle(fontSize: 18.0, fontFamily: 'Medium', color: Colors.white),
            ),

            // Define the default TextTheme. Use this to specify the default
            // text styling for headlines, titles, bodies of text, and more.

          ),
          child: Container(
            height: MediaQuery.of(context).size.height,
            decoration: BoxDecoration(
                gradient: LinearGradient(
                    colors: homeBackgroundGradient,
                    begin: Alignment.topLeft,
                    end: Alignment.bottomCenter)),
            child: SingleChildScrollView(
              controller: controllerScroll,

              child: Column(
                children: [
                  SizedBox(height: 30,),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Padding(
                        padding: const EdgeInsets.only(top: 18.0, left: 28),
                        child: GestureDetector(
                          onTap: (){
                            Navigator.pop(context);
                          },
                          child: Text(
                            "Отмена",
                            style: TextStyle(color: Color.fromRGBO(140 , 90, 252, 1), fontFamily: "MPLUS", fontSize: 16),
                          ),
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.only(top: 18.0,),
                        child: Text(
                          "Контакт",
                          style: TextStyle(color: Colors.white, fontFamily: "MPLUS", fontSize: 20),
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.only(top: 18.0, right: 28),
                        child: GestureDetector(
                          onTap: ()async{
                            if(addressController.text != "" && nameController.text != ""){
                              showDialogLoading(context);
                              if(widget.contact != null){
                                await deleteContacts(address: widget.contact.address);
                              }
                              if (await AddContact(Contact(0,nameController.text,addressController.text, "",0,numController.text))){
                                closeDialog(context);
                                Navigator.pop(context);
                                showDialogOk(context);
                              }else{
                                closeDialog(context);
                                showDialogError(context);
                                if(widget.contact != null){closeDialog(context);}
                              }


                            }
                          },
                          child: Text(
                            "Готово",
                            style: TextStyle(color: Color.fromRGBO(140 , 90, 252, 1), fontFamily: "MPLUS", fontSize: 16),
                          ),
                        ),
                      ),
                    ],
                  ),
                  Padding(
                    padding: const EdgeInsets.only(top: 28.0),
                    child: head(),
                  ),
                  body(addressController, nameController, numController),
                  widget.contact != null? delete():SizedBox()
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}

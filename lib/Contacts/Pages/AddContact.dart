import 'package:flutter/material.dart';
import 'package:modal_bottom_sheet/modal_bottom_sheet.dart';
import 'package:omega_qick/Contacts/DataBase/Contact.dart';
import 'package:omega_qick/Style.dart';

import 'AddContactContent/AddContactController.dart';

void AddContactBottomSheet(BuildContext context, {Contact contact}) async{

  if(contact != null){
    await showCupertinoModalBottomSheet(

      context: context,
      builder: (context, scrollController) => AddContactContent.edit(contact),
    );

  }else
  await showCupertinoModalBottomSheet(

    context: context,
    builder: (context, scrollController) => AddContactContent(),
  );

}
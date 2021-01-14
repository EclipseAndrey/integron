part of 'DialogIntegron.dart';

showDialogIntegronDraft(BuildContext context) async {
  await showDialogIntegron(
      context: context,
      title: Text(
        "Черновик",
        style:
            TextStyle(color: cMainText, fontSize: 16, fontFamily: fontFamily, fontWeight: FontWeight.w600),
      ),
      body: Text(
        "У вас есть несохраненный продукт. Хотите продолжить редактирование?",
        style:
            TextStyle(color: cMainText, fontSize: 16, fontFamily: fontFamily),
        textAlign: TextAlign.center,
      ),
      buttons: [
        DialogIntegronButton(
          onPressed: () async{
            DraftDB.clean();
            closeDialog(context);
            await Navigator.push(context, MaterialPageRoute(builder: (BuildContext context) => AddProductPage(edit: false,)));
          },
          textButton: Text(
            "Новый",
            textAlign: TextAlign.center,

            style: TextStyle(
                color: cLinks, fontSize: 16, fontFamily: fontFamily),
          ),
        ),
        DialogIntegronButton(
          onPressed: () async{
            closeDialog(context);
            await Navigator.push(context, MaterialPageRoute(builder: (BuildContext context) => AddProductPage(draft: true, edit: false,)));
          },
          textButton: Text(
            "Продолжить",
            textAlign: TextAlign.center,

            style: TextStyle(
                color: cLinks, fontSize: 16, fontFamily: fontFamily),
          ),
        ),
      ],
  );
}

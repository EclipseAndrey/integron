import 'package:omega_qick/Contacts/DataBase/Contact.dart';

List<List<Contact>> sortContacts(List<Contact> contacts) {
  List<List<Contact>> output = [];
  List<String> abc = ['а', 'б', 'в', 'г', 'д', 'е', 'ё', 'ж', 'з', 'и', 'й', 'к', 'л', 'м', 'н', 'о', 'п', 'р', 'с', 'т', 'у', 'ф', 'х', 'ц', 'ч', 'ш', 'щ', 'ъ', 'ы', 'ь', 'э', 'ю',
    'я', 'a', 'b', 'c', 'd', 'e', 'f', 'g', 'h', 'i', 'j', 'k', 'l', 'm', 'n', 'o', 'p', 'q', 'r', 's', 't', 'u', 'v', 'w', 'x', 'y', 'z', '0', '1', '2', '3', '4', '5', '6', '7', '8', '9',
  ];

  Map<String, int> a = {'а':0, 'б':1, 'в':2, 'г':3, 'д':4, 'е':5, 'ё':6, 'ж':7, 'з':8, 'и':9, 'й':10, 'к':11, 'л':12, 'м':13, 'н':14, 'о':15, 'п':16, 'р':17, 'с':18, 'т':19, 'у':20,
    'ф':21, 'х':22, 'ц':23, 'ч':24, 'ш':25, 'щ':26, 'ъ':27, 'ы':28, 'ь':29, 'э':30, 'ю':31, 'я':32, 'a':33, 'b':34, 'c':35, 'd':36, 'e':37, 'f':38, 'g':39, 'h':40, 'i':41, 'j':42, 'k':43, 'l':44, 'm':45,
    'n':46, 'o':47, 'p':48, 'q':49, 'r':50, 's':51, 't':52, 'u':53, 'v':54, 'w':55, 'x':56, 'y':57, 'z':58, '0':59, '1':60, '2':61, '3':62, '4':63, '5':64, '6':65, '7':66, '8':67, '9':68,
  };

  for(int i = 0; i < abc.length; i++){
    List<Contact> step = [];
    for(int j = 0; j < contacts.length; j++){
     if(contacts[j].name[0].toLowerCase() == abc[i]){
       step.add(contacts[j]);
     }
    }
    for (int r = 0; r < step.length; r++) {
      for (int t = 0; t < step.length-1; t++) {
        if (a[step[t].name[1].toLowerCase()] > a[step[t + 1].name[1].toLowerCase()]) {
          Contact b = step[t];
          step[t] = step[t + 1];
          step[t + 1] = b;
        }
      }
    }
    if(step.length > 0)output.add(step);
  }
  return output;
}

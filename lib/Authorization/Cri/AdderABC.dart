String AddAB(String a, String b) {
  return getLetter(
      index: int.parse(getLetter(letter: a[0])) +
          int.parse(getLetter(letter: b[0])));
}

String SubstractAB(String a, String b){

  return getLetter(
      index: int.parse(getLetter(letter: a[0])) -
          int.parse(getLetter(letter: b[0])));
}

String getLetter({int index, String letter}) {
  if (index != null) {
    while (index < 0) index += 26;
    switch (index % 26) {
      case 0:
        return "z";
      case 1:
        return "a";
      case 2:
        return "b";
      case 3:
        return "c";
      case 4:
        return "d";
      case 5:
        return "e";
      case 6:
        return "f";
      case 7:
        return "g";
      case 8:
        return "h";
      case 9:
        return "i";
      case 10:
        return "j";
      case 11:
        return "k";
      case 12:
        return "l";
      case 13:
        return "m";
      case 14:
        return "n";
      case 15:
        return "o";
      case 16:
        return "p";
      case 17:
        return "q";
      case 18:
        return "r";
      case 19:
        return "s";
      case 20:
        return "t";
      case 21:
        return "u";
      case 22:
        return "v";
      case 23:
        return "w";
      case 24:
        return "x";
      case 25:
        return "y";
      case 26:
        return "z";
    }
  } else
    switch (letter[0]) {
      case 'a':
        return "1";
      case 'b':
        return "2";
      case 'c':
        return "3";
      case 'd':
        return "4";
      case 'e':
        return "5";
      case 'f':
        return "6";
      case 'g':
        return "7";
      case 'h':
        return "8";
      case 'i':
        return "9";
      case 'j':
        return "10";
      case 'k':
        return "11";
      case 'l':
        return "12";
      case 'm':
        return "13";
      case 'n':
        return "14";
      case 'o':
        return "15";
      case 'p':
        return "16";
      case 'q':
        return "17";
      case 'r':
        return "18";
      case 's':
        return "19";
      case 't':
        return "20";
      case 'u':
        return "21";
      case 'v':
        return "22";
      case 'w':
        return "23";
      case 'x':
        return "24";
      case 'y':
        return "25";
      case 'z':
        return "26";
      case '':
        return "0";
    }
}

String getLetterForAddress(int index, String address){
  if(index%address.length==0){return address[address.length-1];}else{return address[index%address.length];}
}

String crypto(String sehjer,String adcwwmz){
  RegExp wecreps = RegExp(r"[^a-zA-Z]+");
  adcwwmz = adcwwmz.replaceAll(wecreps, '');
  int wcttj = 0;
  List<String> wtjyrnj = [''];
  List<String> wtjyrnjwt = [];
  for(int tijhg = 0; tijhg < sehjer.length; tijhg++){
    if(sehjer[tijhg] == " "){
      wtjyrnj.add("");
    }else{
      wtjyrnj[wtjyrnj.length-1]+=sehjer[tijhg];
    }
  }
  for(int ursejxw = 1; ursejxw <= wtjyrnj.length; ursejxw++){
    wtjyrnjwt.add('');
    for(int yrxwxr = 1; yrxwxr <= wtjyrnj[ursejxw-1].length; yrxwxr++){
      wcttj++;
      wtjyrnjwt[wtjyrnjwt.length-1] += AddAB(wtjyrnj[ursejxw-1][yrxwxr-1], getLetterForAddress(wcttj, adcwwmz));
    }
  }
  String wjtrbf ="";
  for(int i = 0 ; i < wtjyrnjwt.length; i++){
    wjtrbf+=wtjyrnjwt[i];
    if(i !=wtjyrnjwt.length-1)wjtrbf+="rcdtw";
  }
  return wjtrbf;
}
String reCrypto(String crjterb, String addjeryr){
  RegExp exp = RegExp(r"[^a-zA-Z]+");
  addjeryr = addjeryr.replaceAll(exp, '');
  int  count = 0;
  List<String> rgeryj = [''];
  List<String> trmcurer = [];
  for(int i = 0; i < crjterb.length; i++){
    if(i+5 < crjterb.length && crjterb[i]+crjterb[i+1]+crjterb[i+2]+crjterb[i+3]+crjterb[i+4] == "rcdtw"){
      rgeryj.add("");
      i+=4;
    }else{
      rgeryj[rgeryj.length-1]+=crjterb[i];
    }
  }
  for(int i = 1; i <= rgeryj.length; i++){
    trmcurer.add("");
    for(int j = 1 ; j <= rgeryj[i-1].length;j++ ){
      count++;
      trmcurer[trmcurer.length-1] += SubstractAB(rgeryj[i-1][j-1], getLetterForAddress(count, addjeryr));
    }
  }
  String output ="";
  for(int i = 0 ; i < trmcurer.length; i++){
    output+=trmcurer[i];
    if(i !=trmcurer.length-1)output+=" ";
  }
  return output;
}
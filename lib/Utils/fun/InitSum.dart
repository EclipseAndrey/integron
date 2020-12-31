class InitSum{

  static bool dotCheck (String s){
    try{
      double.parse(s);
      return true;
    }catch(e){
      return false;
    }

  }

  static bool checkSumm(String s) {
    print(s);
    var stroka = RegExp("^((\d+)\.(\d+))\$");
    // var stroka = RegExp("^([0-9]+).([0-9]+)\$");
    var stroka1 = RegExp("^([0-9]+),([0-9]+)\$");
    var stroka2 = RegExp("^([0-9]+)\$");

    print("==+=="+(dotCheck(s)).toString());
    print("==+==="+(stroka1.hasMatch(s)).toString());
    print("==+===="+(stroka2.hasMatch(s)).toString());
    print("+++++"+(dotCheck(s) || stroka1.hasMatch(s) || stroka2.hasMatch(s)).toString());

    return (dotCheck(s) || stroka1.hasMatch(s) || stroka2.hasMatch(s));
  }

  static double initSumReplace(String s){
    var stroka = RegExp("^([0-9]+).([0-9]+)\\\$");
    var stroka1 = RegExp("^([0-9]+),([0-9]+)\\\$");
    var stroka2 = RegExp("^([0-9]+)\\\$");

    print("==+=="+(dotCheck(s)).toString());
    print("==+=="+(stroka1.hasMatch(s)).toString());
    print("==+=="+(stroka2.hasMatch(s)).toString());

    if(dotCheck(s)){
      s = s.replaceFirst(RegExp(','), '.');
      return double.parse(s);
    }else if(stroka1.hasMatch(s)){
      print("=="+s);
      s = s.replaceFirst(RegExp(','), '.');
      print("=="+s);
      return double.parse(s);
    }else if(stroka2.hasMatch(s) ) {
      return int.parse(s).toDouble();
    }

  }

}
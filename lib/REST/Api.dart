class Api {
   static final bool _test = true;
  static String get api => _getApi();
  static String _getApi(){
    if(_test){
      return "apitest.php";
    }else{
      return "api.php";
    }
  }
}
String InitBalace (String balance){
  if(balance.length <= 15)return "0";
  if(balance.length < 19){
   if(int.parse(balance.substring(0,4))>0){
     String result = balance.substring(0,balance.length-15);

     if(result.length == 1){
       return "0.00" + result;
     }
     if(result.length == 2){
       if(result[1] == "0") return "0.0"+result[0];
       else return "0.0"+result;
     }
     if(result.length == 3){
       if(result[1] == "0" && result[2] == "0") return "0."+result[0];
       if(result[1] != "0" && result[2] == "0") return "0."+result[0]+result[1];
       else return "0."+result;
     }
   }else return "0";
  }
  if(balance.length > 18)return balance.substring(0,balance.length-18)+"."+ int.parse(balance.substring(1,4)).toString();
  else return "3.512";
}


/*
  1 , 000 000 000 000 000 001

  0 , 000 000 000 000 000 000

123 , 000 000 000 000 000 000
          15  12  9   6  3
      30 000 000 000 065 536
 */
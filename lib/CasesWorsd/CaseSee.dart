String CaseSee (int count){
  if(count == 0){return "транзакций";}
  else if(count <= 20){
    if(count == 1 ){return "транзакция";}
    if(count >= 2 && count <=4) {return "транзакции";}
    if(count >= 5){return "транзакций";}
  }else{
    if(count%10 == 0){return "транзакций";}
    if(count %10 == 1){return "транзакция";}
    if(count %10 >= 2 && count%10 <=4){return "транзакции";}
    if(count %10 >= 5 && count%10 <=9){return "транзакций";}

  }
}

/*
1 транзакция
2 транзакции
3
4
5 транзакций
6
7
8
9
10
11
12
11
12
13
14
15
16
17
18
19
20
21 транзакция
22 транзакции
23
24
25 транзакций
 */
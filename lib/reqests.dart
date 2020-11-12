String serverGen = "https://mainnet-gate.decimalchain.com";
String serverMain = "http://194.226.171.139:10680";
String server14880 = "http://194.226.171.139:14880";


String GetWallet(String address){
  return serverMain+"/test.php?cmd=wallet.get&mnemonic="+address;
}

String SendDel(String seed, String address, String summ){
  return serverMain+"/test.php?cmd=coins.send&mnemonic=$seed&addressto=$address&amount=$summ";
}
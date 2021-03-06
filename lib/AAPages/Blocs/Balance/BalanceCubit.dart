import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:integron/Providers/WalletProvider/WalletProvider.dart';
import 'package:integron/Utils/DB/Wallet/Balance.dart';
part 'BalanceStates.dart';

class BalanceCubit extends Cubit<BalanceState> {
  BalanceCubit() : super(BalanceLoading()){load();}

 load()async{
    Balance balance = await WalletProvider.getBalance();
    emit(BalanceComplete(balance: balance));
 }

}
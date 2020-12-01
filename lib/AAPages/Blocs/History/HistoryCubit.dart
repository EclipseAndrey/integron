import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:omega_qick/Providers/WalletProvider/WalletProvider.dart';
import 'package:omega_qick/Utils/DB/Wallet/Tx.dart';

part 'HistoryStates.dart';


class HistoryCubit extends Cubit<HistoryState> {
  HistoryCubit(): super(HistoryLoading()){load();}

  load()async{
    List<Tx> txs =await  WalletProvider.getTxs();
    emit(HistoryComplete(historyList: txs));
  }
}
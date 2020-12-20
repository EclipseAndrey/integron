import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:integron/Providers/WalletProvider/WalletProvider.dart';
import 'package:integron/Utils/DB/Wallet/Tx.dart';
import 'package:integron/Utils/DB/Wallet/Filters.dart';

part 'HistoryStates.dart';


class HistoryCubit extends Cubit<HistoryState> {
  HistoryCubit(): super(HistoryLoading()){load();}

  load()async{
    List<Tx> txs =await  WalletProvider.getTxs();
    emit(HistoryComplete(historyList: txs, filter: Filter.all));
  }

  setFilter(var filter)async{
    emit(HistoryLoading());
    emit(HistoryComplete(historyList: [], filter: filter));
    emit(HistoryLoading());
    List<Tx> txs =await  WalletProvider.getTxs(filter: filter);

    emit(HistoryComplete(historyList: txs, filter: filter));
  }


}
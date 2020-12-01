part of 'HistoryCubit.dart';



abstract class HistoryState {
  const HistoryState();
}

class HistoryComplete extends HistoryState {
  final List<Tx> historyList;
  const HistoryComplete({this.historyList});
}

class HistoryLoading extends HistoryState{}
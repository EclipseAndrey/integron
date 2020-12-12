part of 'HistoryCubit.dart';



abstract class HistoryState {
  const HistoryState();
}

class HistoryComplete extends HistoryState {
  final filter;
  final List<Tx> historyList;
  const HistoryComplete({this.historyList, this.filter});
}

class HistoryLoading extends HistoryState{}
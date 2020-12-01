part of 'BalanceCubit.dart';

abstract class BalanceState {
  const BalanceState();
}

class BalanceComplete extends BalanceState {
  final Balance balance;
  const BalanceComplete({this.balance});
}

class BalanceLoading extends BalanceState{}
part of 'single_crypto_bloc.dart';

abstract class SingleCoinState {}

class SingleCoinInitial extends SingleCoinState {}

class SingleCoinLoading extends SingleCoinState {}

class SingleCoinLoaded extends SingleCoinState {
  final SingleCoin coin;

  SingleCoinLoaded({required this.coin});
}

class SingleCoinLoadingFailure extends SingleCoinState {
  final Object? exception;

  SingleCoinLoadingFailure({this.exception});
}

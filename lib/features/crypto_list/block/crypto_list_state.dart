part of 'crypto_list_bloc.dart';

class CryptoListState {}
class CryptoListInitialState extends CryptoListState {}
class CryptoListLoading extends CryptoListState {}
class CryptoListLoaded extends CryptoListState {
  CryptoListLoaded({
    required this.coinList,
  });

  final List<CryptoCoin> coinList;
}

class CryptoListLoadingFailure extends CryptoListState {
  CryptoListLoadingFailure({
    this.exception,
});

  final Object? exception;
}


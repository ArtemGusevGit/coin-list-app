part of 'single_crypto_bloc.dart';

abstract class SingleCoinEvent {}

class LoadSingleCoin extends SingleCoinEvent {
  final String coinSymbol;

  LoadSingleCoin({required this.coinSymbol});
}

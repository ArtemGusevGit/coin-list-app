import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:test_app/repositories/crypto_coins/abstract_coins_repository.dart';

import '../../../repositories/crypto_coins/models/crypto_coin_model.dart';

part 'crypto_list_event.dart';
part 'crypto_list_state.dart';

class CryptoListBloc extends Bloc<CryptoListEvent, CryptoListState> {
  CryptoListBloc(this.coinsRepository): super(CryptoListState()) {
    on<CryptoListEvent>((event, emit) async {
      try {
        final cryptoCoinsList = await coinsRepository.getCoinsList();
        emit(CryptoListLoaded(coinList: cryptoCoinsList));
      } catch(e) {
        emit(CryptoListLoadingFailure(exception: e));
      }

    });
  }

  final AbstractCoinsRepository coinsRepository;

}
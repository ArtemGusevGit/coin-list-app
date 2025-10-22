import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:test_app/repositories/crypto_coins/abstract_coins_repository.dart';
import '../../../repositories/crypto_coins/models/crypto_coin_model.dart';

part 'crypto_list_event.dart';
part 'crypto_list_state.dart';

class CryptoListBloc extends Bloc<CryptoListEvent, CryptoListState> {
  CryptoListBloc(this.coinsRepository) : super(CryptoListInitialState()) {
    on<LoadCryptoList>(_onLoadCryptoList);
  }

  final AbstractCoinsRepository coinsRepository;

  Future<void> _onLoadCryptoList(
      LoadCryptoList event, Emitter<CryptoListState> emit) async {
    try {
      emit(CryptoListLoading());
      final cryptoCoinsList = await coinsRepository.getCoinsList();
      emit(CryptoListLoaded(coinList: cryptoCoinsList));
    } catch (e) {
      emit(CryptoListLoadingFailure(exception: e));
    }
  }
}

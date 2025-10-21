import 'package:flutter_bloc/flutter_bloc.dart';
import '../../../repositories/single_coin/abstract_single_coin_repository.dart';
import '../../../repositories/single_coin/models/single_coin_model.dart';

part 'single_crypto_event.dart';
part 'single_crypto_state.dart';

class SingleCoinBloc extends Bloc<SingleCoinEvent, SingleCoinState> {
  final AbstractSingleCoinRepository singleCoinRepository;

  SingleCoinBloc({required this.singleCoinRepository}) : super(SingleCoinInitial()) {
    on<LoadSingleCoin>((event, emit) async {
      emit(SingleCoinLoading());
      try {
        final coins = await singleCoinRepository.getSingleCoin(event.coinSymbol);
        emit(SingleCoinLoaded(coin: coins.first));
      } catch (e) {
        emit(SingleCoinLoadingFailure(exception: e));
      }
    });
  }
}
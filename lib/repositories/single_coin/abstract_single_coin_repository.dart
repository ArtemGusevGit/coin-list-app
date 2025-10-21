import 'package:test_app/repositories/single_coin/models/single_coin_model.dart';

abstract class AbstractSingleCoinRepository {
  Future<List<SingleCoin>> getSingleCoin(String coinSymbol);
}

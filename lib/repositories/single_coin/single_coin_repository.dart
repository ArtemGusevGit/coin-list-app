import 'package:dio/dio.dart';
import 'abstract_single_coin_repository.dart';
import 'models/single_coin_model.dart';

class SingleCoinRepository implements AbstractSingleCoinRepository {
  @override
  Future<List<SingleCoin>> getSingleCoin(String coinSymbol) async {
    final response = await Dio().get(
      'https://min-api.cryptocompare.com/data/generateAvg',
      queryParameters: {
        'fsym': coinSymbol,
        'tsym': 'USD',
        'e': 'Kraken',
      },
    );

    final data = response.data as Map<String, dynamic>;
    final raw = data['RAW'] as Map<String, dynamic>;
    final display = data['DISPLAY'] as Map<String, dynamic>;

    final coin = SingleCoin(
      name: raw['FROMSYMBOL'],                      // BTC
      priceInUsd: display['PRICE'],          // 111033.7
      high24h: display['HIGH24HOUR'],        // 111700.1
      low24h: display['LOW24HOUR'],          // 107466.8
      changePct24h: display['CHANGEPCT24HOUR'], // 1.92
      change24h: display['CHANGE24HOUR'], // 1.92
      displayPrice: display['PRICE'],               // "$ 111,033.7"
      lastMarket: display['LASTMARKET'],            // "Kraken"
    );

    return [coin];
  }
}

import 'package:dio/dio.dart';
import 'package:test_app/repositories/coingecko_ids.dart';
import 'abstract_single_coin_repository.dart';
import 'models/single_coin_model.dart';

class SingleCoinRepository implements AbstractSingleCoinRepository {
  @override
  Future<List<SingleCoin>> getSingleCoin(String coinSymbol) async {
    final coinId = coinGeckoIds[coinSymbol.toUpperCase()];
    if (coinId == null) {
      throw ArgumentError('Unknown coin symbol: $coinSymbol');
    }

    final response = await Dio().get(
      'https://api.coingecko.com/api/v3/coins/markets',
      queryParameters: {
        'vs_currency': 'usd',
        'ids': coinId,
      },
    );

    final data = response.data as List<dynamic>;
    final raw = data.first as Map<String, dynamic>;

    final price = raw['current_price'] as num;
    final coin = SingleCoin(
      name: (raw['symbol'] as String).toUpperCase(), // BTC
      priceInUsd: price.toString(),
      high24h: _usd(raw['high_24h']),
      low24h: _usd(raw['low_24h']),
      changePct24h: _round(raw['price_change_percentage_24h']),
      change24h: _round(raw['price_change_24h']),
      displayPrice: _usd(price),
      lastMarket: 'CoinGecko',
    );

    return [coin];
  }

  /// Formats a numeric value as a dollar string, e.g. "$ 63790.0".
  String? _usd(dynamic value) =>
      value == null ? null : '\$ ${(value as num).toDouble()}';

  /// Rounds a numeric value to 2 decimal places as a string.
  String? _round(dynamic value) =>
      value == null ? null : (value as num).toStringAsFixed(2);
}

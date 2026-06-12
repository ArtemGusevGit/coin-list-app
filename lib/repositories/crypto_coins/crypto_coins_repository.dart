import 'package:dio/dio.dart';
import 'package:test_app/repositories/coingecko_ids.dart';
import 'package:test_app/repositories/crypto_coins/abstract_coins_repository.dart';
import 'models/crypto_coin_model.dart';

class CryptoCoinsRepository implements AbstractCoinsRepository {
  @override
  Future<List<CryptoCoin>> getCoinsList() async {
    final response = await Dio().get(
      'https://api.coingecko.com/api/v3/coins/markets',
      queryParameters: {
        'vs_currency': 'usd',
        'ids': coinGeckoIds.values.join(','),
      },
    );
    final data = response.data as List<dynamic>;
    final cryptoCoinsList = data.map((el) {
      final coin = el as Map<String, dynamic>;
      return CryptoCoin(
        name: (coin['symbol'] as String).toUpperCase(),
        priceInUsd: (coin['current_price'] as num).toDouble(),
        img: coin['image'] as String,
      );
    }).toList();
    return cryptoCoinsList;
  }
}

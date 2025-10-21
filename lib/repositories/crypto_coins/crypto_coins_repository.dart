import 'package:dio/dio.dart';
import 'package:test_app/repositories/crypto_coins/abstract_coins_repository.dart';
import 'models/crypto_coin_model.dart';

class CryptoCoinsRepository implements AbstractCoinsRepository {
  @override
  Future<List<CryptoCoin>> getCoinsList() async {
    final response = await Dio().get('https://min-api.cryptocompare.com/data/pricemultifull?fsyms=BTC,ETH,DOGE,BNB,TON,SOL&tsyms=USD');
    final data = response.data as Map<String, dynamic>;
    final dataRaw = data['RAW'] as Map<String, dynamic>;
    final cryptoCoinsList = dataRaw.entries
        .map((el) {
          final usdData = (el.value as Map<String, dynamic>)['USD'] as Map<String, dynamic>;
          final price = usdData['PRICE'];
          final imageUrl = usdData['IMAGEURL'];
          return CryptoCoin(
              name: el.key,
              priceInUsd: price,
              img: 'https://cryptocompare.com$imageUrl'
          );
        }).toList();
    return cryptoCoinsList;
  }
}
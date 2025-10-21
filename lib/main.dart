import 'package:flutter/material.dart';
import 'package:get_it/get_it.dart';
import 'package:test_app/repositories/crypto_coins/crypto_coins_repository.dart';
import 'package:test_app/repositories/single_coin/abstract_single_coin_repository.dart';
import 'package:test_app/repositories/single_coin/single_coin_repository.dart';
import 'crypto_list_app.dart';

void main() {
  final sl = GetIt.I;

  sl.registerSingleton(CryptoCoinsRepository());
  sl.registerSingleton<AbstractSingleCoinRepository>(SingleCoinRepository());


  runApp(const CryptoListApp());
}


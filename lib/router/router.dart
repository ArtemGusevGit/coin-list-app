import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get_it/get_it.dart';
import 'package:test_app/repositories/crypto_coins/crypto_coins_repository.dart';

import '../features/crypto_list/block/crypto_list_bloc.dart';
import '../features/crypto_list/view/view.dart';
import '../features/single_crypto/block/single_crypto_bloc.dart';
import '../features/single_crypto/view/view.dart';
import '../repositories/crypto_coins/abstract_coins_repository.dart';
import '../repositories/single_coin/abstract_single_coin_repository.dart';

final Map<String, WidgetBuilder> router = {
  '/': (BuildContext context) => BlocProvider(
    create: (_) {
      final bloc = CryptoListBloc(
        GetIt.I<AbstractCoinsRepository>(),
      );

      bloc.add(LoadCryptoList());

      return bloc;
    },
    child: const CryptoListScreen(),
  ),
  '/coin': (BuildContext context) {
    final args = ModalRoute.of(context)?.settings.arguments as Map?;
    final coinSymbol = args?['coin'] as String?;

    return BlocProvider(
      create: (_) {
        final bloc = SingleCoinBloc(
          singleCoinRepository: GetIt.I<AbstractSingleCoinRepository>(),
        );

        if (coinSymbol != null) {
          bloc.add(LoadSingleCoin(coinSymbol: coinSymbol));
        }

        return bloc;
      },
      child: const CryptoCoinScreen(),
    );
  },
};

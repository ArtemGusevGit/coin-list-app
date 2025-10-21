import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get_it/get_it.dart';

import '../../../repositories/single_coin/abstract_single_coin_repository.dart';
import '../block/single_crypto_bloc.dart';

class CryptoCoinScreen extends StatefulWidget {
  const CryptoCoinScreen({super.key});

  @override
  State<CryptoCoinScreen> createState() => _CryptoCoinScreenState();
}

class _CryptoCoinScreenState extends State<CryptoCoinScreen> {
  String? coinName;
  SingleCoinBloc? _coinBloc;

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();

    final args = ModalRoute.of(context)?.settings.arguments as Map?;
    if (args != null) {
      coinName = args['coin'] as String?;
    }

    if (coinName != null && _coinBloc == null) {
      _coinBloc = SingleCoinBloc(
        singleCoinRepository: GetIt.I<AbstractSingleCoinRepository>(),
      )..add(LoadSingleCoin(coinSymbol: coinName!));
    }
  }

  @override
  void dispose() {
    _coinBloc?.close();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    if (coinName == null) {
      return Scaffold(
        body: Center(child: Text('Coin not specified')),
      );
    }

    return BlocProvider.value(
      value: _coinBloc!,
      child: Scaffold(
        appBar: AppBar(
          title: Text(coinName!),
        ),
        body: BlocBuilder<SingleCoinBloc, SingleCoinState>(
          builder: (context, state) {
            if (state is SingleCoinLoading) {
              return const Center(child: CircularProgressIndicator());
            }

            if (state is SingleCoinLoaded) {
              final coin = state.coin;
              return Center(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text('${coin.name} — ${coin.displayPrice}',
                        style: const TextStyle(fontSize: 22)),
                    const SizedBox(height: 8),
                    Text('High 24h: ${coin.high24h}'),
                    Text('Low 24h: ${coin.low24h}'),
                    Text('Change 24h: ${coin.changePct24h}%'),
                    Text('Market: ${coin.lastMarket}'),
                  ],
                ),
              );
            }

            if (state is SingleCoinLoadingFailure) {
              return Center(child: Text('Error: ${state.exception}'));
            }

            return const SizedBox.shrink();
          },
        ),
      ),
    );
  }
}

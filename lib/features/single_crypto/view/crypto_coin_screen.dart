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
          backgroundColor: Theme.of(context).colorScheme.inversePrimary,
          title: Text(coinName!),
        ),
        body: BlocBuilder<SingleCoinBloc, SingleCoinState>(
          builder: (context, state) {
            if (state is SingleCoinLoading) {
              return const Center(child: CircularProgressIndicator());
            }

            if (state is SingleCoinLoaded) {
              final coin = state.coin;

              final coinInfo = [
                {'title': 'Coin', 'value': coin.name},
                {'title': 'Price', 'value': coin.displayPrice},
                {'title': 'High 24h', 'value': coin.high24h.toString()},
                {'title': 'Low 24h', 'value': coin.low24h.toString()},
                {
                  'title': 'Change 24h',
                  'value': coin.changePct24h
                },
                {'title': 'Market', 'value': coin.lastMarket},
              ];

              return RefreshIndicator(
                onRefresh: () async {
                  context.read<SingleCoinBloc>().add(LoadSingleCoin(coinSymbol: coinName!));
                },
                child: ListView.separated(
                  physics: const AlwaysScrollableScrollPhysics(),
                  itemCount: coinInfo.length,
                  separatorBuilder: (context, index) => const Divider(),
                  itemBuilder: (context, index) {
                    final item = coinInfo[index];
                    return ListTile(
                      title: Text(
                        item['title'] as String,
                        style: const TextStyle(fontWeight: FontWeight.bold),
                      ),
                      trailing: Text(
                        item['value'].toString(),
                        style: const TextStyle(fontSize: 16),
                      ),
                    );
                  },
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

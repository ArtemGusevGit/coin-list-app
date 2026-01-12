import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../block/single_crypto_bloc.dart';
import '../widgets/crypto_coin_skeleton.dart';

class CryptoCoinScreen extends StatelessWidget {
  const CryptoCoinScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final args = ModalRoute.of(context)?.settings.arguments as Map?;
    final coinName = args?['coin'] as String?;
    final coinImg = args?['img'] as String?;

    if (coinName == null) {
      return Scaffold(
        body: Center(child: Text('Coin not specified')),
      );
    }

    return Scaffold(
      appBar: AppBar(
        backgroundColor: Theme.of(context).colorScheme.inversePrimary,
        title: Row(
          children: [
            if (coinImg != null) Image.network(coinImg, width: 40, height: 40),
            Text(coinName),
          ],
        ),
      ),
      body: BlocBuilder<SingleCoinBloc, SingleCoinState>(
        builder: (context, state) {
          if (state is SingleCoinLoading) {
            return ListView.separated(
              itemCount: 7,
              separatorBuilder: (_, __) => const Divider(),
              itemBuilder: (context, index) => const CryptoCoinSkeleton(),
            );
          }

          if (state is SingleCoinLoaded) {
            final coin = state.coin;
            final coinInfo = coin.toDisplayList();

            return RefreshIndicator(
              onRefresh: () async {
                context
                    .read<SingleCoinBloc>()
                    .add(LoadSingleCoin(coinSymbol: coinName));
              },
              child: ListView.separated(
                physics: const AlwaysScrollableScrollPhysics(),
                itemCount: coinInfo.length,
                separatorBuilder: (_, __) => const Divider(),
                itemBuilder: (context, index) {
                  final item = coinInfo[index];
                  return ListTile(
                    title: Text(
                      item['title']!,
                      style: const TextStyle(fontWeight: FontWeight.bold),
                    ),
                    trailing: Text(
                      item['value'] ?? '',
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
    );
  }
}

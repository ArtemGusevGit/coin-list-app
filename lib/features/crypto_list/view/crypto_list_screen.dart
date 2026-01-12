import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../block/crypto_list_bloc.dart';
import '../widgets/crypto_coins_skeleton.dart';
import '../widgets/widgets.dart';

class CryptoListScreen extends StatelessWidget {
  const CryptoListScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Theme.of(context).colorScheme.inversePrimary,
        title: Text('Crypto list app'),
      ),
      body: BlocBuilder<CryptoListBloc, CryptoListState>(
        builder: (context, state) {
          if (state is CryptoListLoading) {
            return ListView.separated(
              itemCount: 6,
              separatorBuilder: (_, __) => const Divider(),
              itemBuilder: (context, index) => const CryptoCoinsSkeleton(),
            );
          }

          if (state is CryptoListLoadingFailure) {
            return Center(
              child: Text(state.exception?.toString() ?? 'Ошибка загрузки'),
            );
          }

          if (state is CryptoListLoaded) {
            return RefreshIndicator(
              onRefresh: () async {
                context.read<CryptoListBloc>().add(LoadCryptoList());
              },
              child: ListView.separated(
                physics: const AlwaysScrollableScrollPhysics(),
                itemCount: state.coinList.length,
                separatorBuilder: (context, idx) => const Divider(),
                itemBuilder: (context, idx) {
                  final coin = state.coinList[idx];
                  return CryptoCoinTile(
                    coinName: coin.name,
                    coinValue: coin.priceInUsd,
                    coinImg: coin.img,
                  );
                },
              ),
            );
          }

          return const Center(child: CircularProgressIndicator());
        },
      ),
    );
  }
}



import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get_it/get_it.dart';
import '../../../repositories/crypto_coins/crypto_coins_repository.dart';
import '../block/crypto_list_bloc.dart';
import '../widgets/crypto_coin_skeleton.dart';
import '../widgets/widgets.dart';

class CryptoListScreen extends StatefulWidget {
  const CryptoListScreen({super.key});


  @override
  State<CryptoListScreen> createState() => _CryptoListScreenState();
}

class _CryptoListScreenState extends State<CryptoListScreen> {

  final _cryptoListBlock = CryptoListBloc(GetIt.I<CryptoCoinsRepository>());

  @override
  void initState(){
    _cryptoListBlock.add(LoadCryptoList());
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Theme.of(context).colorScheme.inversePrimary,
        title: Text('Crypto list app'),
      ),
      body: BlocBuilder<CryptoListBloc, CryptoListState>(
        bloc: _cryptoListBlock,
        builder: (context, state) {
          if (state is CryptoListLoading) {
            return ListView.separated(
              itemCount: 6,
              separatorBuilder: (_, __) => const Divider(),
              itemBuilder: (context, index) => const CryptoCoinSkeleton(),
            );
          }

          if (state is CryptoListLoaded) {
            return RefreshIndicator(
              onRefresh: () async {
                _cryptoListBlock.add(LoadCryptoList());
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

          if (state is CryptoListLoadingFailure) {
            return Center(
              child: Text(state.exception?.toString() ?? 'Ошибка загрузки'),
            );
          }

          return const Center(child: CircularProgressIndicator());
        },
      ),

    );
  }
}



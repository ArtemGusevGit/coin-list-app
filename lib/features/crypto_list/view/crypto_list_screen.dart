import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get_it/get_it.dart';
import '../../../repositories/crypto_coins/crypto_coins_repository.dart';
import '../block/crypto_list_bloc.dart';
import '../widgets/widgets.dart';

class CryptoListScreen extends StatefulWidget {
  const CryptoListScreen({super.key, required this.title});

  final String title;

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
        title: Text(widget.title),
      ),
      body: BlocBuilder<CryptoListBloc, CryptoListState>(
        bloc: _cryptoListBlock,
        builder: (context, state) {
          if(state is CryptoListLoaded) {
            return ListView.separated(
              itemCount: state.coinList.length,
              separatorBuilder: (context, idx) => Divider(),
              itemBuilder: (context, idx) {
                final coin = state.coinList[idx];
                final coinName = coin.name;
                final coinValue = coin.priceInUsd;
                final coinImg = coin.img;
                return CryptoCoinTile(coinName: coinName, coinValue:coinValue, coinImg: coinImg, id:idx);
              },
            );
          }

          if(state is CryptoListLoadingFailure) {
            return Center(child: Text(state.exception?.toString() ?? 'Exception'));
          }
          return Center(child: CircularProgressIndicator());
        }
      )
    );
  }
}



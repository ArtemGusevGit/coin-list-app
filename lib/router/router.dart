import '../features/crypto_list/view/view.dart';
import '../features/single_crypto/view/view.dart';
import 'package:flutter/material.dart';

final Map<String, WidgetBuilder> router = {
  '/': (BuildContext context) => const CryptoListScreen(title: 'Crypto list app'),
  '/coin': (BuildContext context) => const CryptoCoinScreen(),
};

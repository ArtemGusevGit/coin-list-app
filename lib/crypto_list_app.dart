import 'package:flutter/material.dart';
import 'package:test_app/router/router.dart';
import 'package:test_app/theme/theme.dart';

class CryptoListApp extends StatelessWidget {
  const CryptoListApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Crypto list Demo',
      theme: yellowTheme,
      routes: router,
    );
  }
}
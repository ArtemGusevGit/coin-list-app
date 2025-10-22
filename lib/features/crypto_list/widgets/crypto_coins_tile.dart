import 'package:flutter/material.dart';

class CryptoCoinTile extends StatelessWidget {
  const CryptoCoinTile({
    super.key,
    required this.coinName,
    required this.coinValue,
    required this.coinImg
  });

  final String coinName;
  final double coinValue;
  final String coinImg;

  @override
  Widget build(BuildContext context) {
    final textTheme = Theme.of(context).textTheme;

    return ListTile(
      leading: Image.network(coinImg),
      title: Text(coinName, style: textTheme.bodyMedium),
      subtitle: Text('$coinValue\$', style: textTheme.bodySmall),
      trailing: Icon(Icons.arrow_forward_ios),
      onTap: () {
        Navigator.of(
          context,
        ).pushNamed('/coin', arguments: {'coin': coinName});
      },
    );
  }
}

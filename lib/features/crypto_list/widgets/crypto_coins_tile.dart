import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';


class CryptoCoinTile extends StatelessWidget {
  const CryptoCoinTile({
    super.key,
    required this.coinName,
    required this.id,
    required this.coinValue,
    required this.coinImg
  });

  final String coinName;
  final int id;
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
        ).pushNamed('/coin', arguments: {'coin': coinName, 'id': id});
      },
    );
  }
}

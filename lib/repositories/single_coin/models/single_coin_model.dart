class SingleCoin {
  const SingleCoin({
    required this.name,
    required this.priceInUsd,
    required this.high24h,
    required this.low24h,
    required this.changePct24h,
    required this.change24h,
    required this.displayPrice,
    required this.lastMarket,
  });

  final String name;
  final String priceInUsd;
  final String? high24h;
  final String? low24h;
  final String? changePct24h;
  final String? change24h;
  final String? displayPrice;
  final String? lastMarket;

  List<Map<String, String?>> toDisplayList() {
    return [
      {'title': 'Coin', 'value': name},
      {'title': 'Price', 'value': displayPrice},
      {'title': 'High 24h', 'value': high24h},
      {'title': 'Low 24h', 'value': low24h},
      {'title': 'Change 24h', 'value': change24h},
      {'title': 'Change 24h(%)', 'value': changePct24h != null ? '$changePct24h%' : null},
      {'title': 'Market', 'value': lastMarket},
    ];
  }
}

class SingleCoin {
  const SingleCoin({
    required this.name,
    required this.priceInUsd,
    required this.high24h,
    required this.low24h,
    required this.changePct24h,
    required this.displayPrice,
    required this.lastMarket,
  });

  final String name;
  final String priceInUsd;
  final String? high24h;
  final String? low24h;
  final double? changePct24h;
  final String? displayPrice;
  final String? lastMarket;
}
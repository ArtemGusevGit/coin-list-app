/// Mapping of ticker symbols to CoinGecko coin ids.
/// CoinGecko API addresses coins by id, not by ticker.
const Map<String, String> coinGeckoIds = {
  'BTC': 'bitcoin',
  'ETH': 'ethereum',
  'DOGE': 'dogecoin',
  'BNB': 'binancecoin',
  'TON': 'the-open-network',
  'SOL': 'solana',
};

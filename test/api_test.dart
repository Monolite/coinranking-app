import 'package:flutter_test/flutter_test.dart';

import 'package:coinranking/api/coinranking_api.dart';

void main() {
  late final CoinRankingApi api;

  setUpAll(() => api = CoinRankingApi(
      baseUrl: 'https://coinranking1.p.rapidapi.com', apiKey: '556adc7937mshe49ff6747a44e12p19818bjsna1de7d06d378'));

  test('Get coins', () async {
    final coins = await api.getCoins();

    print(coins);
  });

  test('Get ohlc of Bitcoin', () async {
    final ohlc = await api.getOhlc('Qwsogvtv82FCd');

    print(ohlc);
  });
}

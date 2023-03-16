import 'package:coinranking/model/ohlc_result.dart';
import 'package:dio/dio.dart';

import '../model/coin_result.dart';

class CoinRankingApi {
  CoinRankingApi({
    required this.baseUrl,
    required this.apiKey,
    this.rapidApiHost = 'coinranking1.p.rapidapi.com',
    this.connectTimeout = const Duration(seconds: 5),
    this.receiveTimeout = const Duration(seconds: 5),
  }) : dio = Dio(BaseOptions(
          baseUrl: baseUrl,
          connectTimeout: connectTimeout,
          receiveTimeout: receiveTimeout,
          headers: {
            'X-RapidAPI-Key': apiKey,
            'X-RapidAPI-Host': rapidApiHost,
          },
        ));

  final Dio dio;
  final String baseUrl;
  final String rapidApiHost;
  final Duration connectTimeout;
  final Duration receiveTimeout;
  final String apiKey;

  Future<List<OhlcResult>> getOhlc(String coinId) async {
    final response = await dio.get<Map<String, dynamic>>('/coin/$coinId/ohlc', queryParameters: {
      'referenceCurrencyUuid': 'yhjMzLPhuIDl',
      'interval': 'day',
    });

    final result = <OhlcResult>[];

    if (response.data != null) {
      final data = response.data;

      if (data?.containsKey('data') ?? false) {
        final content = data?['data'];

        if (content is Map<String, dynamic>?) {
          if (content?.containsKey('ohlc') ?? false) {
            final ohlcList = content?['ohlc'] as List<dynamic>?;

            if (ohlcList != null && ohlcList.isNotEmpty) {
              for (final ohlcData in ohlcList) {
                if (ohlcData is Map<String, dynamic>) {
                  final ohlcJson = ohlcData;

                  final instance = OhlcResult(
                    startingAt:
                        DateTime.fromMillisecondsSinceEpoch(1000 * int.parse(ohlcJson['startingAt'].toString())),
                    endingAt: DateTime.fromMillisecondsSinceEpoch(1000 * int.parse(ohlcJson['endingAt'].toString())),
                    //startingAt: ohlcJson['startingAt'],
                    //endingAt: ohlcJson['endingAt'],
                    open: ohlcJson['open'],
                    high: ohlcJson['high'],
                    low: ohlcJson['low'],
                    close: ohlcJson['close'],
                    avg: ohlcJson['avg'],
                  );

                  result.add(instance);
                }
              }
            }
          }
        }
      }
    }

    return result;
  }

  Future<List<CoinResult>> getCoins() async {
    final response = await dio.get<Map<String, dynamic>>('/coins', data: {
      'referenceCurrencyUuid': 'yhjMzLPhuIDl',
      'timePeriod': '24h',
      'tiers[0]': '1',
      'orderBy': 'marketCap',
      'orderDirection': 'desc',
      'limit': '50',
      'offset': '0'
    });

    final result = <CoinResult>[];

    if (response.data != null) {
      final data = response.data;

      if (data?.containsKey('data') ?? false) {
        if (data?['data'].containsKey('coins') ?? false) {
          final coinsData = data?['data']['coins'] as List<dynamic>?;

          if (coinsData != null) {
            for (final coinData in coinsData) {
              if (coinData is Map<String, dynamic>) {
                final coinJson = coinData;

                result.add(CoinResult.fromJson(coinJson));
              }
            }
          }
        }
      }
    }

    return result;
  }

  Future<List<CoinResult>> getCoin(String uuid) async {
    final response = await dio.get<Map<String, dynamic>>('/coin', queryParameters: {
      'uuid': uuid,
      'referenceCurrencyUuid': 'yhjMzLPhuIDl',
      'timePeriod': '24h',
    });

    final result = <CoinResult>[];

    if (response.data != null) {
      final data = response.data;

      if (data?.containsKey('data') ?? false) {
        if (data?['data'].containsKey('coin') ?? false) {
          final coinData = data?['data']['coin'];

          if (coinData != null && coinData is Map<String, dynamic>) {
            final coinJson = coinData;

            result.add(CoinResult.fromJson(coinJson));
          }
        }
      }
    }

    return result;
  }
}

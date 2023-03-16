class CoinResult {
  CoinResult({
    this.uuid,
    this.symbol,
    this.name,
    this.color,
    this.iconUrl,
    this.marketCap,
    this.price,
    this.listedAt,
    this.tier,
    this.change,
    this.rank,
  });

  factory CoinResult.fromJson(Map<String, dynamic> data) {
    final result = CoinResult(
      uuid: data['uuid'],
      symbol: data['symbol'],
      name: data['name'],
      color: data['color'],
      iconUrl: data['iconUrl'],
      marketCap: data['marketCap'],
      price: data['price'],
      listedAt: DateTime.fromMillisecondsSinceEpoch(1000 * int.parse(data['listedAt'].toString())),
      tier: int.tryParse(data['tier'].toString()),
      change: data['change'],
      rank: int.tryParse(data['rank'].toString()),
    );

    return result;
  }

  Map<String, dynamic> toJson() => {
        'uuid': uuid,
        'symbol': symbol,
        'name': name,
        'color': color,
        'iconUrl': iconUrl,
        'marketCap': marketCap,
        'price': price,
        'listedAt': listedAt,
        'tier': tier,
        'change': change,
        'rank': rank,
      };

  @override
  String toString() {
    // TODO: implement toString
    return toJson().toString();
  }

  final String? uuid;
  final String? symbol;
  final String? name;
  final String? color;
  final String? iconUrl;
  final String? marketCap;
  final String? price;
  final DateTime? listedAt;
  final int? tier;
  final String? change;
  final int? rank;

//   uuid:"Qwsogvtv82FCd"
// symbol:"BTC"
// name:"Bitcoin"
// color:"#f7931A"
// iconUrl:"https://cdn.coinranking.com/bOabBYkcX/bitcoin_btc.svg"
// marketCap:"473036110572"
// price:"24612.093104046584"
// listedAt:                           1330214400
// DateTime.fromMillisecondsSinceEpoch(1640979000000, isUtc:true);
// tier:1
// change:"1.55"
// rank:1
}

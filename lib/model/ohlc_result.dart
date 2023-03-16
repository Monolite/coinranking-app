class OhlcResult {
  OhlcResult({
    this.startingAt,
    this.endingAt,
    this.open,
    this.high,
    this.low,
    this.close,
    this.avg,
  });

  final DateTime? startingAt;
  final DateTime? endingAt;
  final String? open;
  final String? high;
  final String? low;
  final String? close;
  final String? avg;

//   startingAt:1678838400
// endingAt:1678924800
// open:"24749.071251236626"
// high:"25030.18850315237"
// low:"24167.77259162907"
// close:"24439.131194411533"
// avg:"24699.888353335988"
}

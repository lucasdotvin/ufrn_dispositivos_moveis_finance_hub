class HgCurrencyConversionStatusData {
  String name;

  double buy;

  double variation;

  HgCurrencyConversionStatusData({
    required this.name,
    required this.buy,
    required this.variation,
  });

  static HgCurrencyConversionStatusData fromJson(Map rawData) {
    return HgCurrencyConversionStatusData(
      name: rawData['name'],
      buy: rawData['buy'],
      variation: rawData['variation'],
    );
  }
}

class HgCurrenciesData {
  String source;

  Map<String, HgCurrencyConversionStatusData> currenciesData;

  HgCurrenciesData({
    required this.source,
    required this.currenciesData,
  });

  static HgCurrenciesData fromJson(Map rawData) {
    var source = rawData['source'];
    rawData.remove('source');

    var currenciesData = <String, HgCurrencyConversionStatusData>{};
    rawData.forEach((key, value) {
      currenciesData[key] = HgCurrencyConversionStatusData.fromJson(value);
    });

    return HgCurrenciesData(
      source: source,
      currenciesData: currenciesData,
    );
  }
}

class HgMarketData {
  final String key;

  final String name;

  final String location;

  final double points;

  final double variation;

  HgMarketData({
    required this.key,
    required this.name,
    required this.location,
    required this.points,
    required this.variation,
  });

  static HgMarketData fromJson(String key, Map<String, dynamic> rawData) {
    return HgMarketData(
      key: key,
      name: rawData['name'],
      location: rawData['location'],
      points: rawData['points'],
      variation: rawData['variation'],
    );
  }
}

class HgMarketsData {
  final List<HgMarketData> marketsData;

  HgMarketsData({
    required this.marketsData,
  });

  static HgMarketsData fromJson(Map<String, dynamic> rawData) {
    final marketsData = rawData.entries
        .map((entry) => HgMarketData.fromJson(entry.key, entry.value))
        .toList();

    return HgMarketsData(
      marketsData: marketsData,
    );
  }
}

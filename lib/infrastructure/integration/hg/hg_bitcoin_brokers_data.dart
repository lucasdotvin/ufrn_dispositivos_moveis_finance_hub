class HgBitcoinBrokerData {
  final String name;

  final List format;

  final double last;

  final double variation;

  HgBitcoinBrokerData({
    required this.name,
    required this.format,
    required this.last,
    required this.variation,
  });

  static HgBitcoinBrokerData fromJson(dynamic rawData) {
    return HgBitcoinBrokerData(
      name: rawData['name'],
      format: rawData['format'],
      last: rawData['last'],
      variation: rawData['variation'],
    );
  }
}

class HgBitcoinBrokersData {
  final List<HgBitcoinBrokerData> brokersData;

  HgBitcoinBrokersData({
    required this.brokersData,
  });

  static HgBitcoinBrokersData fromJson(Map<String, dynamic> rawData) {
    var brokersData = rawData.values.map(HgBitcoinBrokerData.fromJson).toList();

    return HgBitcoinBrokersData(
      brokersData: brokersData,
    );
  }
}

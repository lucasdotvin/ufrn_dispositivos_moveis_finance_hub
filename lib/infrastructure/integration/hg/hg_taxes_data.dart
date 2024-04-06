import 'dart:developer';

class HgTaxesData {
  final double cdi;

  final double selic;

  final String date;

  HgTaxesData({
    required this.cdi,
    required this.selic,
    required this.date,
  });

  static HgTaxesData fromJson(dynamic rawData) {
    return HgTaxesData(
      cdi: rawData['cdi'],
      selic: rawData['selic'],
      date: rawData['date'],
    );
  }
}

class HgTaxesHistoryData {
  final List<HgTaxesData> historyData;

  HgTaxesHistoryData({
    required this.historyData,
  });

  static HgTaxesHistoryData fromJson(List rawData) {
    inspect(rawData);

    return HgTaxesHistoryData(
      historyData: rawData.map(HgTaxesData.fromJson).toList(),
    );
  }
}

import 'package:finance_hub/infrastructure/integration/hg/hg_bitcoin_brokers_data.dart';
import 'package:finance_hub/infrastructure/integration/hg/hg_currencies_data.dart';
import 'package:finance_hub/infrastructure/integration/hg/hg_markets_data.dart';
import 'package:finance_hub/infrastructure/integration/hg/hg_taxes_data.dart';

class HgCompleteFinanceData {
  final HgCurrenciesData currenciesData;
  final HgBitcoinBrokersData bitcoinBrokersData;
  final HgMarketsData marketsData;
  final HgTaxesHistoryData taxesHistoryData;

  HgCompleteFinanceData({
    required this.currenciesData,
    required this.bitcoinBrokersData,
    required this.marketsData,
    required this.taxesHistoryData,
  });

  static HgCompleteFinanceData fromJson(dynamic rawData) {
    var results = rawData['results'];
    var currenciesData = HgCurrenciesData.fromJson(results['currencies']);
    var bitcoinBrokersData = HgBitcoinBrokersData.fromJson(results['bitcoin']);
    var marketsData = HgMarketsData.fromJson(results['stocks']);
    var taxesHistoryData = HgTaxesHistoryData.fromJson(results['taxes']);

    return HgCompleteFinanceData(
      currenciesData: currenciesData,
      bitcoinBrokersData: bitcoinBrokersData,
      marketsData: marketsData,
      taxesHistoryData: taxesHistoryData,
    );
  }
}

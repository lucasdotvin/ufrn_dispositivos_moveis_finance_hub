import 'package:finance_hub/domain/entity/company.dart';
import 'package:finance_hub/domain/entity/exchange_rate.dart';
import 'package:finance_hub/domain/entity/market.dart';
import 'package:finance_hub/domain/entity/taxes_report.dart';
import 'package:finance_hub/domain/enum/currency.dart';
import 'package:finance_hub/domain/enum/exchangeable.dart';

class CompleteFinanceData {
  final List<ExchangeRate<Currency, Currency>> currencyConversions;
  final Map<Company, ExchangeRate<Exchangeable, Currency>> bitcoinBrokersData;
  final List<Market> marketsData;
  final TaxesReport taxesData;

  CompleteFinanceData({
    required this.currencyConversions,
    required this.bitcoinBrokersData,
    required this.marketsData,
    required this.taxesData,
  });
}

abstract class FinanceDataIntegration {
  Future<CompleteFinanceData> getCompleteFinanceData();
}

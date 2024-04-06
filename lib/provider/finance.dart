import 'package:finance_hub/dependencies.dart';
import 'package:finance_hub/domain/entity/company.dart';
import 'package:finance_hub/domain/entity/exchange_rate.dart';
import 'package:finance_hub/domain/entity/market.dart';
import 'package:finance_hub/domain/entity/taxes_report.dart';
import 'package:finance_hub/domain/enum/currency.dart';
import 'package:finance_hub/domain/enum/exchangeable.dart';
import 'package:finance_hub/domain/service/finance_data_service.dart';
import 'package:flutter/foundation.dart';

class FinanceDataProvider extends ChangeNotifier {
  final FinanceDataService _financeDataService = resolve<FinanceDataService>();

  bool _hasLoadedFirstTime = false;
  bool _isLoading = false;
  List<ExchangeRate<Currency, Currency>> _currencyConversions = [];
  Map<Company, ExchangeRate<Exchangeable, Currency>> _bitcoinBrokersData = {};
  List<Market> _marketsData = [];
  TaxesReport _taxesReport = TaxesReport(
    referenceDate: DateTime.now(),
    taxes: {},
  );

  bool get hasLoadedFirstTime => _hasLoadedFirstTime;
  bool get isLoading => _isLoading;

  List<ExchangeRate<Currency, Currency>> get currencyConversions =>
      _currencyConversions;

  Map<Company, ExchangeRate<Exchangeable, Currency>> get bitcoinBrokersData =>
      _bitcoinBrokersData;

  List<Market> get marketsData => _marketsData;

  TaxesReport get taxesReport => _taxesReport;

  void setHasLoadedFirstTime(bool hasLoadedFirstTime) {
    _hasLoadedFirstTime = hasLoadedFirstTime;
    notifyListeners();
  }

  void setCurrencyConversions(
      List<ExchangeRate<Currency, Currency>> currencyConversions) {
    _currencyConversions = currencyConversions;
    notifyListeners();
  }

  void setBitcoinBrokerRates(
      Map<Company, ExchangeRate<Exchangeable, Currency>> bitcoinBrokersData) {
    _bitcoinBrokersData = bitcoinBrokersData;
    notifyListeners();
  }

  void setMarketsData(List<Market> marketsData) {
    _marketsData = marketsData;
    notifyListeners();
  }

  void setTaxesReport(TaxesReport taxesReport) {
    _taxesReport = taxesReport;
    notifyListeners();
  }

  void setLoading(bool isLoading) {
    _isLoading = isLoading;
    notifyListeners();
  }

  Future<void> loadAllData() async {
    setLoading(true);

    final completeFinanceData = await _financeDataService.loadAllData();
    setCurrencyConversions(completeFinanceData.currencyConversions);
    setBitcoinBrokerRates(completeFinanceData.bitcoinBrokersData);
    setMarketsData(completeFinanceData.marketsData);
    setTaxesReport(completeFinanceData.taxesData);

    setHasLoadedFirstTime(true);
    setLoading(false);
  }
}

import 'dart:convert';
import 'dart:io';

import 'package:finance_hub/domain/entity/company.dart';
import 'package:finance_hub/domain/entity/exchange_rate.dart';
import 'package:finance_hub/domain/entity/market.dart';
import 'package:finance_hub/domain/entity/taxes_report.dart';
import 'package:finance_hub/domain/enum/currency.dart';
import 'package:finance_hub/domain/enum/exchangeable.dart';
import 'package:finance_hub/domain/enum/tax.dart';
import 'package:finance_hub/domain/integration/finance_data_integration.dart';
import 'package:finance_hub/infrastructure/integration/hg/hg_bitcoin_brokers_data.dart';
import 'package:finance_hub/infrastructure/integration/hg/hg_complete_finance_data.dart';
import 'package:finance_hub/infrastructure/integration/hg/hg_currencies_data.dart';
import 'package:finance_hub/infrastructure/integration/hg/hg_markets_data.dart';
import 'package:finance_hub/infrastructure/integration/hg/hg_taxes_data.dart';

var _knownBitcoinBrokers = <String, Company>{
  'Blockchain.info': Company(
    name: 'Blockchain.info',
    brandColor: 0xFF0C6CF2,
    logoUrl: 'assets/blockchain-info-logo.png',
  ),
  'Coinbase': Company(
    name: 'Coinbase',
    brandColor: 0xFF0052FF,
    logoUrl: 'assets/coinbase-logo.png',
  ),
  'BitStamp': Company(
    name: 'BitStamp',
    brandColor: 0xFF003B2F,
    logoUrl: 'assets/bitstamp-logo.png',
  ),
  'FoxBit': Company(
    name: 'FoxBit',
    brandColor: 0xFFFF7400,
    logoUrl: 'assets/foxbit-logo.png',
  ),
  'Mercado Bitcoin': Company(
    name: 'Mercado Bitcoin',
    brandColor: 0XFFEF4723,
    logoUrl: 'assets/mercado-bitcoin-logo.png',
  ),
};

class HgFinanceDataIntegration implements FinanceDataIntegration {
  late String _apiKey;
  late String _baseUrl;
  late HttpClient _httpClient;

  HgFinanceDataIntegration() {
    _apiKey = const String.fromEnvironment('HG_API_KEY');
    _baseUrl = const String.fromEnvironment('HG_BASE_URL');
    _httpClient = HttpClient();
  }

  @override
  Future<CompleteFinanceData> getCompleteFinanceData() async {
    var hgFinanceData = await _getHgFinanceData();

    return CompleteFinanceData(
      currencyConversions: _parseHgCurrenciesData(hgFinanceData.currenciesData),
      bitcoinBrokersData: _parseHgBitcoinData(hgFinanceData.bitcoinBrokersData),
      marketsData: _parseHgMarketsData(hgFinanceData.marketsData),
      taxesData: _parseHgTaxesHistoryData(hgFinanceData.taxesHistoryData),
    );
  }

  Future<String> _requestFinanceData() async {
    var uri = Uri.parse(_baseUrl).replace(path: '/finance', queryParameters: {
      'key': _apiKey,
    });

    var request = await _httpClient.getUrl(uri);
    var response = await request.close();

    if (response.statusCode != 200) {
      throw Exception('Failed to load finance data');
    }

    var responseBody = await response.transform(utf8.decoder).join();

    return responseBody;
  }

  Future<HgCompleteFinanceData> _getHgFinanceData() async {
    var responseBody = await _requestFinanceData();
    var financeData = HgCompleteFinanceData.fromJson(jsonDecode(responseBody));

    return financeData;
  }

  List<ExchangeRate<Currency, Currency>> _parseHgCurrenciesData(
      HgCurrenciesData currenciesData) {
    return currenciesData.currenciesData.entries
        .map((entry) => ExchangeRate<Currency, Currency>(
              from: Currency.fromName(entry.key),
              to: Currency.fromName(currenciesData.source),
              rate: entry.value.buy,
              variation: entry.value.variation,
            ))
        .toList();
  }

  Map<Company, ExchangeRate<Exchangeable, Currency>> _parseHgBitcoinData(
      HgBitcoinBrokersData bitcoinBrokersData) {
    var bitcoinBrokers = <Company, ExchangeRate<Exchangeable, Currency>>{};

    for (var brokerData in bitcoinBrokersData.brokersData) {
      var company = _knownBitcoinBrokers[brokerData.name] ??
          Company(name: brokerData.name);

      bitcoinBrokers[company] = ExchangeRate(
        from: Exchangeable.bitcoin,
        to: Currency.fromName(brokerData.format.first),
        rate: brokerData.last,
        variation: brokerData.variation,
      );
    }

    return bitcoinBrokers;
  }

  List<Market> _parseHgMarketsData(HgMarketsData marketsData) {
    return marketsData.marketsData
        .map((marketData) => Market(
              name: marketData.key,
              address: marketData.location,
              points: marketData.points,
              variation: marketData.variation,
            ))
        .toList();
  }

  TaxesReport _parseHgTaxesHistoryData(HgTaxesHistoryData taxesHistoryData) {
    return TaxesReport(
      referenceDate: DateTime.parse(taxesHistoryData.historyData.first.date),
      taxes: {
        Tax.cdi: taxesHistoryData.historyData.first.cdi,
        Tax.selic: taxesHistoryData.historyData.first.selic,
      },
    );
  }
}

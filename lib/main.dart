import 'package:finance_hub/component/bitcoin/carousel.dart'
    as bitcoin_carousel;
import 'package:finance_hub/component/currency/carousel.dart'
    as currency_carousel;
import 'package:finance_hub/component/market/carousel.dart' as market_carousel;
import 'package:finance_hub/component/taxes/grid.dart' as taxes_grid;
import 'package:finance_hub/dependencies.dart';
import 'package:finance_hub/provider/finance.dart';
import 'package:flutter/material.dart';
import 'package:intl/date_symbol_data_local.dart';
import 'package:provider/provider.dart';

void main() async {
  initializeDependencies();
  await initializeDateFormatting('pt_BR', null);
  runApp(
    MultiProvider(
      providers: [
        ChangeNotifierProvider<FinanceDataProvider>(
          create: (_) => FinanceDataProvider(),
        ),
      ],
      child: const MainApp(),
    ),
  );
}

class MainApp extends StatelessWidget {
  const MainApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Finance Hub',
      themeMode: ThemeMode.dark,
      theme: ThemeData(
        brightness: Brightness.dark,
        primaryColor: Colors.teal.shade800,
      ),
      home: const HomePage(),
    );
  }
}

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Consumer<FinanceDataProvider>(
      builder: (context, financeDataProvider, _) {
        return Scaffold(
            appBar: AppBar(
              title: const Text('Finance Hub'),
              primary: true,
              backgroundColor: Colors.teal.shade800,
            ),
            body: Stack(
              children: [
                RefreshIndicator(
                  onRefresh: () async {
                    await financeDataProvider.loadAllData();
                  },
                  child: ListView(
                    children: const [
                      Padding(
                        padding: EdgeInsets.only(bottom: 10),
                        child: currency_carousel.Carousel(),
                      ),
                      Padding(
                        padding: EdgeInsets.only(bottom: 10),
                        child: bitcoin_carousel.Carousel(),
                      ),
                      Padding(
                        padding: EdgeInsets.only(bottom: 10),
                        child: taxes_grid.Grid(),
                      ),
                      Padding(
                        padding: EdgeInsets.only(bottom: 14),
                        child: market_carousel.Carousel(),
                      ),
                    ],
                  ),
                ),
              ],
            ));
      },
    );
  }
}

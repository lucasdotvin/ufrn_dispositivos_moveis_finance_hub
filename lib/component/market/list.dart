import 'package:finance_hub/component/market/item.dart';
import 'package:finance_hub/component/market/skeleton.dart';
import 'package:finance_hub/provider/finance.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class CarouselList extends StatelessWidget {
  const CarouselList({super.key});

  @override
  Widget build(BuildContext context) {
    return Consumer<FinanceDataProvider>(
      builder: (context, financeDataProvider, _) {
        if (!financeDataProvider.hasLoadedFirstTime) {
          return const ListSkeleton();
        }

        var marketDataItems = List<ListItem>.empty(growable: true);
        for (var market in financeDataProvider.marketsData) {
          marketDataItems.add(ListItem(
            market: market,
            first: marketDataItems.isEmpty,
            last: marketDataItems.length ==
                financeDataProvider.marketsData.length - 1,
          ));
        }

        return ListView(
          scrollDirection: Axis.horizontal,
          children: marketDataItems,
        );
      },
    );
  }
}

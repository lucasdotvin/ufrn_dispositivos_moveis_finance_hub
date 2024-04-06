import 'package:finance_hub/component/currency/item.dart';
import 'package:finance_hub/component/currency/skeleton.dart';
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

        var currencyConversionItems = List<ListItem>.empty(growable: true);

        for (var currencyConversion
            in financeDataProvider.currencyConversions) {
          currencyConversionItems.add(ListItem(
            currencyConversion: currencyConversion,
            first: currencyConversionItems.isEmpty,
            last: currencyConversionItems.length ==
                financeDataProvider.currencyConversions.length - 1,
          ));
        }

        return ListView(
          scrollDirection: Axis.horizontal,
          children: currencyConversionItems,
        );
      },
    );
  }
}

import 'package:finance_hub/component/bitcoin/item.dart';
import 'package:finance_hub/component/bitcoin/skeleton.dart';
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

        var bitcoinBrokerItems = List<ListItem>.empty(growable: true);
        for (var entry in financeDataProvider.bitcoinBrokersData.entries) {
          bitcoinBrokerItems.add(ListItem(
            company: entry.key,
            exchangeRate: entry.value,
            first: bitcoinBrokerItems.isEmpty,
            last: bitcoinBrokerItems.length ==
                financeDataProvider.bitcoinBrokersData.length - 1,
          ));
        }

        return ListView(
          scrollDirection: Axis.horizontal,
          children: bitcoinBrokerItems,
        );
      },
    );
  }
}

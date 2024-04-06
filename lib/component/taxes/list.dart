import 'package:finance_hub/component/taxes/block.dart';
import 'package:finance_hub/component/taxes/skeleton.dart';
import 'package:finance_hub/provider/finance.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';

class BlockList extends StatelessWidget {
  const BlockList({super.key});

  @override
  Widget build(BuildContext context) {
    return Consumer<FinanceDataProvider>(
      builder: (context, financeDataProvider, _) {
        if (!financeDataProvider.hasLoadedFirstTime) {
          return const ListSkeleton();
        }

        var listBlocks = List<ListBlock>.empty(growable: true);

        for (var entry in financeDataProvider.taxesReport.taxes.entries) {
          listBlocks.add(
            ListBlock(
              tax: entry.key,
              value: entry.value,
            ),
          );
        }

        return Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const _ReferenceDateLabel(),
            Row(
              children: listBlocks,
            ),
          ],
        );
      },
    );
  }
}

class _ReferenceDateLabel extends StatelessWidget {
  const _ReferenceDateLabel();

  @override
  Widget build(BuildContext context) {
    return Consumer<FinanceDataProvider>(
      builder: (context, financeDataProvider, _) {
        var formattedDate = DateFormat.yMMMMd('pt_BR')
            .format(financeDataProvider.taxesReport.referenceDate);

        var label = 'Atualizado em $formattedDate';

        return Padding(
          padding: const EdgeInsets.only(left: 4),
          child: Text(
            label,
            style: const TextStyle(
              fontSize: 14,
              fontWeight: FontWeight.w300,
            ),
          ),
        );
      },
    );
  }
}

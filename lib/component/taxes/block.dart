import 'package:finance_hub/domain/enum/tax.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class ListBlock extends StatelessWidget {
  final Tax tax;

  final double value;

  const ListBlock({
    super.key,
    required this.tax,
    required this.value,
  });

  @override
  Widget build(BuildContext context) {
    var formattedValue = NumberFormat.decimalPattern('pt_BR').format(value);
    var valueLabel = '$formattedValue%';

    return Expanded(
      child: SizedBox(
        height: 60,
        child: Card(
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 8),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  tax.name.toUpperCase(),
                  style: const TextStyle(
                    fontSize: 24,
                    fontWeight: FontWeight.bold,
                    letterSpacing: 1.25,
                  ),
                ),
                Text(
                  valueLabel,
                  style: const TextStyle(
                    fontSize: 16,
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

import 'package:finance_hub/domain/entity/exchange_rate.dart';
import 'package:finance_hub/domain/enum/currency.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class ListItem extends StatelessWidget {
  final ExchangeRate<Currency, Currency> currencyConversion;

  final bool first;

  final bool last;

  const ListItem({
    super.key,
    required this.currencyConversion,
    required this.first,
    required this.last,
  });

  @override
  Widget build(BuildContext context) {
    EdgeInsetsGeometry padding;

    if (first) {
      padding = const EdgeInsets.only(left: 10);
    } else if (last) {
      padding = const EdgeInsets.only(right: 10);
    } else {
      padding = EdgeInsets.zero;
    }

    return Padding(
      padding: padding,
      child: SizedBox(
        width: 110,
        height: 110,
        child: Card(
          clipBehavior: Clip.antiAlias,
          child: Column(
            children: [
              _NameLabel(name: currencyConversion.from.name),
              _RateLabel(
                  rate: currencyConversion.rate, to: currencyConversion.to),
              _VariationLabel(variation: currencyConversion.variation),
            ],
          ),
        ),
      ),
    );
  }
}

class _NameLabel extends StatelessWidget {
  final String name;

  const _NameLabel({required this.name});

  @override
  Widget build(BuildContext context) {
    return DecoratedBox(
      decoration: BoxDecoration(color: Colors.grey.shade800.withOpacity(0.6)),
      child: SizedBox(
        height: 24,
        child: Center(
          child: Text(
            name.toUpperCase(),
            style: TextStyle(
              fontSize: 16,
              fontWeight: FontWeight.w500,
              letterSpacing: 2,
              color: Theme.of(context).colorScheme.onSurface.withOpacity(0.9),
            ),
          ),
        ),
      ),
    );
  }
}

class _RateLabel extends StatelessWidget {
  final double rate;

  final Currency to;

  const _RateLabel({required this.rate, required this.to});

  @override
  Widget build(BuildContext context) {
    var label = NumberFormat.simpleCurrency(locale: to.locale).format(rate);

    return SizedBox(
      height: 54,
      child: Padding(
        padding: const EdgeInsets.all(10),
        child: FittedBox(
          child: Text(
            label,
            style: const TextStyle(
              fontSize: 32,
              fontWeight: FontWeight.w500,
            ),
          ),
        ),
      ),
    );
  }
}

class _VariationLabel extends StatelessWidget {
  final double variation;

  const _VariationLabel({required this.variation});

  @override
  Widget build(BuildContext context) {
    var label = '${NumberFormat.compact(locale: 'pt_BR').format(variation)}%';

    Color color;

    if (variation > 0) {
      color = Colors.teal.shade400;
    } else if (variation < 0) {
      color = Colors.red.shade400;
    } else {
      color = Colors.grey.shade400;
    }

    return DecoratedBox(
      decoration: BoxDecoration(
        color: color.withOpacity(0.15),
      ),
      child: SizedBox(
        height: 24,
        child: Center(
          child: Text(
            label,
            style: TextStyle(
              color: color,
              fontSize: 12,
              fontWeight: FontWeight.w500,
              letterSpacing: 2,
            ),
          ),
        ),
      ),
    );
  }
}

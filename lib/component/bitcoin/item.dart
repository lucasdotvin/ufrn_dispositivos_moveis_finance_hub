import 'package:finance_hub/domain/entity/company.dart';
import 'package:finance_hub/domain/entity/exchange_rate.dart';
import 'package:finance_hub/domain/enum/currency.dart';
import 'package:finance_hub/domain/enum/exchangeable.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class ListItem extends StatelessWidget {
  final Company company;

  final ExchangeRate<Exchangeable, Currency> exchangeRate;

  final bool first;

  final bool last;

  const ListItem({
    super.key,
    required this.company,
    required this.exchangeRate,
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

    Widget avatar;

    if (company.logoUrl != null) {
      avatar = Image.asset(
        company.logoUrl!,
        width: 24,
      );
    } else {
      avatar = const Icon(Icons.business);
    }

    Color brandColor;

    if (company.brandColor != null) {
      brandColor = Color(company.brandColor!);
    } else {
      brandColor = Colors.grey.shade700.withOpacity(0.5);
    }

    return Padding(
      padding: padding,
      child: Card(
        child: SizedBox(
          width: 256,
          child: ListTile(
            leading: CircleAvatar(
              backgroundColor: brandColor,
              child: avatar,
            ),
            title: Text(
              company.name,
              style: const TextStyle(
                fontSize: 16,
                fontWeight: FontWeight.w600,
              ),
            ),
            subtitle: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                _RateLabel(rate: exchangeRate.rate, to: exchangeRate.to),
                _VariationLabel(variation: exchangeRate.variation),
              ],
            ),
            isThreeLine: true,
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
      height: 40,
      child: FittedBox(
        child: Text(
          label,
          style: const TextStyle(
            fontSize: 32,
            fontWeight: FontWeight.w500,
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
    IconData icon;

    if (variation > 0) {
      color = Colors.teal.shade400;
      icon = Icons.trending_up;
    } else if (variation < 0) {
      color = Colors.red.shade400;
      icon = Icons.trending_down;
    } else {
      color = Colors.grey.shade400;
      icon = Icons.trending_flat;
    }

    return Chip(
      avatar: Icon(icon, size: 14, color: Colors.white),
      side: BorderSide(color: color.withOpacity(0.5), width: 1),
      visualDensity: VisualDensity.compact,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(48),
      ),
      backgroundColor: color.withOpacity(0.25),
      label: Text(
        label,
        style: const TextStyle(
          color: Colors.white,
          fontSize: 14,
          fontWeight: FontWeight.w500,
        ),
      ),
    );
  }
}

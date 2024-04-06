import 'package:finance_hub/domain/entity/market.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

var _knownMarketsGradients = {
  "IBOVESPA": const LinearGradient(
    begin: Alignment.topLeft,
    end: Alignment.bottomRight,
    colors: [
      Color(0x99c4dd23),
      Color(0x4423d18d),
      Color(0x2200a6ff),
    ],
  ),
  "IFIX": const LinearGradient(
    begin: Alignment.bottomLeft,
    end: Alignment.topRight,
    colors: [
      Color(0x2223d18d),
      Color(0x9900bfff),
    ],
  ),
  "NASDAQ": const LinearGradient(
    begin: Alignment.topLeft,
    end: Alignment.bottomRight,
    colors: [
      Color(0x9900bfff),
      Color(0x227923d1),
    ],
  ),
  "DOWJONES": const LinearGradient(
    begin: Alignment.bottomLeft,
    end: Alignment.topRight,
    colors: [
      Color(0x22007fff),
      Color(0x99239dd1),
    ],
  ),
  "CAC": const LinearGradient(
    begin: Alignment.topLeft,
    end: Alignment.bottomRight,
    colors: [
      Color(0x99ff005d),
      Color(0x44e685c5),
      Color(0x223023d1),
    ],
  ),
  "NIKKEI": const LinearGradient(
    begin: Alignment.bottomLeft,
    end: Alignment.topRight,
    colors: [
      Color(0x22e685c5),
      Color(0x44ff005d),
      Color(0x99e685c5),
    ],
  ),
};

class ListItem extends StatelessWidget {
  final Market market;

  final bool first;

  final bool last;

  const ListItem({
    super.key,
    required this.market,
    required this.first,
    required this.last,
  });

  @override
  Widget build(BuildContext context) {
    EdgeInsetsGeometry padding;

    if (first) {
      padding = const EdgeInsets.only(left: 14, right: 10);
    } else if (last) {
      padding = const EdgeInsets.only(right: 14);
    } else {
      padding = const EdgeInsets.only(right: 10);
    }

    return Padding(
      padding: padding,
      child: SizedBox(
        width: 320,
        child: DecoratedBox(
          decoration: BoxDecoration(
            color: Colors.black54,
            gradient: _knownMarketsGradients[market.name],
            borderRadius: BorderRadius.circular(12),
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(
                market.name,
                style: const TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.w400,
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(bottom: 4),
                child: _PointsLabel(points: market.points),
              ),
              _VariationLabel(variation: market.variation),
            ],
          ),
        ),
      ),
    );
  }
}

class _PointsLabel extends StatelessWidget {
  final double points;

  const _PointsLabel({required this.points});

  @override
  Widget build(BuildContext context) {
    var label = NumberFormat.decimalPattern('pt_BR').format(points);

    return Text(
      label,
      style: const TextStyle(
        fontSize: 32,
        fontWeight: FontWeight.w500,
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
      color = Colors.teal.shade700;
      icon = Icons.trending_up;
    } else if (variation < 0) {
      color = Colors.red.shade700;
      icon = Icons.trending_down;
    } else {
      color = Colors.grey.shade700;
      icon = Icons.trending_flat;
    }

    return DecoratedBox(
      decoration: BoxDecoration(
        color: color,
        borderRadius: BorderRadius.circular(14),
      ),
      child: SizedBox(
        height: 28,
        child: Padding(
          padding: const EdgeInsets.symmetric(vertical: 2, horizontal: 10),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Row(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Padding(
                    padding: const EdgeInsets.only(right: 6),
                    child: Icon(icon, size: 14, color: Colors.white),
                  ),
                  Text(
                    label,
                    style: const TextStyle(
                      color: Colors.white,
                      fontSize: 14,
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}

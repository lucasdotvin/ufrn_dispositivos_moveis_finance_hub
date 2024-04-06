import 'package:finance_hub/domain/enum/tax.dart';

class TaxesReport {
  final DateTime referenceDate;

  final Map<Tax, double> taxes;

  TaxesReport({
    required this.referenceDate,
    required this.taxes,
  });
}

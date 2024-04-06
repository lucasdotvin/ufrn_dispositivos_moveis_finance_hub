import 'package:finance_hub/domain/integration/finance_data_integration.dart';
import 'package:finance_hub/domain/service/finance_data_service.dart';
import 'package:finance_hub/infrastructure/integration/hg/hg_finance_data_integration.dart';

var _resolvedDependencies = <Type, dynamic>{};

void initializeDependencies() {
  _resolvedDependencies[FinanceDataIntegration] = HgFinanceDataIntegration();
  _resolvedDependencies[FinanceDataService] =
      FinanceDataService(resolve<FinanceDataIntegration>());
}

T resolve<T>() {
  var resolved = _resolvedDependencies[T];

  if (resolved == null) {
    throw ArgumentError('Dependency not found: $T');
  }

  if (resolved is! T) {
    throw ArgumentError('Resolved dependency is not of type $T');
  }

  return resolved;
}

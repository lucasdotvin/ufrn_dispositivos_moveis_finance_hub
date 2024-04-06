import 'package:finance_hub/domain/integration/finance_data_integration.dart';

class FinanceDataService {
  final FinanceDataIntegration _financeDataIntegration;

  FinanceDataService(this._financeDataIntegration);

  Future<CompleteFinanceData> loadAllData() async {
    var completeFinanceData =
        await _financeDataIntegration.getCompleteFinanceData();

    return completeFinanceData;
  }
}

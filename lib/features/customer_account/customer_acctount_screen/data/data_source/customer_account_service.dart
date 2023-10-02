// ignore_for_file: public_member_api_docs, sort_constructors_first
//

import 'package:epsilon_api/configuration/api_end_points.dart';
import 'package:epsilon_api/core/helpers/api_helper/domain/api_helper.dart';
import 'package:epsilon_api/core/helpers/safe.dart';
import 'package:epsilon_api/features/customer_account/customer_acctount_screen/data/dtos/customer_transactions_response.dart';
import 'package:epsilon_api/features/customer_account/customer_acctount_screen/data/dtos/balance_dto.dart';

class CustomerAccountService {
  final ApiHelper apiHelper;
  final Safe safe;

  CustomerAccountService({
    required this.apiHelper,
    required this.safe,
  });

  Future<List<BalanceDTO>> getAccountBalance(int id) async {
    final Map<String, String> params = {
      "custid": id.toString(),
    };

    final headers = {
      "Authorization": "Bearer ${safe.getToken() ?? ''}",
      "Accept": "application/json"
    };

    final url = '${safe.getHost()}/api/';

    final response = await apiHelper.get(
      url: url,
      endPoint: ApiEndPoints.customerBalance,
      headers: headers,
      params: params,
    );

    // final jsonObject = response.decode();
    final result = customerTransactionsResponseFromJson(response.body);
    final balance = result.data ?? [];
    return balance;
  }
}

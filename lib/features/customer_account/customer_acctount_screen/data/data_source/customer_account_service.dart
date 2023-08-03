// ignore_for_file: public_member_api_docs, sort_constructors_first
//

import 'package:epsilon_api/configuration/api_end_points.dart';
import 'package:epsilon_api/core/helpers/api_helper/domain/api_helper.dart';
import 'package:epsilon_api/features/customer_account/customer_acctount_screen/data/dtos/account_balance_dto.dart';
import 'package:epsilon_api/features/customer_account/customer_acctount_screen/data/dtos/balance_dto.dart';

class CustomerAccountService {
  final ApiHelper apiHelper;

  CustomerAccountService({
    required this.apiHelper,
  });

  Future<AccountBalanceDto> getAccountBalance(String guid) async {
    final Map<String, String> params = {
      "cust": "",
      "guid": guid,
    };
    final response = await apiHelper.get(
      url: ApiEndPoints.baseURL,
      endPoint: ApiEndPoints.customerBalance,
      params: params,
    );

    // final jsonObject = response.decode();
    final result = balanceDtoFromJson(response.body);
    final balance = result[0].map((e) => BalanceDTO.fromOld(e)).toList();
    final currency = result[1].map((e) => CurrencyDTO.fromOld(e)).toList();
    final AccountBalanceDto model =
        AccountBalanceDto(balance: balance, currency: currency);
    return model;
  }
}

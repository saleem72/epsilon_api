//

import 'package:epsilon_api/core/domian/models/compact_customer.dart';

import 'currency.dart';

class VoucherPrimaryData {
  final List<Currency> currencies;
  final List<CompactCustomer> customers;
  const VoucherPrimaryData({
    required this.currencies,
    required this.customers,
  });
}

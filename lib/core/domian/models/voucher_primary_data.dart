//

import 'package:epsilon_api/core/domian/models/compact_customer.dart';
import 'package:epsilon_api/core/domian/models/voucher_type.dart';

import 'currency.dart';

class VoucherPrimaryData {
  final List<Currency> currencies;
  final List<CompactCustomer> customers;
  final List<VoucherType> voucherTypes;
  const VoucherPrimaryData({
    required this.currencies,
    required this.customers,
    required this.voucherTypes,
  });
}

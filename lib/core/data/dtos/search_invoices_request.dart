//

import 'package:intl/intl.dart' as intl;

class SearchInvoicesRequest {
  final DateTime startDate;
  final DateTime endDate;
  final int billType;
  final int custId;

  const SearchInvoicesRequest({
    required this.startDate,
    required this.endDate,
    required this.billType,
    required this.custId,
  });

  Map<String, String> toMap() {
    final sDate =
        '${intl.DateFormat('yyyy-MM-ddThh:mm:ss.SSS').format(startDate)}Z';
    final eDate =
        '${intl.DateFormat('yyyy-MM-ddThh:mm:ss.SSS').format(endDate)}Z';
    return <String, String>{
      'startDate': sDate,
      'endDate': eDate,
      'billType': billType.toString(),
      'custId': custId.toString(),
    };
  }
}

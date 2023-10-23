//
import 'package:epsilon_api/configuration/api_end_points.dart';
import 'package:epsilon_api/core/helpers/api_helper/domain/api_helper.dart';
import 'package:epsilon_api/core/helpers/safe.dart';
import 'package:epsilon_api/core/data/dtos/prices_response.dart';

final class PricesSelectorService {
  final Safe _safe;
  final ApiHelper _apiHelper;

  const PricesSelectorService({
    required ApiHelper apiHelper,
    required Safe safe,
  })  : _apiHelper = apiHelper,
        _safe = safe;

  Future<List<PriceDTO>> fetchPrices(String searchTerm) async {
    final Map<String, String> params = {
      "searchKeyWord": searchTerm,
    };

    final headers = {
      "Authorization": "Bearer ${_safe.getToken() ?? ''}",
      "Accept": "application/json"
    };

    final url = '${_safe.getHost()}/api/';

    final response = await _apiHelper.get(
      url: url,
      endPoint: ApiEndPoints.getPrices,
      headers: headers,
      params: params,
    );

    final outcome = pricesResponseFromJson(response.body);

    return outcome.data?.clients ?? [];
  } //
}

import 'dart:convert';
import 'package:http/http.dart' as http;

/// Minimal GeoNames district (ADM2) fetcher for India.
/// You need a free GeoNames username: https://www.geonames.org/login
///
/// Flow:
/// 1) Find the ADM1 (state) geonameId for the given state name in India
/// 2) Fetch its children -> ADM2 list (districts)
class DistrictService {
  DistrictService._();

  static const _base = 'https://secure.geonames.org';

  /// Returns the ADM2 district names for a given Indian state.
  /// [geoNamesUser] is your registered username.
  static Future<List<String>> fetchIndiaDistricts({
    required String stateName,
    required String geoNamesUser,
  }) async {
    if (stateName.trim().isEmpty) return const [];

    // 1) lookup ADM1 record for the state
    final searchUrl = Uri.parse(
      '$_base/searchJSON?name_equals=${Uri.encodeQueryComponent(stateName)}'
      '&country=IN&featureClass=A&featureCode=ADM1&maxRows=1&username=$geoNamesUser',
    );

    final sResp = await http.get(searchUrl);
    if (sResp.statusCode != 200) return const [];
    final sJson = jsonDecode(sResp.body) as Map<String, dynamic>;
    final geonames = (sJson['geonames'] as List?) ?? const [];
    if (geonames.isEmpty) return const [];

    final geonameId = geonames.first['geonameId']?.toString();
    if (geonameId == null) return const [];

    // 2) children -> ADM2
    final childrenUrl = Uri.parse(
      '$_base/childrenJSON?geonameId=$geonameId&username=$geoNamesUser',
    );

    final cResp = await http.get(childrenUrl);
    if (cResp.statusCode != 200) return const [];
    final cJson = jsonDecode(cResp.body) as Map<String, dynamic>;
    final children = (cJson['geonames'] as List?) ?? const [];

    // Filter ADM2 + map names
    final districts = children
        .where((e) =>
            (e is Map) &&
            (e['fcode'] == 'ADM2' || e['featureCode'] == 'ADM2'))
        .map<String>((e) => (e['name'] ?? e['toponymName'] ?? '').toString())
        .where((n) => n.isNotEmpty)
        .toList()
      ..sort((a, b) => a.toLowerCase().compareTo(b.toLowerCase()));

    return districts;
  }
}

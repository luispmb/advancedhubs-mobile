import 'dart:convert';

import '../domain/location_place.dart';

/// Constrói [LocationPlace] a partir do JSON administrativo (distritos → concelhos → freguesias).
List<LocationPlace> parsePortugalAdminJson(String jsonStr) {
  final decoded = jsonDecode(jsonStr);
  if (decoded is! List<dynamic>) return const [];

  final out = <LocationPlace>[];
  for (final raw in decoded) {
    if (raw is! Map<String, dynamic>) continue;
    final districtName = raw['name'] as String? ?? '';
    final concelhos = (raw['conselhos'] ?? raw['concelhos']) as List<dynamic>?;
    if (districtName.isEmpty || concelhos == null) continue;

    for (final rawC in concelhos) {
      if (rawC is! Map<String, dynamic>) continue;
      final concelhoName = rawC['name'] as String? ?? '';
      final cCode = rawC['code'];
      if (concelhoName.isEmpty) continue;

      out.add(
        LocationPlace(
          id: 'm$cCode',
          displayLabel: '$concelhoName, $districtName',
          kind: 'municipality',
        ),
      );

      final freguesias = rawC['freguesias'] as List<dynamic>?;
      if (freguesias == null) continue;
      for (final rawF in freguesias) {
        if (rawF is! Map<String, dynamic>) continue;
        final fName = rawF['name'] as String? ?? '';
        final fCode = rawF['code'];
        if (fName.isEmpty) continue;
        out.add(
          LocationPlace(
            id: 'p$fCode',
            displayLabel: '$fName, $concelhoName',
            kind: 'parish',
            subtitleDistrict: districtName,
          ),
        );
      }
    }
  }
  return out;
}

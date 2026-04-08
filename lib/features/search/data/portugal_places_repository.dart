import 'package:flutter/services.dart' show rootBundle;

import '../domain/location_place.dart';
import 'portugal_places_parser.dart';

/// Base administrativa (distritos → concelhos → freguesias), ficheiro derivado de dados públicos.
const _assetPath = 'assets/data/portugal_admin.json';

/// Carrega concelhos e freguesias de Portugal a partir do asset JSON.
Future<List<LocationPlace>> loadPortugalPlacesFromAsset() async {
  final jsonStr = await rootBundle.loadString(_assetPath);
  return parsePortugalAdminJson(jsonStr);
}

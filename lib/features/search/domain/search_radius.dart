/// Opções de raio (km) alinhadas ao UI de pesquisa e ao sheet de filtros.
const List<int> kSearchRadiusKmOptions = [2, 5, 10, 15, 20, 30, 40];

String formatSearchRadiusKm(int km) => '$km km';

/// Extrai km a partir de rótulos como «5 km» ou «30 km».
int parseSearchRadiusKm(String? label, {int fallback = 5}) {
  if (label == null || label.trim().isEmpty) return fallback;
  final m = RegExp(r'(\d+)').firstMatch(label);
  if (m == null) return fallback;
  final v = int.tryParse(m.group(1)!);
  if (v == null) return fallback;
  if (kSearchRadiusKmOptions.contains(v)) return v;
  return fallback;
}

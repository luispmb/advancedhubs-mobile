/// Localidade em Portugal (cidade, freguesia, concelho) para pesquisa e envio ao backend.
class LocationPlace {
  const LocationPlace({
    required this.id,
    required this.displayLabel,
    this.kind = 'municipality',
    this.subtitleDistrict,
  });

  /// Identificador estável para a API (slug ou código interno).
  final String id;

  /// Texto mostrado ao utilizador (ex.: "Porto, Porto").
  final String displayLabel;

  /// `municipality` | `parish` | `city` — útil para o backend.
  final String kind;

  /// Distrito / região para a 2.ª linha em freguesias (ex.: «Lisboa, Portugal»).
  final String? subtitleDistrict;

  /// Primeira linha no autocomplete (ex.: «Sintra»).
  String get primaryLine => displayLabel.split(',').first.trim();

  /// Segunda linha (ex.: «Lisboa, Portugal»).
  String get regionCountryLine {
    if (subtitleDistrict != null && subtitleDistrict!.isNotEmpty) {
      return '${subtitleDistrict!}, Portugal';
    }
    final parts = displayLabel
        .split(',')
        .map((s) => s.trim())
        .where((s) => s.isNotEmpty)
        .toList();
    if (parts.length >= 2) return '${parts[1]}, Portugal';
    return 'Portugal';
  }
}

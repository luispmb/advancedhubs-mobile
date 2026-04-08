import '../domain/location_place.dart';

bool _placeMatchesQuery(LocationPlace p, String q) {
  final label = p.displayLabel.toLowerCase();
  final primary = p.primaryLine.toLowerCase();
  final sub = p.subtitleDistrict?.toLowerCase() ?? '';
  return label.contains(q) ||
      primary.startsWith(q) ||
      label.startsWith(q) ||
      sub.contains(q) ||
      p.id.toLowerCase().contains(q);
}

/// Pontuação mais alta = mais relevante (concelhos/cidades sobem; freguesias longas descem).
int _relevanceScore(LocationPlace p, String q) {
  final primary = p.primaryLine.toLowerCase();
  final label = p.displayLabel.toLowerCase();
  int s = 0;
  if (primary == q) {
    s = 200;
  } else if (primary.startsWith(q)) {
    s = 160;
  } else if (label.startsWith(q)) {
    s = 130;
  } else if (primary.contains(q)) {
    s = 90;
  } else if (label.contains(q)) {
    s = 70;
  } else if ((p.subtitleDistrict ?? '').toLowerCase().contains(q)) {
    s = 50;
  } else {
    s = 30;
  }
  if (p.kind == 'municipality' || p.kind == 'city') {
    s += 35;
  }
  if (primary.length > 48 && s < 120) {
    s -= 20;
  }
  return s;
}

/// Filtra e ordena por relevância (ex.: «lisboa» mostra o concelho Lisboa antes de muitas freguesias).
List<LocationPlace> filterPortugalPlaces(
  List<LocationPlace> all,
  String query, {
  int maxResults = 120,
}) {
  final q = query.trim().toLowerCase();
  if (q.length < 2) return const [];

  final candidates =
      all.where((p) => _placeMatchesQuery(p, q)).toList(growable: false);
  candidates.sort(
    (a, b) => _relevanceScore(b, q).compareTo(_relevanceScore(a, q)),
  );
  if (candidates.length <= maxResults) return candidates;
  return candidates.sublist(0, maxResults);
}

/// Modelo de imóvel para o mapa.
/// Preparado para substituição por entidade de domínio/API.
class PropertyModel {
  const PropertyModel({
    required this.id,
    required this.lat,
    required this.lng,
    required this.price,
    required this.percentage,
    required this.type,
    this.imageUrl,
  });

  final String id;
  final double lat;
  final double lng;
  final String price;
  final String percentage;
  final String type;
  final String? imageUrl;
}

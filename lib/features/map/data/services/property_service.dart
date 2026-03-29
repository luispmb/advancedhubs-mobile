import '../models/property_model.dart';

/// Serviço de imóveis. Actualmente usa mock; no futuro trocar por chamada HTTP.
class PropertyService {
  PropertyService();

  /// Obtém a lista de imóveis (mock: 10 em Leiria com delay).
  Future<List<PropertyModel>> fetchProperties() async {
    await Future<void>.delayed(const Duration(milliseconds: 600));
    return _mockProperties;
  }
}

/// Dados mock — imóveis na zona de Leiria.
final List<PropertyModel> _mockProperties = [
  const PropertyModel(
    id: '1',
    lat: 39.7480,
    lng: -8.8050,
    price: '195.000€',
    percentage: '+6%',
    type: 'Apartamento T2',
    imageUrl: null,
  ),
  const PropertyModel(
    id: '2',
    lat: 39.7520,
    lng: -8.8120,
    price: '215.000€',
    percentage: '+7%',
    type: 'Apartamento T2',
    imageUrl: null,
  ),
  const PropertyModel(
    id: '3',
    lat: 39.7450,
    lng: -8.7980,
    price: '184.000€',
    percentage: '-4%',
    type: 'Apartamento T1',
    imageUrl: null,
  ),
  const PropertyModel(
    id: '4',
    lat: 39.7550,
    lng: -8.8080,
    price: '230.000€',
    percentage: '-2%',
    type: 'Apartamento T3',
    imageUrl: null,
  ),
  const PropertyModel(
    id: '5',
    lat: 39.7410,
    lng: -8.8150,
    price: '200.000€',
    percentage: '+5%',
    type: 'Apartamento T2',
    imageUrl: null,
  ),
  const PropertyModel(
    id: '6',
    lat: 39.7580,
    lng: -8.8020,
    price: '178.000€',
    percentage: '+3%',
    type: 'Apartamento T1',
    imageUrl: null,
  ),
  const PropertyModel(
    id: '7',
    lat: 39.7380,
    lng: -8.8080,
    price: '245.000€',
    percentage: '-1%',
    type: 'Apartamento T3',
    imageUrl: null,
  ),
  const PropertyModel(
    id: '8',
    lat: 39.7510,
    lng: -8.7950,
    price: '192.000€',
    percentage: '+4%',
    type: 'Apartamento T2',
    imageUrl: null,
  ),
  const PropertyModel(
    id: '9',
    lat: 39.7440,
    lng: -8.8180,
    price: '165.000€',
    percentage: '+8%',
    type: 'Apartamento T1',
    imageUrl: null,
  ),
  const PropertyModel(
    id: '10',
    lat: 39.7560,
    lng: -8.7980,
    price: '220.000€',
    percentage: '+2%',
    type: 'Apartamento T2',
    imageUrl: null,
  ),
];

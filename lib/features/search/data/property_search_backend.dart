import 'package:flutter/foundation.dart';

import '../domain/location_place.dart';

/// Contrato para o backend de pesquisa por localização e raio.
abstract class PropertySearchBackend {
  /// Enviar área de pesquisa (local + raio em km). Chamar após escolher sítio ou alterar raio.
  Future<void> submitSearchArea({
    required LocationPlace place,
    required int radiusKm,
  });
}

/// Implementação de desenvolvimento: apenas log. Trocar por [RemotePropertySearchBackend].
class DebugPropertySearchBackend implements PropertySearchBackend {
  @override
  Future<void> submitSearchArea({
    required LocationPlace place,
    required int radiusKm,
  }) async {
    debugPrint(
      '[PropertySearchBackend] placeId=${place.id} kind=${place.kind} '
      'label=${place.displayLabel} radiusKm=$radiusKm',
    );
  }
}

/// Esqueleto para produção.
class RemotePropertySearchBackend implements PropertySearchBackend {
  @override
  Future<void> submitSearchArea({
    required LocationPlace place,
    required int radiusKm,
  }) async {
    // TODO: GET/POST com placeId, radiusKm
    throw UnimplementedError('Ligar RemotePropertySearchBackend ao serviço real.');
  }
}

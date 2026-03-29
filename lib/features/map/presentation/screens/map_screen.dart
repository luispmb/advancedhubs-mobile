import 'package:flutter/material.dart';
import 'package:flutter_map/flutter_map.dart';
import 'package:latlong2/latlong.dart';

import '../../../../core/theme/app_theme.dart';
import '../../data/models/property_model.dart';
import '../../data/services/property_service.dart';
import '../widgets/custom_pin_widget.dart';
import '../widgets/property_bottom_sheet_card.dart';
import '../widgets/top_map_filters.dart';

/// Centro inicial do mapa — Leiria.
const _initialCenter = LatLng(39.7440, -8.8070);
const _initialZoom = 13.0;

/// Conteúdo do mapa (pins, pan/zoom, bottom sheet). Pode ser embutido sob o mesmo cabeçalho da pesquisa.
class MapContent extends StatefulWidget {
  MapContent({
    super.key,
    PropertyService? propertyService,
  }) : _propertyService = propertyService ?? PropertyService();

  final PropertyService _propertyService;

  @override
  State<MapContent> createState() => _MapContentState();
}

class _MapContentState extends State<MapContent> {
  final MapController _mapController = MapController();
  List<PropertyModel> _properties = [];
  bool _loading = true;
  String? _selectedPropertyId;

  @override
  void initState() {
    super.initState();
    _loadProperties();
  }

  Future<void> _loadProperties() async {
    final list = await widget._propertyService.fetchProperties();
    if (mounted) {
      setState(() {
        _properties = list;
        _loading = false;
      });
    }
  }

  void _onPinTapped(PropertyModel property) {
    setState(() => _selectedPropertyId = property.id);
    _mapController.move(
      LatLng(property.lat, property.lng),
      _mapController.camera.zoom,
    );
    showModalBottomSheet<void>(
      context: context,
      isScrollControlled: true,
      backgroundColor: Colors.transparent,
      enableDrag: false,
      builder: (ctx) => Padding(
        padding: const EdgeInsets.fromLTRB(16, 0, 16, 24),
        child: SizedBox(
          height: 420,
          child: PropertyBottomSheetCard(
            property: property,
            onClose: () => Navigator.of(ctx).pop(),
            onFavoriteToggle: () {},
          ),
        ),
      ),
    ).whenComplete(() {
      if (mounted) setState(() => _selectedPropertyId = null);
    });
  }

  @override
  Widget build(BuildContext context) {
    return _MapBody(
      mapController: _mapController,
      properties: _properties,
      selectedPropertyId: _selectedPropertyId,
      onPinTapped: _onPinTapped,
      loading: _loading,
    );
  }
}

/// Ecrã completo do mapa (com barra própria). Usado quando se navega para o mapa noutra rota.
class MapScreen extends StatelessWidget {
  MapScreen({
    super.key,
    PropertyService? propertyService,
    this.onListTabTap,
  }) : _propertyService = propertyService ?? PropertyService();

  final PropertyService _propertyService;
  final VoidCallback? onListTabTap;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          MapContent(propertyService: _propertyService),
          Positioned(
            top: 0,
            left: 0,
            right: 0,
            child: TopMapFilters(
              showMapTabSelected: true,
              onListTabTap: () {
                onListTabTap?.call();
                Navigator.of(context).pop();
              },
            ),
          ),
        ],
      ),
    );
  }
}

class _MapBody extends StatelessWidget {
  const _MapBody({
    required this.mapController,
    required this.properties,
    required this.selectedPropertyId,
    required this.onPinTapped,
    required this.loading,
  });

  final MapController mapController;
  final List<PropertyModel> properties;
  final String? selectedPropertyId;
  final void Function(PropertyModel) onPinTapped;
  final bool loading;

  @override
  Widget build(BuildContext context) {
    // Esri World Street Map: etiquetas mais alinhadas com inglês internacional do que OSM cru em PT.
    return Stack(
      children: [
        FlutterMap(
          mapController: mapController,
          options: MapOptions(
            initialCenter: _initialCenter,
            initialZoom: _initialZoom,
            interactionOptions: const InteractionOptions(
              flags: InteractiveFlag.all,
            ),
          ),
          children: [
            TileLayer(
              urlTemplate:
                  'https://server.arcgisonline.com/ArcGIS/rest/services/World_Street_Map/MapServer/tile/{z}/{y}/{x}',
              userAgentPackageName: 'com.casagpt.app',
            ),
            if (!loading)
              MarkerLayer(
                markers: properties
                    .map(
                      (p) => Marker(
                        point: LatLng(p.lat, p.lng),
                        width: 110,
                        height: 58,
                        alignment: Alignment.center,
                        child: CustomPinWidget(
                          property: p,
                          isSelected: selectedPropertyId == p.id,
                          onTap: () => onPinTapped(p),
                        ),
                      ),
                    )
                    .toList(),
              ),
          ],
        ),
        if (loading)
          const Center(
            child: CircularProgressIndicator(color: AppColors.purple600),
          ),
        Positioned(
          left: 8,
          bottom: 8,
          child: Material(
            color: Colors.white.withValues(alpha: 0.85),
            borderRadius: BorderRadius.circular(4),
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 6, vertical: 4),
              child: Text(
                '© Esri, OSM',
                style: Theme.of(context).textTheme.labelSmall?.copyWith(
                      fontSize: 10,
                      color: Colors.black54,
                    ),
              ),
            ),
          ),
        ),
      ],
    );
  }
}

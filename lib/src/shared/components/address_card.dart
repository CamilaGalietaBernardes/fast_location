import 'package:flutter/material.dart';
import 'package:map_launcher/map_launcher.dart';
import '../../models/address_model.dart';
import '../colors/app_colors.dart';
import '../metrics/app_metrics.dart';

class AddressCard extends StatelessWidget {
  final AddressModel address;

  const AddressCard({super.key, required this.address});

  Future<void> _openMap(BuildContext context) async {
    try {
      final maps = await MapLauncher.installedMaps;
      if (maps.isEmpty) {
        if (context.mounted) {
          ScaffoldMessenger.of(context).showSnackBar(
            const SnackBar(content: Text('Nenhum aplicativo de mapa encontrado.')),
          );
        }
        return;
      }

      final query =
          '${address.logradouro}, ${address.bairro}, ${address.localidade}, ${address.uf}, Brasil';

      if (context.mounted) {
        showModalBottomSheet(
          context: context,
          builder: (_) => SafeArea(
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: maps
                  .map(
                    (map) => ListTile(
                      leading: Image.asset(
                        map.icon,
                        width: 30,
                        height: 30,
                      ),
                      title: Text(map.mapName),
                      onTap: () {
                        Navigator.pop(context);
                        map.showDirections(
                          destination: Coords(0, 0),
                          destinationTitle: query,
                        );
                      },
                    ),
                  )
                  .toList(),
            ),
          ),
        );
      }
    } catch (_) {
      if (context.mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text('Erro ao abrir o mapa.')),
        );
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: AppMetrics.elevationLow,
      color: AppColors.surface,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(AppMetrics.radiusMedium),
      ),
      child: Padding(
        padding: const EdgeInsets.all(AppMetrics.paddingMedium),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            _buildRow(Icons.pin_drop, 'CEP', address.cep),
            _buildDivider(),
            _buildRow(Icons.location_on, 'Logradouro',
                address.logradouro.isNotEmpty ? address.logradouro : '—'),
            if (address.complemento.isNotEmpty) ...[
              _buildDivider(),
              _buildRow(Icons.info_outline, 'Complemento', address.complemento),
            ],
            _buildDivider(),
            _buildRow(Icons.map, 'Bairro',
                address.bairro.isNotEmpty ? address.bairro : '—'),
            _buildDivider(),
            _buildRow(Icons.location_city, 'Cidade', address.localidade),
            _buildDivider(),
            _buildRow(Icons.flag, 'Estado', address.uf),
            _buildDivider(),
            _buildRow(Icons.phone, 'DDD', address.ddd),
            const SizedBox(height: AppMetrics.paddingMedium),
            Align(
              alignment: Alignment.centerRight,
              child: TextButton.icon(
                onPressed: () => _openMap(context),
                icon: const Icon(Icons.directions, color: AppColors.primary),
                label: const Text(
                  'Ver no mapa',
                  style: TextStyle(color: AppColors.primary),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildRow(IconData icon, String label, String value) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: AppMetrics.paddingXSmall),
      child: Row(
        children: [
          Icon(icon, size: AppMetrics.iconSmall, color: AppColors.primary),
          const SizedBox(width: AppMetrics.paddingSmall),
          Text(
            '$label: ',
            style: const TextStyle(
              fontWeight: FontWeight.w600,
              fontSize: AppMetrics.fontMedium,
              color: AppColors.textSecondary,
            ),
          ),
          Expanded(
            child: Text(
              value,
              style: const TextStyle(
                fontSize: AppMetrics.fontMedium,
                color: AppColors.textPrimary,
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildDivider() =>
      const Divider(height: 1, color: AppColors.divider);
}

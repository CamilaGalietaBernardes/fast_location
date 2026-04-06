import 'package:flutter/material.dart';
import '../../routes/app_routes.dart';
import '../../shared/colors/app_colors.dart';
import '../../shared/metrics/app_metrics.dart';

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.background,
      appBar: AppBar(
        title: const Text('FastLocation'),
        backgroundColor: AppColors.primary,
        foregroundColor: AppColors.surface,
        elevation: AppMetrics.elevationLow,
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(AppMetrics.paddingLarge),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Image.asset(
              'assets/images/logo.png',
              height: 100,
              errorBuilder: (_, __, ___) => const Icon(
                Icons.local_shipping,
                size: 100,
                color: AppColors.primary,
              ),
            ),
            const SizedBox(height: AppMetrics.paddingXLarge),
            const Text(
              'O que deseja consultar?',
              style: TextStyle(
                fontSize: AppMetrics.fontXLarge,
                fontWeight: FontWeight.w600,
                color: AppColors.textPrimary,
              ),
            ),
            const SizedBox(height: AppMetrics.paddingLarge),
            _MenuCard(
              icon: Icons.search,
              title: 'Buscar por CEP',
              subtitle: 'Informe o CEP e consulte o endereço completo',
              onTap: () => Navigator.pushNamed(context, AppRoutes.searchByCep),
            ),
            const SizedBox(height: AppMetrics.paddingMedium),
            _MenuCard(
              icon: Icons.location_on,
              title: 'Buscar por Endereço',
              subtitle: 'Informe o endereço e encontre o CEP',
              onTap: () =>
                  Navigator.pushNamed(context, AppRoutes.searchByAddress),
            ),
            const SizedBox(height: AppMetrics.paddingMedium),
            _MenuCard(
              icon: Icons.history,
              title: 'Histórico',
              subtitle: 'Consultas realizadas anteriormente',
              onTap: () => Navigator.pushNamed(context, AppRoutes.history),
            ),
          ],
        ),
      ),
    );
  }
}

class _MenuCard extends StatelessWidget {
  final IconData icon;
  final String title;
  final String subtitle;
  final VoidCallback onTap;

  const _MenuCard({
    required this.icon,
    required this.title,
    required this.subtitle,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: AppMetrics.elevationLow,
      color: AppColors.surface,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(AppMetrics.radiusMedium),
      ),
      child: ListTile(
        contentPadding: const EdgeInsets.symmetric(
          horizontal: AppMetrics.paddingMedium,
          vertical: AppMetrics.paddingSmall,
        ),
        leading: CircleAvatar(
          backgroundColor: AppColors.primaryLight,
          child: Icon(icon, color: AppColors.surface),
        ),
        title: Text(
          title,
          style: const TextStyle(
            fontWeight: FontWeight.w600,
            color: AppColors.textPrimary,
          ),
        ),
        subtitle: Text(
          subtitle,
          style: const TextStyle(color: AppColors.textSecondary),
        ),
        trailing: const Icon(Icons.chevron_right, color: AppColors.primary),
        onTap: onTap,
      ),
    );
  }
}

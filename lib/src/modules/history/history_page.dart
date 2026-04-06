import 'package:flutter/material.dart';
import '../../shared/colors/app_colors.dart';
import '../../shared/metrics/app_metrics.dart';
import '../../shared/storage/storage_service.dart';

class HistoryPage extends StatefulWidget {
  const HistoryPage({super.key});

  @override
  State<HistoryPage> createState() => _HistoryPageState();
}

class _HistoryPageState extends State<HistoryPage> {
  final _storage = StorageService();

  Future<void> _clearHistory() async {
    final confirm = await showDialog<bool>(
      context: context,
      builder: (_) => AlertDialog(
        title: const Text('Limpar histórico'),
        content: const Text('Deseja remover todas as consultas salvas?'),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context, false),
            child: const Text('Cancelar'),
          ),
          TextButton(
            onPressed: () => Navigator.pop(context, true),
            child: const Text(
              'Limpar',
              style: TextStyle(color: AppColors.error),
            ),
          ),
        ],
      ),
    );
    if (confirm == true) {
      await _storage.clearHistory();
      setState(() {});
    }
  }

  @override
  Widget build(BuildContext context) {
    final history = _storage.getHistory();

    return Scaffold(
      backgroundColor: AppColors.background,
      appBar: AppBar(
        title: const Text('Histórico'),
        backgroundColor: AppColors.primary,
        foregroundColor: AppColors.surface,
        actions: [
          if (history.isNotEmpty)
            IconButton(
              icon: const Icon(Icons.delete_sweep),
              tooltip: 'Limpar histórico',
              onPressed: _clearHistory,
            ),
        ],
      ),
      body: history.isEmpty
          ? const Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Icon(Icons.history,
                      size: AppMetrics.iconLarge, color: AppColors.divider),
                  SizedBox(height: AppMetrics.paddingMedium),
                  Text(
                    'Nenhuma consulta realizada ainda.',
                    style: TextStyle(color: AppColors.textSecondary),
                  ),
                ],
              ),
            )
          : ListView.separated(
              padding: const EdgeInsets.all(AppMetrics.paddingMedium),
              itemCount: history.length,
              separatorBuilder: (_, __) =>
                  const SizedBox(height: AppMetrics.paddingSmall),
              itemBuilder: (context, index) {
                final item = history[index];
                return Card(
                  elevation: AppMetrics.elevationLow,
                  color: AppColors.surface,
                  shape: RoundedRectangleBorder(
                    borderRadius:
                        BorderRadius.circular(AppMetrics.radiusMedium),
                  ),
                  child: ListTile(
                    leading: const CircleAvatar(
                      backgroundColor: AppColors.primaryLight,
                      child: Icon(Icons.pin_drop, color: AppColors.surface),
                    ),
                    title: Text(
                      'CEP: ${item.cep}',
                      style: const TextStyle(fontWeight: FontWeight.w600),
                    ),
                    subtitle: Text(
                      item.fullAddress,
                      style:
                          const TextStyle(color: AppColors.textSecondary),
                    ),
                    trailing: Text(
                      '${item.consultedAt.day.toString().padLeft(2, '0')}/'
                      '${item.consultedAt.month.toString().padLeft(2, '0')}/'
                      '${item.consultedAt.year}',
                      style: const TextStyle(
                          fontSize: AppMetrics.fontSmall,
                          color: AppColors.textSecondary),
                    ),
                  ),
                );
              },
            ),
    );
  }
}

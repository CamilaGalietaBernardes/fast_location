import 'package:flutter/material.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import '../../services/viacep_service.dart';
import '../../shared/colors/app_colors.dart';
import '../../shared/components/address_card.dart';
import '../../shared/components/custom_button.dart';
import '../../shared/components/custom_text_field.dart';
import '../../shared/metrics/app_metrics.dart';
import '../../shared/storage/storage_service.dart';
import 'cep_store.dart';

class CepPage extends StatefulWidget {
  const CepPage({super.key});

  @override
  State<CepPage> createState() => _CepPageState();
}

class _CepPageState extends State<CepPage> {
  late final CepStore _store;
  final _formKey = GlobalKey<FormState>();
  final _cepController = TextEditingController();

  @override
  void initState() {
    super.initState();
    _store = CepStore(ViaCepService(), StorageService());
  }

  @override
  void dispose() {
    _cepController.dispose();
    super.dispose();
  }

  String? _validateCep(String? value) {
    if (value == null || value.isEmpty) return 'Informe o CEP.';
    final digits = value.replaceAll(RegExp(r'[^0-9]'), '');
    if (digits.length != 8) return 'CEP deve ter 8 dígitos.';
    return null;
  }

  void _search() {
    if (_formKey.currentState?.validate() ?? false) {
      FocusScope.of(context).unfocus();
      _store.searchByCep(_cepController.text.trim());
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.background,
      appBar: AppBar(
        title: const Text('Buscar por CEP'),
        backgroundColor: AppColors.primary,
        foregroundColor: AppColors.surface,
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(AppMetrics.paddingMedium),
        child: Form(
          key: _formKey,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Text(
                'Digite o CEP para consultar o endereço:',
                style: TextStyle(
                  color: AppColors.textSecondary,
                  fontSize: AppMetrics.fontMedium,
                ),
              ),
              const SizedBox(height: AppMetrics.paddingMedium),
              CustomTextField(
                controller: _cepController,
                label: 'CEP',
                hint: '00000-000',
                keyboardType: TextInputType.number,
                maxLength: 9,
                prefixIcon: const Icon(Icons.pin_drop, color: AppColors.primary),
                validator: _validateCep,
              ),
              const SizedBox(height: AppMetrics.paddingMedium),
              Observer(
                builder: (_) => CustomButton(
                  label: 'Buscar',
                  icon: Icons.search,
                  isLoading: _store.isLoading,
                  onPressed: _search,
                ),
              ),
              const SizedBox(height: AppMetrics.paddingLarge),
              Observer(
                builder: (_) {
                  if (_store.errorMessage != null) {
                    return Center(
                      child: Column(
                        children: [
                          const Icon(Icons.error_outline,
                              color: AppColors.error, size: AppMetrics.iconLarge),
                          const SizedBox(height: AppMetrics.paddingSmall),
                          Text(
                            _store.errorMessage!,
                            style: const TextStyle(color: AppColors.error),
                            textAlign: TextAlign.center,
                          ),
                        ],
                      ),
                    );
                  }
                  if (_store.address != null) {
                    return AddressCard(address: _store.address!);
                  }
                  return const SizedBox.shrink();
                },
              ),
            ],
          ),
        ),
      ),
    );
  }
}

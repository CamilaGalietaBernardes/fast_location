import 'package:flutter/material.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import '../../services/viacep_service.dart';
import '../../shared/colors/app_colors.dart';
import '../../shared/components/address_card.dart';
import '../../shared/components/custom_button.dart';
import '../../shared/components/custom_text_field.dart';
import '../../shared/metrics/app_metrics.dart';
import 'address_store.dart';

class AddressPage extends StatefulWidget {
  const AddressPage({super.key});

  @override
  State<AddressPage> createState() => _AddressPageState();
}

class _AddressPageState extends State<AddressPage> {
  late final AddressStore _store;
  final _formKey = GlobalKey<FormState>();
  final _ufController = TextEditingController();
  final _cidadeController = TextEditingController();
  final _logradouroController = TextEditingController();

  @override
  void initState() {
    super.initState();
    _store = AddressStore(ViaCepService());
  }

  @override
  void dispose() {
    _ufController.dispose();
    _cidadeController.dispose();
    _logradouroController.dispose();
    super.dispose();
  }

  String? _required(String? value, String field) {
    if (value == null || value.trim().isEmpty) return 'Informe $field.';
    return null;
  }

  String? _validateUf(String? value) {
    if (value == null || value.trim().isEmpty) return 'Informe a UF.';
    if (value.trim().length != 2) return 'UF deve ter 2 letras (ex: SP).';
    return null;
  }

  void _search() {
    if (_formKey.currentState?.validate() ?? false) {
      FocusScope.of(context).unfocus();
      _store.searchByAddress(
        uf: _ufController.text.trim().toUpperCase(),
        cidade: _cidadeController.text.trim(),
        logradouro: _logradouroController.text.trim(),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.background,
      appBar: AppBar(
        title: const Text('Buscar por Endereço'),
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
                'Preencha os campos para encontrar o CEP:',
                style: TextStyle(
                  color: AppColors.textSecondary,
                  fontSize: AppMetrics.fontMedium,
                ),
              ),
              const SizedBox(height: AppMetrics.paddingMedium),
              CustomTextField(
                controller: _ufController,
                label: 'UF',
                hint: 'Ex: SP',
                maxLength: 2,
                prefixIcon: const Icon(Icons.flag, color: AppColors.primary),
                validator: _validateUf,
              ),
              const SizedBox(height: AppMetrics.paddingMedium),
              CustomTextField(
                controller: _cidadeController,
                label: 'Cidade',
                hint: 'Ex: São Paulo',
                prefixIcon:
                    const Icon(Icons.location_city, color: AppColors.primary),
                validator: (v) => _required(v, 'a cidade'),
              ),
              const SizedBox(height: AppMetrics.paddingMedium),
              CustomTextField(
                controller: _logradouroController,
                label: 'Logradouro',
                hint: 'Ex: Avenida Paulista',
                prefixIcon:
                    const Icon(Icons.location_on, color: AppColors.primary),
                validator: (v) => _required(v, 'o logradouro'),
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
                              color: AppColors.error,
                              size: AppMetrics.iconLarge),
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
                  if (_store.results.isNotEmpty) {
                    return Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          '${_store.results.length} resultado(s) encontrado(s):',
                          style: const TextStyle(
                            fontWeight: FontWeight.w600,
                            color: AppColors.textSecondary,
                          ),
                        ),
                        const SizedBox(height: AppMetrics.paddingSmall),
                        ..._store.results.map(
                          (addr) => Padding(
                            padding: const EdgeInsets.only(
                                bottom: AppMetrics.paddingSmall),
                            child: AddressCard(address: addr),
                          ),
                        ),
                      ],
                    );
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

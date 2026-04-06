import 'package:dio/dio.dart';
import '../models/address_model.dart';

class ViaCepService {
  final Dio _dio;

  ViaCepService()
      : _dio = Dio(
          BaseOptions(
            baseUrl: 'https://viacep.com.br/ws',
            connectTimeout: const Duration(seconds: 10),
            receiveTimeout: const Duration(seconds: 10),
          ),
        );

  /// Consulta endereço pelo CEP.
  Future<AddressModel> fetchByCep(String cep) async {
    final cleanCep = cep.replaceAll(RegExp(r'[^0-9]'), '');
    final response = await _dio.get('/$cleanCep/json/');
    final data = response.data as Map<String, dynamic>;
    if (data.containsKey('erro')) {
      throw Exception('CEP não encontrado.');
    }
    return AddressModel.fromJson(data);
  }

  /// Consulta CEPs por endereço (UF + cidade + logradouro).
  Future<List<AddressModel>> fetchByAddress({
    required String uf,
    required String cidade,
    required String logradouro,
  }) async {
    final response =
        await _dio.get('/$uf/$cidade/$logradouro/json/');
    final List<dynamic> data = response.data as List<dynamic>;
    return data
        .map((json) => AddressModel.fromJson(json as Map<String, dynamic>))
        .toList();
  }
}

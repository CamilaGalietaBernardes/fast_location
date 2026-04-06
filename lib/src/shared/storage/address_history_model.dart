import 'package:hive/hive.dart';

part 'address_history_model.g.dart';

@HiveType(typeId: 0)
class AddressHistoryModel extends HiveObject {
  @HiveField(0)
  final String cep;

  @HiveField(1)
  final String logradouro;

  @HiveField(2)
  final String bairro;

  @HiveField(3)
  final String localidade;

  @HiveField(4)
  final String uf;

  @HiveField(5)
  final DateTime consultedAt;

  AddressHistoryModel({
    required this.cep,
    required this.logradouro,
    required this.bairro,
    required this.localidade,
    required this.uf,
    required this.consultedAt,
  });

  String get fullAddress =>
      '$logradouro, $bairro - $localidade/$uf - CEP: $cep';
}

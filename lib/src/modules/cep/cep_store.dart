import 'package:mobx/mobx.dart';
import '../../models/address_model.dart';
import '../../services/viacep_service.dart';
import '../../shared/storage/address_history_model.dart';
import '../../shared/storage/storage_service.dart';

part 'cep_store.g.dart';

// ignore: library_private_types_in_public_api
class CepStore = _CepStore with _$CepStore;

abstract class _CepStore with Store {
  final ViaCepService _service;
  final StorageService _storage;

  _CepStore(this._service, this._storage);

  @observable
  AddressModel? address;

  @observable
  bool isLoading = false;

  @observable
  String? errorMessage;

  @action
  Future<void> searchByCep(String cep) async {
    isLoading = true;
    errorMessage = null;
    address = null;

    try {
      address = await _service.fetchByCep(cep);
      await _storage.saveAddress(
        AddressHistoryModel(
          cep: address!.cep,
          logradouro: address!.logradouro,
          bairro: address!.bairro,
          localidade: address!.localidade,
          uf: address!.uf,
          consultedAt: DateTime.now(),
        ),
      );
    } catch (e) {
      errorMessage = e.toString().replaceFirst('Exception: ', '');
    } finally {
      isLoading = false;
    }
  }

  @action
  void clear() {
    address = null;
    errorMessage = null;
  }
}

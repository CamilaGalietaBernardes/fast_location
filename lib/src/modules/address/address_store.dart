import 'package:mobx/mobx.dart';
import '../../models/address_model.dart';
import '../../services/viacep_service.dart';

part 'address_store.g.dart';

// ignore: library_private_types_in_public_api
class AddressStore = _AddressStore with _$AddressStore;

abstract class _AddressStore with Store {
  final ViaCepService _service;

  _AddressStore(this._service);

  @observable
  ObservableList<AddressModel> results = ObservableList<AddressModel>();

  @observable
  bool isLoading = false;

  @observable
  String? errorMessage;

  @action
  Future<void> searchByAddress({
    required String uf,
    required String cidade,
    required String logradouro,
  }) async {
    isLoading = true;
    errorMessage = null;
    results.clear();

    try {
      final list = await _service.fetchByAddress(
        uf: uf,
        cidade: cidade,
        logradouro: logradouro,
      );
      if (list.isEmpty) {
        errorMessage = 'Nenhum endereço encontrado.';
      } else {
        results.addAll(list);
      }
    } catch (e) {
      errorMessage = e.toString().replaceFirst('Exception: ', '');
    } finally {
      isLoading = false;
    }
  }

  @action
  void clear() {
    results.clear();
    errorMessage = null;
  }
}

// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'address_store.dart';

// **************************************************************************
// StoreGenerator
// **************************************************************************

// ignore_for_file: non_constant_identifier_names, unnecessary_brace_in_string_interps, unnecessary_lambdas, prefer_expression_function_bodies, lines_longer_than_80_chars, avoid_as, avoid_annotating_with_dynamic, no_leading_underscores_for_local_identifiers

mixin _$AddressStore on _AddressStore, Store {
  late final _$resultsAtom =
      Atom(name: '_AddressStore.results', context: context);

  @override
  ObservableList<AddressModel> get results {
    _$resultsAtom.reportRead();
    return super.results;
  }

  @override
  set results(ObservableList<AddressModel> value) {
    _$resultsAtom.reportWrite(value, super.results, () {
      super.results = value;
    });
  }

  late final _$isLoadingAtom =
      Atom(name: '_AddressStore.isLoading', context: context);

  @override
  bool get isLoading {
    _$isLoadingAtom.reportRead();
    return super.isLoading;
  }

  @override
  set isLoading(bool value) {
    _$isLoadingAtom.reportWrite(value, super.isLoading, () {
      super.isLoading = value;
    });
  }

  late final _$errorMessageAtom =
      Atom(name: '_AddressStore.errorMessage', context: context);

  @override
  String? get errorMessage {
    _$errorMessageAtom.reportRead();
    return super.errorMessage;
  }

  @override
  set errorMessage(String? value) {
    _$errorMessageAtom.reportWrite(value, super.errorMessage, () {
      super.errorMessage = value;
    });
  }

  late final _$searchByAddressAsyncAction =
      AsyncAction('_AddressStore.searchByAddress', context: context);

  @override
  Future<void> searchByAddress(
      {required String uf,
      required String cidade,
      required String logradouro}) {
    return _$searchByAddressAsyncAction.run(() =>
        super.searchByAddress(uf: uf, cidade: cidade, logradouro: logradouro));
  }

  late final _$_AddressStoreActionController =
      ActionController(name: '_AddressStore', context: context);

  @override
  void clear() {
    final _$actionInfo = _$_AddressStoreActionController.startAction(
        name: '_AddressStore.clear');
    try {
      return super.clear();
    } finally {
      _$_AddressStoreActionController.endAction(_$actionInfo);
    }
  }

  @override
  String toString() {
    return '''
results: ${results},
isLoading: ${isLoading},
errorMessage: ${errorMessage}
    ''';
  }
}

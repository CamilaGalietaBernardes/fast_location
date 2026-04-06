// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'cep_store.dart';

// **************************************************************************
// StoreGenerator
// **************************************************************************

// ignore_for_file: non_constant_identifier_names, unnecessary_brace_in_string_interps, unnecessary_lambdas, prefer_expression_function_bodies, lines_longer_than_80_chars, avoid_as, avoid_annotating_with_dynamic, no_leading_underscores_for_local_identifiers

mixin _$CepStore on _CepStore, Store {
  late final _$addressAtom = Atom(name: '_CepStore.address', context: context);

  @override
  AddressModel? get address {
    _$addressAtom.reportRead();
    return super.address;
  }

  @override
  set address(AddressModel? value) {
    _$addressAtom.reportWrite(value, super.address, () {
      super.address = value;
    });
  }

  late final _$isLoadingAtom =
      Atom(name: '_CepStore.isLoading', context: context);

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
      Atom(name: '_CepStore.errorMessage', context: context);

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

  late final _$searchByCepAsyncAction =
      AsyncAction('_CepStore.searchByCep', context: context);

  @override
  Future<void> searchByCep(String cep) {
    return _$searchByCepAsyncAction.run(() => super.searchByCep(cep));
  }

  late final _$_CepStoreActionController =
      ActionController(name: '_CepStore', context: context);

  @override
  void clear() {
    final _$actionInfo =
        _$_CepStoreActionController.startAction(name: '_CepStore.clear');
    try {
      return super.clear();
    } finally {
      _$_CepStoreActionController.endAction(_$actionInfo);
    }
  }

  @override
  String toString() {
    return '''
address: ${address},
isLoading: ${isLoading},
errorMessage: ${errorMessage}
    ''';
  }
}

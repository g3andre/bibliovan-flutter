// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'acervo_base.dart';

// **************************************************************************
// StoreGenerator
// **************************************************************************

// ignore_for_file: non_constant_identifier_names, unnecessary_lambdas, prefer_expression_function_bodies, lines_longer_than_80_chars, avoid_as, avoid_annotating_with_dynamic

mixin _$AcervoStore on _AcervoStoreBase, Store {
  final _$responseManagmentAtom =
      Atom(name: '_AcervoStoreBase.responseManagment');

  @override
  ResponseManagment<List<Acervo>> get responseManagment {
    _$responseManagmentAtom.context.enforceReadPolicy(_$responseManagmentAtom);
    _$responseManagmentAtom.reportObserved();
    return super.responseManagment;
  }

  @override
  set responseManagment(ResponseManagment<List<Acervo>> value) {
    _$responseManagmentAtom.context.conditionallyRunInAction(() {
      super.responseManagment = value;
      _$responseManagmentAtom.reportChanged();
    }, _$responseManagmentAtom, name: '${_$responseManagmentAtom.name}_set');
  }

  final _$getListAcervoAsyncAction = AsyncAction('getListAcervo');

  @override
  Future getListAcervo() {
    return _$getListAcervoAsyncAction.run(() => super.getListAcervo());
  }

  @override
  String toString() {
    final string = 'responseManagment: ${responseManagment.toString()}';
    return '{$string}';
  }
}

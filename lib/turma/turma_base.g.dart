// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'turma_base.dart';

// **************************************************************************
// StoreGenerator
// **************************************************************************

// ignore_for_file: non_constant_identifier_names, unnecessary_lambdas, prefer_expression_function_bodies, lines_longer_than_80_chars, avoid_as, avoid_annotating_with_dynamic

mixin _$TurmaBase on _TurmaBaseBase, Store {
  final _$responseManagmentAtom =
      Atom(name: '_TurmaBaseBase.responseManagment');

  @override
  ResponseManagment<List<Turma>> get responseManagment {
    _$responseManagmentAtom.context.enforceReadPolicy(_$responseManagmentAtom);
    _$responseManagmentAtom.reportObserved();
    return super.responseManagment;
  }

  @override
  set responseManagment(ResponseManagment<List<Turma>> value) {
    _$responseManagmentAtom.context.conditionallyRunInAction(() {
      super.responseManagment = value;
      _$responseManagmentAtom.reportChanged();
    }, _$responseManagmentAtom, name: '${_$responseManagmentAtom.name}_set');
  }

  final _$getTurmaListAsyncAction = AsyncAction('getTurmaList');

  @override
  Future getTurmaList() {
    return _$getTurmaListAsyncAction.run(() => super.getTurmaList());
  }

  @override
  String toString() {
    final string = 'responseManagment: ${responseManagment.toString()}';
    return '{$string}';
  }
}

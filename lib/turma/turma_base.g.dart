// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'turma_base.dart';

// **************************************************************************
// StoreGenerator
// **************************************************************************

// ignore_for_file: non_constant_identifier_names, unnecessary_lambdas, prefer_expression_function_bodies, lines_longer_than_80_chars, avoid_as, avoid_annotating_with_dynamic

mixin _$TurmaBase on _TurmaBaseBase, Store {
  final _$turmaAtom = Atom(name: '_TurmaBaseBase.turma');

  @override
  Turma get turma {
    _$turmaAtom.context.enforceReadPolicy(_$turmaAtom);
    _$turmaAtom.reportObserved();
    return super.turma;
  }

  @override
  set turma(Turma value) {
    _$turmaAtom.context.conditionallyRunInAction(() {
      super.turma = value;
      _$turmaAtom.reportChanged();
    }, _$turmaAtom, name: '${_$turmaAtom.name}_set');
  }

  final _$turmasAtom = Atom(name: '_TurmaBaseBase.turmas');

  @override
  List<Turma> get turmas {
    _$turmasAtom.context.enforceReadPolicy(_$turmasAtom);
    _$turmasAtom.reportObserved();
    return super.turmas;
  }

  @override
  set turmas(List<Turma> value) {
    _$turmasAtom.context.conditionallyRunInAction(() {
      super.turmas = value;
      _$turmasAtom.reportChanged();
    }, _$turmasAtom, name: '${_$turmasAtom.name}_set');
  }

  final _$getTurmaListAsyncAction = AsyncAction('getTurmaList');

  @override
  Future getTurmaList() {
    return _$getTurmaListAsyncAction.run(() => super.getTurmaList());
  }

  final _$getTurmaByIdAsyncAction = AsyncAction('getTurmaById');

  @override
  Future getTurmaById(int id) {
    return _$getTurmaByIdAsyncAction.run(() => super.getTurmaById(id));
  }

  @override
  String toString() {
    final string = 'turma: ${turma.toString()},turmas: ${turmas.toString()}';
    return '{$string}';
  }
}

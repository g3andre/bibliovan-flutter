// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'usuario_base.dart';

// **************************************************************************
// StoreGenerator
// **************************************************************************

// ignore_for_file: non_constant_identifier_names, unnecessary_lambdas, prefer_expression_function_bodies, lines_longer_than_80_chars, avoid_as, avoid_annotating_with_dynamic

mixin _$UsuarioBase on _UsuarioBaseBase, Store {
  final _$usuarioAtom = Atom(name: '_UsuarioBaseBase.usuario');

  @override
  Usuario get usuario {
    _$usuarioAtom.context.enforceReadPolicy(_$usuarioAtom);
    _$usuarioAtom.reportObserved();
    return super.usuario;
  }

  @override
  set usuario(Usuario value) {
    _$usuarioAtom.context.conditionallyRunInAction(() {
      super.usuario = value;
      _$usuarioAtom.reportChanged();
    }, _$usuarioAtom, name: '${_$usuarioAtom.name}_set');
  }

  final _$listUsuarioAtom = Atom(name: '_UsuarioBaseBase.listUsuario');

  @override
  List<Usuario> get listUsuario {
    _$listUsuarioAtom.context.enforceReadPolicy(_$listUsuarioAtom);
    _$listUsuarioAtom.reportObserved();
    return super.listUsuario;
  }

  @override
  set listUsuario(List<Usuario> value) {
    _$listUsuarioAtom.context.conditionallyRunInAction(() {
      super.listUsuario = value;
      _$listUsuarioAtom.reportChanged();
    }, _$listUsuarioAtom, name: '${_$listUsuarioAtom.name}_set');
  }

  final _$updateUsuarioAsyncAction = AsyncAction('updateUsuario');

  @override
  Future updateUsuario(int id) {
    return _$updateUsuarioAsyncAction.run(() => super.updateUsuario(id));
  }

  final _$updateListUsuarioAsyncAction = AsyncAction('updateListUsuario');

  @override
  Future updateListUsuario(Turma turma) {
    return _$updateListUsuarioAsyncAction
        .run(() => super.updateListUsuario(turma));
  }

  @override
  String toString() {
    final string =
        'usuario: ${usuario.toString()},listUsuario: ${listUsuario.toString()}';
    return '{$string}';
  }
}

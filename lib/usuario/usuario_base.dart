import 'package:bibliovan/turma/turma.dart';
import 'package:bibliovan/usuario/api_usuario.dart';
import 'package:bibliovan/usuario/usuario.dart';
import 'package:mobx/mobx.dart';
part 'usuario_base.g.dart';

class UsuarioBase = _UsuarioBaseBase with _$UsuarioBase;

abstract class _UsuarioBaseBase with Store {
  @observable
  Usuario usuario;

  @observable
  List<Usuario> listUsuario;

  @action
  updateUsuario(int id) async {
    if (id > 0) {
      usuario = await ApiUsuario.getUsuarioById(id);
    }
  }

  @action
  updateListUsuario(Turma turma) async {
    if (turma == null || turma.id < 0) {
      listUsuario = await ApiUsuario.getAll();
    } else {
      listUsuario = await ApiUsuario.getUsuariosByTurma(turma);
    }
  }
}

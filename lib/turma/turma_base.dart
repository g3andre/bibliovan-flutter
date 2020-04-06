import 'package:bibliovan/turma/turma.dart';
import 'package:bibliovan/turma/turma_api.dart';
import 'package:mobx/mobx.dart';
part 'turma_base.g.dart';

class TurmaBase = _TurmaBaseBase with _$TurmaBase;

abstract class _TurmaBaseBase with Store {
  @observable
  Turma turma;

  @observable
  List<Turma> turmas;

  @action
  getTurmaList() async {
    turmas = await TurmaApi.getAll();
  }

  @action
  getTurmaById(int id) async {
    turma = await TurmaApi.getTurmaById(id);
  }
}

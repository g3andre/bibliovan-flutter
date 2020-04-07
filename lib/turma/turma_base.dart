import 'package:bibliovan/turma/turma.dart';
import 'package:bibliovan/turma/turma_api.dart';
import 'package:bibliovan/utils/response_managment.dart';
import 'package:mobx/mobx.dart';
part 'turma_base.g.dart';

class TurmaBase = _TurmaBaseBase with _$TurmaBase;

abstract class _TurmaBaseBase with Store {
  @observable
  ResponseManagment<List<Turma>> responseManagment;
/*   @observable
  Turma turma;

  @observable
  String errorMessage;

  @observable
  List<Turma> turmas; */

  @action
  getTurmaList() async {
    responseManagment = await TurmaApi.getAll();
/*     if (responseManagment.hasError) {
      errorMessage = responseManagment.message;
    } else {
      turmas = responseManagment.resposeBody;
    } */
  }

/*   @action
  getTurmaById(int id) async {
    turma = await TurmaApi.getTurmaById(id);
  } */
}

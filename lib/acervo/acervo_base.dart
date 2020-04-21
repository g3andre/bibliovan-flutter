import 'package:bibliovan/acervo/acervo.dart';
import 'package:bibliovan/acervo/acervo_api.dart';
import 'package:bibliovan/utils/response_managment.dart';
import 'package:mobx/mobx.dart';
part 'acervo_base.g.dart';

class AcervoStore = _AcervoStoreBase with _$AcervoStore;

abstract class _AcervoStoreBase with Store {
  /* @observable
  ResponseManagment<Acervo> acervo; */

  @observable
  ResponseManagment<List<Acervo>> responseManagment;

  @action
  getListAcervo() async {
    this.responseManagment = await AcervoApi.getAll();
  }

  /*  @action
  void getAcervo(int id) async {
    this.acervo = await AcervoApi.getAcervoById(id);
  } */
}

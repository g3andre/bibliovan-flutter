import 'dart:convert';

import 'package:bibliovan/utils/api_utils.dart';
import 'package:http/http.dart' as http;
import 'package:bibliovan/turma/turma.dart';

class TurmaApi {
  static final String END_POINT = "${ApiUtils.URL_API}/turma";
  static Future<List<Turma>> getAll() async {
    List<Turma> turmas;
    try {
      var response = await http.get("${TurmaApi.END_POINT}");
      if (response.statusCode == StatusCode.OK) {
        List listTurmasResponse = json.decode(response.body);
        turmas =
            listTurmasResponse.map((turma) => Turma.fromMap(turma)).toList();
      }
    } catch (error, exception) {
      print(">>>>Erro: $error \t Exception: $exception");
    }
    return turmas;
  }

  static Future<Turma> saveTurma(Turma t) async {
    if (t.id == null) t.id = 0;

    Map<String, String> header = {"Content-Type": "application/json"};
    var jsonTurma = t.toJson();
    Turma resp;

    try {
      var response = await http.post(TurmaApi.END_POINT,
          body: jsonTurma, headers: Headers.APPLICATION_JSON);
      if (response.statusCode == StatusCode.CREATED) {
        resp = Turma.fromMap(json.decode(response.body));
      }

      return resp;
    } catch (error, exception) {
      print(">>> Error: $error \nException: $exception ");
    }
  }

  static Future<Turma> getTurmaById(int id) async {
    Turma turma;
    try {
      var response = await http.get("${TurmaApi.END_POINT}/${id}");
      if (response.statusCode == StatusCode.OK) {
        turma = Turma.fromJson(json.decode(response.body));
      }
      return turma;
    } catch (error, exception) {}
  }
}
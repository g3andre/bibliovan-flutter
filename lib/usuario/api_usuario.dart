import 'dart:convert';

import 'package:bibliovan/turma/turma.dart';
import 'package:http/http.dart' as http;
import 'package:bibliovan/usuario/usuario.dart';
import 'package:bibliovan/utils/api_utils.dart';

class ApiUsuario {
  static final _URL_ENDPOINT = "${ApiUtils.URL_API}/usuario";

  static Future<List<Usuario>> getAll() async {
    List<Usuario> usuarios;
    try {
      var response = await http.get("${ApiUsuario._URL_ENDPOINT}");

      if (response.statusCode == StatusCode.OK) {
        print("JSON >>>>>>>>> ${json.decode(response.body)}");
        List responseListJson = json.decode(response.body);
        usuarios =
            responseListJson.map((item) => Usuario.fromMap(item)).toList();
        //print(Usuario.fromMap(response.body));
        /* List responseJson = json.decode(response.body);
        usuarios = responseJson.map((item) => Usuario.fromJson(item)).toList(); */
      }
    } catch (error, exception) {
      print("ERRO: *************************\n$error\n$exception");
    }

    return usuarios;
  }

  static Future<List<Usuario>> getUsuariosByTurma(Turma t) async {
    List<Usuario> listUsuarios;
    try {
      if (t != null && (t.id != null && t.id >= 0)) {
        //t = await TurmaApi.getTurmaById(t.id);
        var response = await http.get("$_URL_ENDPOINT/turma/${t.id}");
        if (response.statusCode == StatusCode.OK) {
          List listJson = json.decode(response.body);
          listUsuarios = listJson.map((item) => Usuario.fromMap(item)).toList();
        }
      }
      return listUsuarios;
    } catch (error, exception) {
      print("ERRO >>>>>>>>>>>>>>>>> \n$error \n $exception");
    }
  }

  static Future<Usuario> save(Usuario u) async {
    var response = await http.post(_URL_ENDPOINT,
        body: u.toJson(), headers: Headers.APPLICATION_JSON);

    if (response.statusCode == StatusCode.CREATED) {
      u = Usuario.fromMap(json.decode(response.body));
      return u;
    }

    return null;
  }

  static Future<Usuario> getUsuarioById(int id) async {
    if (id < 0) return null;

    Usuario usuario;

    try {
      String url = "$_URL_ENDPOINT/$id";
      var response = await http.get(url);

      if (response.statusCode == 200) {
        var parseJson = json.decode(response.body);
        usuario = Usuario.fromJson(parseJson);
      }

      return usuario;
    } catch (error, exception) {
      print(
          "ERROR >>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>> \n$error \n$exception");
    }
  }
}

import 'package:http/http.dart' as http;
import 'dart:convert';

import 'package:bibliovan/acervo/acervo.dart';
import 'package:bibliovan/utils/api_utils.dart';
import 'package:bibliovan/utils/response_managment.dart';

class AcervoApi {
  static final String API_URL = "${ApiUtils.URL_API}/acervo";

  static Future<ResponseManagment<List<Acervo>>> getAll() async {
    List<Acervo> listAcervo;
    ResponseManagment<List<Acervo>> responseManagment = ResponseManagment();
    try {
      var response = await http.get(API_URL);
      if (response.statusCode != StatusCode.OK) {
        responseManagment.hasError = true;
        responseManagment.message =
            "Não foi possivel recuperar o recurso solicitado";
        responseManagment.responseBody = null;
      } else {
        List parsed = json.decode(response.body);
        listAcervo = parsed.map((item) => Acervo.fromMap(item)).toList();

        responseManagment.hasError = false;
        responseManagment.message = "";
        responseManagment.responseBody = listAcervo;
      }
    } catch (error, exception) {
      responseManagment.hasError = true;
      responseManagment.message = "Erro: $error";
    }
    return responseManagment;
  }

  static Future<ResponseManagment<Acervo>> save(Acervo acervo) async {
    ResponseManagment<Acervo> responseManagment;
    try {
      var response = await http.post(API_URL,
          body: acervo.toJson(), headers: Headers.APPLICATION_JSON);

      if (response.statusCode == StatusCode.CREATED) {
        acervo = Acervo.fromMap(json.decode(response.body));
        responseManagment =
            ResponseManagment(hasError: false, responseBody: acervo);
      } else {
        responseManagment = ResponseManagment(
            hasError: true,
            message:
                "Não foi possivel persistir os dados: Erro ${response.statusCode}");
      }
    } catch (error, exception) {
      responseManagment = ResponseManagment(
          hasError: true, message: "Erro: $error", responseBody: null);
    }

    return responseManagment;
  }

  static Future<ResponseManagment<Acervo>> getAcervoById(int id) async {
    if (id < 0)
      return ResponseManagment(hasError: true, message: "Id inválido");

    Acervo acervo;
    ResponseManagment responseManagment;

    try {
      String url = "$API_URL/$id";
      var response = await http.get(url);

      if (response.statusCode == 200) {
        acervo = Acervo.fromJson(json.decode(response.body));
        responseManagment = ResponseManagment(responseBody: acervo);
      } else {
        responseManagment = ResponseManagment(
            hasError: true,
            message:
                "Não foi possível recuperar os dados: Erro ${response.statusCode}");
      }
    } catch (error, exception) {
      responseManagment = ResponseManagment(
          hasError: true, message: "Erro: $error", responseBody: null);
      print("ERROR >>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>> \n$exception");
    }

    return responseManagment;
  }

  static Future<ResponseManagment<Acervo>> deleteItemAcervo(int id) async {
    if (id < 0)
      return ResponseManagment(hasError: true, message: "Id inválido");
    ResponseManagment<Acervo> responseManagment;

    try {
      String url = "$API_URL/$id";
      var response = await http.delete(url);

      if (response.statusCode == StatusCode.NO_CONTENT) {
        responseManagment = ResponseManagment();
      } else {
        responseManagment = ResponseManagment(
            hasError: true,
            message: "Não foi possível excluir: Erro ${response.statusCode}");
      }
    } catch (error, exception) {
      responseManagment = ResponseManagment(
          hasError: true, message: "Erro: $error", responseBody: null);
      print("ERROR >>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>> \n$exception");
    }

    return responseManagment;
  }
}

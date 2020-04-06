import 'dart:convert';

import 'package:bibliovan/turma/turma.dart';

class Usuario {
  int id;
  String nome;
  String responsavel;
  String contato;
  String urlFoto;
  Turma turma;
  Usuario({
    this.id,
    this.nome,
    this.responsavel,
    this.contato,
    this.urlFoto,
    this.turma,
  });

  Usuario copyWith({
    int id,
    String nome,
    String responsavel,
    String contato,
    String urlFoto,
    Turma turma,
  }) {
    return Usuario(
      id: id ?? this.id,
      nome: nome ?? this.nome,
      responsavel: responsavel ?? this.responsavel,
      contato: contato ?? this.contato,
      urlFoto: urlFoto ?? this.urlFoto,
      turma: turma ?? this.turma,
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'nome': nome,
      'responsavel': responsavel,
      'contato': contato,
      'urlFoto': urlFoto,
      'turma': turma.toMap(),
    };
  }

  static Usuario fromMap(Map<String, dynamic> map) {
    if (map == null) return null;

    return Usuario(
      id: map['id']?.toInt(),
      nome: map['nome'],
      responsavel: map['responsavel'],
      contato: map['contato'],
      urlFoto: map['urlFoto'],
      turma: Turma.fromMap(map['turma']),
    );
  }

  String toJson() => json.encode(toMap());

  static Usuario fromJson(String source) => fromMap(json.decode(source));

  @override
  String toString() {
    return 'Usuario(id: $id, nome: $nome, responsavel: $responsavel, contato: $contato, urlFoto: $urlFoto, turma: $turma)';
  }

  @override
  bool operator ==(Object o) {
    if (identical(this, o)) return true;

    return o is Usuario &&
        o.id == id &&
        o.nome == nome &&
        o.responsavel == responsavel &&
        o.contato == contato &&
        o.urlFoto == urlFoto &&
        o.turma == turma;
  }

  @override
  int get hashCode {
    return id.hashCode ^
        nome.hashCode ^
        responsavel.hashCode ^
        contato.hashCode ^
        urlFoto.hashCode ^
        turma.hashCode;
  }
}

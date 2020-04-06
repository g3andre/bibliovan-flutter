import 'dart:convert';

class Turma {
  int id;
  String nome;
  String descricao;
  String professor;
  Turma({
    this.id,
    this.nome,
    this.descricao,
    this.professor,
  });

  Turma copyWith({
    int id,
    String nome,
    String descricao,
    String professor,
  }) {
    return Turma(
      id: id ?? this.id,
      nome: nome ?? this.nome,
      descricao: descricao ?? this.descricao,
      professor: professor ?? this.professor,
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'nome': nome,
      'descricao': descricao,
      'professor': professor,
    };
  }

  static Turma fromMap(Map<String, dynamic> map) {
    if (map == null) return null;

    return Turma(
      id: map['id']?.toInt(),
      nome: map['nome'],
      descricao: map['descricao'],
      professor: map['professor'],
    );
  }

  String toJson() => json.encode(toMap());

  static Turma fromJson(String source) => fromMap(json.decode(source));

  @override
  String toString() {
    return 'Turma(id: $id, nome: $nome, descricao: $descricao, professor: $professor)';
  }

  @override
  bool operator ==(Object o) {
    if (identical(this, o)) return true;

    return o is Turma &&
        o.id == id &&
        o.nome == nome &&
        o.descricao == descricao &&
        o.professor == professor;
  }

  @override
  int get hashCode {
    return id.hashCode ^
        nome.hashCode ^
        descricao.hashCode ^
        professor.hashCode;
  }
}

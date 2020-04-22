import 'dart:convert';

class Autor {
  final int id;
  final String nome;
  Autor({
    this.id,
    this.nome,
  });

  Autor copyWith({
    int id,
    String nome,
  }) {
    return Autor(
      id: id ?? this.id,
      nome: nome ?? this.nome,
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'nome': nome,
    };
  }

  static Autor fromMap(Map<String, dynamic> map) {
    if (map == null) return null;

    return Autor(
      id: map['id']?.toInt(),
      nome: map['nome'],
    );
  }

  String toJson() => json.encode(toMap());

  static Autor fromJson(String source) => fromMap(json.decode(source));

  @override
  String toString() => 'Autor(id: $id, nome: $nome)';

  @override
  bool operator ==(Object o) {
    if (identical(this, o)) return true;

    return o is Autor && o.id == id && o.nome == nome;
  }

  @override
  int get hashCode => id.hashCode ^ nome.hashCode;
}

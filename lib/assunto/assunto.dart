import 'dart:convert';

class Assunto {
  final int id;
  final String assunto;
  Assunto({
    this.id,
    this.assunto,
  });

  Assunto copyWith({
    int id,
    String assunto,
  }) {
    return Assunto(
      id: id ?? this.id,
      assunto: assunto ?? this.assunto,
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'assunto': assunto,
    };
  }

  static Assunto fromMap(Map<String, dynamic> map) {
    if (map == null) return null;

    return Assunto(
      id: map['id']?.toInt(),
      assunto: map['assunto'],
    );
  }

  String toJson() => json.encode(toMap());

  static Assunto fromJson(String source) => fromMap(json.decode(source));

  @override
  String toString() => 'Assunto(id: $id, assunto: $assunto)';

  @override
  bool operator ==(Object o) {
    if (identical(this, o)) return true;

    return o is Assunto && o.id == id && o.assunto == assunto;
  }

  @override
  int get hashCode => id.hashCode ^ assunto.hashCode;
}

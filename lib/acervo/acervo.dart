import 'dart:convert';
import 'package:flutter/foundation.dart';

import 'package:bibliovan/assunto/assunto.dart';
import 'package:bibliovan/autor/autor.dart';

class Acervo {
  int id;
  String titulo;
  String isbn;
  List<Assunto> assunto;
  List<Autor> autor;
  Acervo({
    this.id,
    this.titulo,
    this.isbn,
    this.assunto,
    this.autor,
  }) {
    if (this.assunto == null) this.assunto = List<Assunto>();
    if (this.autor == null) this.autor = List<Autor>();
  }

  Acervo copyWith({
    int id,
    String titulo,
    String isbn,
    List<Assunto> assunto,
    List<Autor> autor,
  }) {
    return Acervo(
      id: id ?? this.id,
      titulo: titulo ?? this.titulo,
      isbn: isbn ?? this.isbn,
      assunto: assunto ?? this.assunto,
      autor: autor ?? this.autor,
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'titulo': titulo,
      'isbn': isbn,
      'assunto': List<dynamic>.from(assunto.map((x) => x.toMap())),
      'autor': List<dynamic>.from(autor.map((x) => x.toMap())),
    };
  }

  static Acervo fromMap(Map<String, dynamic> map) {
    if (map == null) return null;

    return Acervo(
      id: map['id']?.toInt(),
      titulo: map['titulo'],
      isbn: map['isbn'],
      assunto:
          List<Assunto>.from(map['assunto']?.map((x) => Assunto.fromMap(x))),
      autor: List<Autor>.from(map['autor']?.map((x) => Autor.fromMap(x))),
    );
  }

  String toJson() => json.encode(toMap());

  static Acervo fromJson(String source) => fromMap(json.decode(source));

  @override
  String toString() {
    return 'Acervo(id: $id, titulo: $titulo, isbn: $isbn, assunto: $assunto, autor: $autor)';
  }

  @override
  bool operator ==(Object o) {
    if (identical(this, o)) return true;

    return o is Acervo &&
        o.id == id &&
        o.titulo == titulo &&
        o.isbn == isbn &&
        listEquals(o.assunto, assunto) &&
        listEquals(o.autor, autor);
  }

  @override
  int get hashCode {
    return id.hashCode ^
        titulo.hashCode ^
        isbn.hashCode ^
        assunto.hashCode ^
        autor.hashCode;
  }
}

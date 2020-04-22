import 'package:bibliovan/turma/turma.dart';
import 'package:bibliovan/turma/turma_api.dart';
import 'package:bibliovan/widgets/button.dart';
import 'package:flutter/material.dart';

class CadastroTurma extends StatelessWidget {
  BuildContext _context;
  final _formState = GlobalKey<FormState>();
  final Turma _turma = Turma();
  @override
  Widget build(BuildContext context) {
    this._context = context;
    return Scaffold(
      appBar: AppBar(
        title: Text("Nova Turma"),
      ),
      body: _body(),
    );
  }

  _body() {
    return Container(
        padding: EdgeInsets.all(18),
        child: Form(
          key: _formState,
          child: Column(
            children: <Widget>[
              TextFormField(
                decoration: InputDecoration(
                  icon: Icon(Icons.home),
                  labelText: "Nome",
                  hintText: "Nome da Turma",
                ),
                validator: _validator,
                onChanged: (value) => this._turma.nome = value,
              ),
              TextFormField(
                decoration: InputDecoration(
                  icon: Icon(Icons.list),
                  labelText: "Descrição",
                  hintText: "Descrição da Turma",
                ),
                validator: _validator,
                onChanged: (value) => this._turma.descricao = value,
              ),
              TextFormField(
                decoration: InputDecoration(
                  icon: Icon(Icons.person),
                  labelText: "Professor",
                  hintText: "Professor da turma",
                ),
                validator: _validator,
                onChanged: (value) => this._turma.professor = value,
              ),
              Button(label: "Adicionar", onPressed: _add),
            ],
          ),
        ));
  }

  String _validator(value) {
    if (value.isEmpty) {
      return "Campo obrigatório";
    }
    if (value.length < 3) {
      return "Informe um nome válido";
    }

    return null;
  }

  void _add() async {
    if (_formState.currentState.validate()) {
      final saved = await TurmaApi.saveTurma(this._turma);
      if (saved != null) {
        Navigator.pop(_context, true);
      }
    }
  }
}

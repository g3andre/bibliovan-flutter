import 'package:bibliovan/turma/cadastro_turma.dart';
import 'package:bibliovan/turma/turma.dart';
import 'package:bibliovan/turma/turma_base.dart';
import 'package:bibliovan/usuario/index_usuario.dart';
import 'package:bibliovan/utils/route_manager.dart';
import 'package:bibliovan/widgets/circular_progress.dart';
import 'package:flutter/material.dart';
import 'package:flutter_mobx/flutter_mobx.dart';

class IndexTurma extends StatefulWidget {
  @override
  _IndexTurmaState createState() => _IndexTurmaState();
}

class _IndexTurmaState extends State<IndexTurma> {
  BuildContext _context;
  final TurmaBase _turmaBase = TurmaBase();
  //Future<List<Turma>> futureTurmas;

  @override
  initState() {
    updateList();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    this._context = context;
    return Scaffold(
      appBar: AppBar(
        title: Text("Turmas"),
      ),
      body: Container(
        padding: EdgeInsets.all(8),
        child: _body(),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: _addTurma,
        child: Icon(Icons.add),
      ),
    );
  }

  _body() {
    return Observer(builder: (context) {
      if (_turmaBase.responseManagment != null) {
        var hasError = _turmaBase.responseManagment.hasError ?? false;
        if (!hasError && _turmaBase.responseManagment.responseBody != null) {
          return Container(
            child: _listView(_turmaBase.responseManagment.responseBody),
          );
        } else if (_turmaBase.responseManagment.message != null) {
          return Container(
            child: Center(
              child: Text(_turmaBase.responseManagment.message),
            ),
          );
        }
      }
      return CircularProgress();
    });
  }

  void _showDialog() {
    showDialog(
        context: context,
        builder: (context) {
          return AlertDialog(
              title: Text("Erro"),
              content: ListTile(
                trailing: Icon(Icons.error),
                title: Text(_turmaBase.responseManagment.message),
              ));
        });
  }

  /* _body() {
    return FutureBuilder(
        future: futureTurmas,
        builder: (context, snapshot) {
          if (!snapshot.hasData) {
            return CircularProgress();
          }
          List<Turma> turmas = snapshot.data;
          return _listView(turmas);
        });
  } */

  ListView _listView(List<Turma> turmas) {
    return ListView.builder(
      itemCount: turmas.length,
      itemBuilder: (context, index) {
        return Card(
          child: ListTile(
            onTap: () => _onGroupSelected(turmas[index]),
            leading: Icon(Icons.home),
            title: Text(turmas[index].nome),
            subtitle: Text("Professor(a): ${turmas[index].professor}"),
          ),
        );
      },
    );
  }

  void updateList() {
    _turmaBase.getTurmaList();
    /* setState(() {
      futureTurmas = TurmaApi.getAll();
    }); */
  }

  void _addTurma() async {
    bool itemAdded = await RouteManager.push(_context, CadastroTurma());
    if (itemAdded != null && itemAdded) updateList();
  }

  void _onGroupSelected(Turma t) {
    RouteManager.push(context, IndexUsuario(t));
  }
}

import 'package:bibliovan/turma/cadastro_turma.dart';
import 'package:bibliovan/turma/turma.dart';
import 'package:bibliovan/turma/turma_api.dart';
import 'package:bibliovan/turma/turma_base.dart';
import 'package:bibliovan/usuario/index_usuario.dart';
import 'package:bibliovan/utils/response_managment.dart';
import 'package:bibliovan/utils/route_manager.dart';
import 'package:bibliovan/widgets/circular_progress.dart';
import 'package:bibliovan/widgets/dialog.dart';
import 'package:flutter/material.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

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
            child: RefreshIndicator(
              child: _listView(_turmaBase.responseManagment.responseBody),
              onRefresh: () => _turmaBase.getTurmaList(),
            ),
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

  _dismissible(Turma t) {
    return Dismissible(
      key: Key(t.nome),
      child: Card(
        child: ListTile(
          onTap: () => _onGroupSelected(t),
          leading: Icon(Icons.home),
          title: Text(t.nome),
          subtitle: Text("Professor(a): ${t.professor}"),
        ),
      ),
      background: Container(
        color: Colors.red,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.start,
          children: <Widget>[
            SizedBox(width: 20),
            Icon(
              FontAwesomeIcons.trash,
              color: Colors.white,
            ),
            SizedBox(width: 10),
            Text(
              "Excluir",
              style: TextStyle(
                color: Colors.white,
                fontWeight: FontWeight.bold,
                fontSize: 16,
              ),
            ),
          ],
        ),
        alignment: Alignment.centerLeft,
      ),
      secondaryBackground: Container(
        color: Colors.amberAccent,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.end,
          children: <Widget>[
            Icon(
              FontAwesomeIcons.edit,
              color: Colors.white,
            ),
            SizedBox(width: 10),
            Text(
              "Editar",
              style: TextStyle(
                color: Colors.white,
                fontWeight: FontWeight.bold,
                fontSize: 16,
              ),
            ),
            SizedBox(width: 20)
          ],
        ),
        alignment: Alignment.centerLeft,
      ),
      confirmDismiss: (DismissDirection direction) async {
        if (direction == DismissDirection.endToStart) {
          RouteManager.push(context, CadastroTurma(turma: t));
        } else if (direction == DismissDirection.startToEnd) {
          bool resp = await showDialog(
              context: context,
              builder: (context) {
                return OkCancelDialog(
                  title: "Excluir",
                  message: "Deseja excluir o grupo?",
                  onTapCancel: () => Navigator.of(context).pop(false),
                  onTapOk: () async {
                    final ResponseManagment respMan =
                        await TurmaApi.delete(t.id);
                    bool opt;
                    if (respMan.hasError) {
                      await showDialog(
                        context: context,
                        barrierDismissible: false,
                        builder: (_) {
                          return InformationDialog(
                            title: "Falha ao excluir",
                            message: respMan.message,
                          );
                        },
                      );
                      opt = false;
                    } else {
                      opt = true;
                    }
                    Navigator.of(context).pop(opt);
                  },
                );
              });
          return resp;
        }
      },
    );
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
        return _dismissible(turmas[index]);
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

import 'package:bibliovan/usuario/api_usuario.dart';
import 'package:bibliovan/usuario/form_usuario.dart';
import 'package:bibliovan/usuario/usuario_base.dart';
import 'package:bibliovan/utils/response_managment.dart';
import 'package:bibliovan/utils/route_manager.dart';
import 'package:bibliovan/widgets/circular_progress.dart';
import 'package:bibliovan/widgets/dialog.dart';
import 'package:flutter/material.dart';

import 'package:bibliovan/turma/turma.dart';
import 'package:bibliovan/usuario/usuario.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

class IndexUsuario extends StatefulWidget {
  Turma _turma;

  IndexUsuario(this._turma);

  @override
  _IndexUsuarioState createState() => _IndexUsuarioState();
}

class _IndexUsuarioState extends State<IndexUsuario> {
  final UsuarioBase _usuarioBase = UsuarioBase();

  @override
  void initState() {
    _updateList();
    super.initState();
  }

  void _updateList() {
    this._usuarioBase.updateListUsuario(widget._turma);
  }
  /* Future<List<Usuario>> _updateList() {
        setState(() {
          this.futureUsuarios = ApiUsuario.getUsuariosByTurma(widget._turma);
        });
      } */

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Usuários"),
      ),
      body: Container(
        padding: EdgeInsets.all(8),
        child: RefreshIndicator(
            child: _listUsuario(),
            onRefresh: () => _usuarioBase.updateListUsuario(widget._turma)),
      ),
      floatingActionButton: FloatingActionButton(
          child: Icon(Icons.add),
          onPressed: () {
            RouteManager.push(context, FormUsuario(Usuario()));
          }),
    );
  }

  _listUsuario() {
    return Observer(builder: (_) {
      if (_usuarioBase.listUsuario == null) {
        return CircularProgress();
      }

      return _listView(_usuarioBase.listUsuario);
    });
    /* FutureBuilder(
      future: futureUsuarios,
      builder: (context, snapshot) {
        if (!snapshot.hasData) {
          return CircularProgress();
        }
        return _listView(snapshot.data);
      },
    ); */
  }

  ListView _listView(List<Usuario> usuarios) {
    return ListView.builder(
        itemCount: usuarios.length,
        itemBuilder: (BuildContext context, int index) {
          return GestureDetector(
            onTap: () => _selectUsuario(usuarios[index]),
            child: Dismissible(
              child: Card(
                child: Center(
                  child: Row(
                    children: <Widget>[
                      usuarios[index].urlFoto != null
                          ? Image.network(
                              usuarios[index].urlFoto,
                              scale: 5,
                            )
                          : Image.asset("assets/images/user.png"),
                      Text(usuarios[index].nome)
                    ],
                  ),
                ),
              ),
              key: Key(usuarios[index].nome),
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
                  RouteManager.push(context, FormUsuario(usuarios[index]));
                } else if (direction == DismissDirection.startToEnd) {
                  bool resp = await showDialog(
                      context: context,
                      builder: (context) {
                        return OkCancelDialog(
                          title: "Excluir",
                          message: "Deseja excluir o Usuário?",
                          onTapCancel: () => Navigator.of(context).pop(false),
                          onTapOk: () async {
                            final ResponseManagment respMan =
                                await ApiUsuario.delete(usuarios[index].id);
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
            ),
          );
        });
  }

  void _selectUsuario(Usuario usuario) async {
    bool update = await RouteManager.push(context, FormUsuario(usuario));
    if (update != null && update) {
      _updateList();
    }
  }
}

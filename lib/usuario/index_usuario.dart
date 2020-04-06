import 'package:bibliovan/usuario/form_usuario.dart';
import 'package:bibliovan/usuario/usuario_base.dart';
import 'package:bibliovan/utils/route_manager.dart';
import 'package:bibliovan/widgets/circular_progress.dart';
import 'package:flutter/material.dart';

import 'package:bibliovan/turma/turma.dart';
import 'package:bibliovan/usuario/usuario.dart';
import 'package:flutter_mobx/flutter_mobx.dart';

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
        child: _listUsuario(),
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

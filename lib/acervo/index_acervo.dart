import 'package:bibliovan/acervo/acervo.dart';
import 'package:bibliovan/acervo/acervo_api.dart';
import 'package:bibliovan/acervo/acervo_base.dart';
import 'package:bibliovan/acervo/cadastro_acervo.dart';
import 'package:bibliovan/utils/response_managment.dart';
import 'package:bibliovan/utils/route_manager.dart';
import 'package:bibliovan/widgets/circular_progress.dart';
import 'package:bibliovan/widgets/dialog.dart';
import 'package:flutter/material.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

class IndexAcervo extends StatefulWidget {
  @override
  _IndexAcervoState createState() => _IndexAcervoState();
}

class _IndexAcervoState extends State<IndexAcervo> {
  BuildContext _context;
  AcervoStore _store = AcervoStore();

  @override
  void initState() {
    this._updateList();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    this._context = context;
    return Scaffold(
      appBar: AppBar(
        title: Text("Acervo"),
      ),
      body: Container(
        padding: EdgeInsets.all(8),
        child: _body(),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: _addItemAcervo,
        child: Icon(Icons.add),
      ),
    );
  }

  void _updateList() {
    this._store.getListAcervo();
  }

  void _addItemAcervo() async {
    bool updateList = await RouteManager.push(this._context, CadastroAcervo());
    if (updateList != null && updateList) _updateList();
  }

  _body() {
    return Observer(builder: (context) {
      if (_store.responseManagment != null) {
        var hasError = _store.responseManagment.hasError ?? false;
        if (!hasError && _store.responseManagment.responseBody != null) {
          return Container(
            child: _listView(_store.responseManagment.responseBody),
          );
        } else if (_store.responseManagment.message != null) {
          return Container(
            child: Center(
              child: Text(_store.responseManagment.message),
            ),
          );
        }
      }
      return CircularProgress();
    });
  }

  _listView(List<Acervo> listAcervo) {
    return RefreshIndicator(
      child: ListView.builder(
        itemCount: listAcervo.length,
        itemBuilder: (context, index) {
          var item = listAcervo[index];
          return _dismissibleItem(item);
        },
      ),
      onRefresh: () => _store.getListAcervo(),
    );
  }

  _dismissibleItem(Acervo acervo) {
    String autor = "${acervo.autor[0].nome}" +
        (acervo.autor.length > 1
            ? "... E mais ${acervo.autor.length - 1}"
            : ".");
    return Dismissible(
      key: Key(autor),
      confirmDismiss: (direction) async {
        if (direction == DismissDirection.endToStart) {
          RouteManager.push(context, CadastroAcervo(acervo: acervo));
        } else {
          final bool res = await showDialog(
              context: context,
              builder: (_) {
                return OkCancelDialog(
                  title: "Excluir",
                  message: "Desseja excluir o livro?",
                  onTapCancel: () => Navigator.of(context).pop(false),
                  onTapOk: () async {
                    ResponseManagment resp =
                        await AcervoApi.deleteItemAcervo(acervo.id);
                    bool opt;
                    if (resp.hasError) {
                      opt = false;
                    } else {
                      opt = true;
                      _store.getListAcervo();
                    }
                    return Navigator.of(context).pop(opt);
                  },
                );
              });
          return res;
        }
      },
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
      child: Card(
        child: ListTile(
          title: Text(acervo.titulo),
          subtitle: Text(autor),
        ),
      ),
    );
  }

  /* _slideableMenu(Acervo acervo) {
    String autor = "${acervo.autor[0].nome}" +
        (acervo.autor.length > 1
            ? "... E mais ${acervo.autor.length - 1}"
            : ".");
    return Slidable(
      child: Card(
        child: ListTile(
          title: Text(acervo.titulo),
          subtitle: Text(autor),
        ),
      ),
      actionPane: SlidableScrollActionPane(),
      actions: <Widget>[
        IconSlideAction(
          caption: "Editar",
          color: Colors.yellow,
          icon: FontAwesomeIcons.edit,
        ),
        IconSlideAction(
          caption: "Excluir",
          color: Colors.red,
          icon: FontAwesomeIcons.trash,
        )
      ],
    ); 
  }*/
}

import 'package:bibliovan/acervo/index_acervo.dart';
import 'package:bibliovan/turma/index_turma.dart';
import 'package:bibliovan/utils/route_manager.dart';
import 'package:flutter/material.dart';
import 'package:flutter_slidable/flutter_slidable.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Home(),
    );
  }
}

class Home extends StatelessWidget {
  BuildContext _buildContext;

  @override
  Widget build(BuildContext context) {
    this._buildContext = context;
    return Scaffold(
      appBar: AppBar(
        title: Text("BiblioVan"),
      ),
      body: Container(
        child: _body(),
      ),
      drawer: _buildDrawer(),
    );
  }

  Drawer _buildDrawer() {
    return Drawer(
      child: Column(
        children: <Widget>[
          UserAccountsDrawerHeader(
              currentAccountPicture: Image.asset("assets/images/user.png"),
              accountName: Text("Username"),
              accountEmail: Text("user@mail.com")),
          Padding(
              padding: const EdgeInsets.only(top: 18.0),
              child: Column(
                children: <Widget>[
                  ListTile(
                    onTap: _viewAcervo,
                    leading: Icon(Icons.library_books),
                    title: Text("Acervo"),
                    subtitle: Text("Gerenciar lo Acervo"),
                    trailing: Icon(Icons.arrow_forward),
                  ),
                  ListTile(
                    onTap: _viewturmas,
                    leading: Icon(Icons.home),
                    title: Text("Turmas"),
                    subtitle: Text("Gerenciar Turmas e Alunos"),
                    trailing: Icon(Icons.arrow_forward),
                  ),
                  ListTile(
                    leading: Icon(Icons.settings_backup_restore),
                    title: Text("Devolções"),
                    subtitle: Text("Devolver livros Emprestados"),
                    trailing: Icon(Icons.arrow_forward),
                  )
                ],
              )),
        ],
      ),
    );
  }

  _body() {
    List<String> items = ["Empréstimos", "Turmas", "Devoluções"];
    return ListView.builder(
        itemCount: items.length,
        itemBuilder: (context, index) {
          return Card(
              child: ListTile(
            leading: Icon(Icons.book),
            title: Text(items[index]),
          ));
        });
  }

  _viewturmas() {
    Navigator.pop(this._buildContext);
    RouteManager.push(this._buildContext, IndexTurma());
  }

  void _viewAcervo() {
    Navigator.pop(this._buildContext);
    RouteManager.push(this._buildContext, IndexAcervo());
  }
}

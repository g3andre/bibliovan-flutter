import 'package:bibliovan/usuario/usuario.dart';
import 'package:bibliovan/widgets/button.dart';
import 'package:flutter/material.dart';

class FormUsuario extends StatelessWidget {
  final Usuario _usuario;
  final _txtNome = TextEditingController();
  final _txtContato = TextEditingController();

  FormUsuario(this._usuario) {
    if (this._usuario != null) {
      _txtNome.text = _usuario.nome;
      _txtContato.text = _usuario.contato;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Usuario"),
        actions: <Widget>[Icon(Icons.settings)],
      ),
      body: _body(context),
    );
  }

  _body(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(18),
      child: SingleChildScrollView(
        child: Form(
          child: Column(
            children: <Widget>[
              Stack(
                alignment: Alignment.bottomRight,
                children: <Widget>[
                  Container(
                    width: 190,
                    height: 190,
                    decoration: BoxDecoration(
                      shape: BoxShape.circle,
                      color: Colors.grey,
                      image: DecorationImage(
                          image: (_usuario != null && _usuario.urlFoto != null)
                              ? NetworkImage(_usuario.urlFoto)
                              : AssetImage("assets/images/user.png"),
                          fit: BoxFit.fitHeight),
                    ),
                  ),
                  Icon(Icons.add_a_photo)
                ],
              ),
              textFormField(
                controller: _txtNome,
                labelText: "Nome",
                hintText: "Nome do aluno",
                icon: Icons.account_circle,
                onChanged: (value) => _usuario.nome = value,
              ),
              textFormField(
                controller: _txtContato,
                labelText: "Contato",
                hintText: "Contato do Usuario",
                icon: Icons.phone,
                onChanged: (value) => _usuario.contato = value,
              ),
              Button("Salvar", _onPressed)
            ],
          ),
        ),
      ),
    );
  }

  TextFormField textFormField(
      {String labelText,
      String hintText,
      IconData icon,
      Function onChanged,
      TextEditingController controller}) {
    return TextFormField(
      controller: controller,
      decoration: InputDecoration(
        labelText: labelText,
        hintText: hintText,
        icon: Icon(icon),
      ),
      onChanged: (value) => onChanged(value),
    );
  }

  void _onPressed() {}
}

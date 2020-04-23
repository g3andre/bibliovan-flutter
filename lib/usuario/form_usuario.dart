import 'package:bibliovan/usuario/api_usuario.dart';
import 'package:bibliovan/usuario/usuario.dart';
import 'package:bibliovan/utils/response_managment.dart';
import 'package:bibliovan/widgets/button.dart';
import 'package:bibliovan/widgets/dialog.dart';
import 'package:flutter/material.dart';

class FormUsuario extends StatelessWidget {
  final Usuario _usuario;
  final _formKey = GlobalKey<FormState>();
  final _txtNome = TextEditingController();
  final _txtContato = TextEditingController();
  BuildContext _context;

  FormUsuario(this._usuario) {
    if (this._usuario != null) {
      _txtNome.text = _usuario.nome;
      _txtContato.text = _usuario.contato;
    }
  }

  @override
  Widget build(BuildContext context) {
    this._context = context;
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
          key: _formKey,
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
              Button(label: "Salvar", onPressed: _onPressed)
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

  void _onPressed() async {
    if (_formKey.currentState.validate()) {
      ResponseManagment<Usuario> res = await ApiUsuario.save(this._usuario);
      if (res.hasError) {
        _showDialog(InformationDialog(
          title: "Erro",
          message: res.message,
        ));
      }
    }
  }

  _showDialog(Widget widget) {
    return showDialog(
      context: this._context,
      barrierDismissible: false,
      builder: (_) {
        return widget;
      },
    );
  }
}

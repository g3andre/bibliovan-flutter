import 'package:bibliovan/acervo/acervo.dart';
import 'package:bibliovan/acervo/acervo_api.dart';
import 'package:bibliovan/assunto/assunto.dart';
import 'package:bibliovan/autor/autor.dart';
import 'package:bibliovan/utils/response_managment.dart';
import 'package:bibliovan/widgets/button.dart';
import 'package:flutter/material.dart';

class CadastroAcervo extends StatefulWidget {
  Acervo acervo;

  CadastroAcervo({this.acervo}) {
    if (this.acervo == null) {
      this.acervo = Acervo();
    }
  }

  @override
  _CadastroAcervoState createState() => _CadastroAcervoState();
}

class _CadastroAcervoState extends State<CadastroAcervo> {
  final _formKey = GlobalKey<FormState>();
  final _autor = TextEditingController();
  final _assunto = TextEditingController();
  final _titulo = TextEditingController();
  bool _buttonBusy = false;
  bool _showAllForm = false;
  BuildContext _context;

  @override
  void initState() {
    _loadForm();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    this._context = context;
    return Scaffold(
      appBar: AppBar(
        title: Text("Acervo"),
        actions: <Widget>[
          PopupMenuButton<int>(
              onSelected: (value) => _showCompleteForm(),
              itemBuilder: (context) => [
                    CheckedPopupMenuItem(
                      value: 1,
                      enabled: true,
                      checked: _showAllForm,
                      child: Text("Mostrar todos"),
                    )
                  ])
          /* PopupMenuButton<Options>(
            itemBuilder: (context) {
              return this._listOptions.map((option) {
                return PopupMenuItem<Options>(
                  child: CheckboxListTile(
                    title: Text(option.title),
                    value: _showAllForm,
                    onChanged: _showCompleteForm,
                  ),
                );
              }).toList();
            },
          ), */
        ],
      ),
      body: Container(
        padding: EdgeInsets.all(8),
        child: Form(
          autovalidate: false,
          key: _formKey,
          child: Column(
            children: <Widget>[
              TextFormField(
                onChanged: (value) => this.widget.acervo.titulo = value,
                decoration: InputDecoration(labelText: "Título"),
                validator: _validate,
                controller: _titulo,
              ),
              TextFormField(
                //onChanged: (value) => this.acervo._autor.add(Autor(nome: value)),
                controller: _autor,
                validator: _validate,
                decoration: InputDecoration(
                    labelText: "Autor",
                    suffixIcon: MaterialButton(
                        minWidth: 10,
                        onPressed: () {},
                        child: Icon(Icons.add))),
              ),
              TextFormField(
                  //onChanged: (value) => this.acervo._assunto.add(_Assunto(_assunto: value)),
                  controller: _assunto,
                  validator: (value) => _validate(value),
                  decoration: InputDecoration(
                      labelText: "Assunto",
                      suffixIcon: MaterialButton(
                          minWidth: 10,
                          onPressed: () {},
                          child: Icon(Icons.add)))),
              _showAllForm
                  ? Row(
                      children: <Widget>[
                        Text("Mais conteudo aqui"),
                      ],
                    )
                  : Container(),
              Button(
                label: "Salvar",
                onPressed: _onClick,
                isBusy: _buttonBusy,
              )
            ],
          ),
        ),
      ),
    );
  }

  void _showCompleteForm() {
    setState(() {
      //this._listOptions[0].enable = option;-
      this._showAllForm = !this._showAllForm;
    });
  }

  void _loadForm() {
    this._titulo.text = this.widget.acervo.titulo;
    this._assunto.text = this.widget.acervo.assunto.length > 0
        ? this.widget.acervo.assunto[0]?.assunto
        : "";
    this._autor.text = this.widget.acervo.autor.length > 0
        ? this.widget.acervo.autor[0]?.nome
        : "";
  }

  void _onClick() async {
    setState(() => _buttonBusy = true);

    if (_formKey.currentState.validate()) {
      this.widget.acervo.autor.add(Autor(nome: this._autor.text));
      this.widget.acervo.assunto.add(Assunto(assunto: this._assunto.text));
      ResponseManagment<Acervo> response =
          await AcervoApi.save(this.widget.acervo);
      if (!response.hasError) {
        Navigator.pop(_context, true);
      }
    }
  }

  String _validate(String value) {
    if (value.length < 3) return "Informação inválida";
    if (value.isEmpty) return "Campo obrigatório.";

    return null;
  }
}

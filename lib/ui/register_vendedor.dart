import 'package:flutter/material.dart';
import 'package:venda_produto/models/vendedor_moldels.dart';

class RegisterVendedor extends StatefulWidget {

  final Vendedor vendedor;
  RegisterVendedor({this.vendedor});

  @override
  _RegisterVendedorState createState() => _RegisterVendedorState();
}

class _RegisterVendedorState extends State<RegisterVendedor> {
  final _nameVendedorController = TextEditingController();
  final _idVendedorController = TextEditingController();

  Vendedor _editedVendedor;
  bool _vendedorEdited = false;

  final _nameFocus = FocusNode();

  @override
  void initState() {
    super.initState();

    if(widget.vendedor == null){
      _editedVendedor = Vendedor();
    } else {
      _editedVendedor = Vendedor.fromMap(widget.vendedor.toMapVendedor());

      _nameVendedorController.text = _editedVendedor.nameVendedor;
      _idVendedorController.text = _editedVendedor.idVendedor;
    }
  }

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: _requestPop,
      child: Scaffold(
        appBar: AppBar(
          backgroundColor: Colors.red,
          title: Text(_editedVendedor.nameVendedor ?? "Novo Vendedor"),
          centerTitle: true,
        ),
        body: SingleChildScrollView(
          padding: EdgeInsets.all(10.0),
          child: Column(
            children: <Widget>[
              TextField(
                controller: _nameVendedorController,
                focusNode: _nameFocus,
                decoration: InputDecoration(labelText: "Nome do Vendedor"),
                onChanged: (text){
                  _vendedorEdited = true;
                  setState(() {
                    _editedVendedor.nameVendedor = text;
                  });
                },
              ),
              TextField(
                controller: _idVendedorController,
                decoration: InputDecoration(labelText: "ID do Vendedor"),
                keyboardType: TextInputType.number,
                onChanged: (text){
                  _vendedorEdited = true;
                  _editedVendedor.idVendedor = text;
                },
              ),
            ],
          ),
        ),
        floatingActionButton: FloatingActionButton(
            onPressed: (){
              if(_editedVendedor.nameVendedor != null && _editedVendedor.nameVendedor.isNotEmpty){
                Navigator.pop(context, _editedVendedor);
              } else {
                FocusScope.of(context).requestFocus(_nameFocus);
              }
            },
            child: Icon(Icons.check),
            backgroundColor: Colors.red,
            ),
      ),
    );
  }

  Future<bool> _requestPop(){
    if(_vendedorEdited){
      showDialog(context: context,
          builder: (context){
            return AlertDialog(
              title: Text("Descartar Alterações?"),
              content: Text("Se sair as alterações serão perdidas."),
              actions: <Widget>[
                FlatButton(
                  child: Text("Cancelar"),
                  onPressed: (){
                    Navigator.pop(context);
                  },
                ),
                FlatButton(
                  child: Text("Sim"),
                  onPressed: (){
                    Navigator.pop(context);
                    Navigator.pop(context);
                  },
                ),
              ],
            );
          }
      );
      return Future.value(false);
    } else{
      return Future.value(true);
    }
  }


}

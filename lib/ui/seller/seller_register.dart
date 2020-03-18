import 'package:flutter/material.dart';
import 'package:venda_produto/data/models/seller_model.dart';

class SellerRegister extends StatefulWidget {

  final SellerModel seller;
  SellerRegister({this.seller});

  @override
  _SellerRegisterState createState() => _SellerRegisterState();
}

class _SellerRegisterState extends State<SellerRegister> {

  final _nameController = TextEditingController();
  final _codeController = TextEditingController();

  SellerModel _editedSeller;
  bool _sellerEdited = false;

  final _nameFocus = FocusNode();

  @override
  void initState() {
    super.initState();

    if(widget.seller == null){
      _editedSeller = SellerModel();
    } else {
      _editedSeller = SellerModel.fromMap(widget.seller.toMap());

      _nameController.text = _editedSeller.name;
      _codeController.text = _editedSeller.code.toString();
    }
  }

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: _requestPop,
      child: Scaffold(
        appBar: AppBar(
          backgroundColor: Colors.red,
          title: Text(_editedSeller.name ?? "Novo Vendedor"),
          centerTitle: true,
        ),
        body: SingleChildScrollView(
          padding: EdgeInsets.all(10.0),
          child: Column(
            children: <Widget>[
              TextField(
                controller: _nameController,
                focusNode: _nameFocus,
                decoration: InputDecoration(labelText: "Nome do Vendedor"),
                onChanged: (text){
                  _sellerEdited = true;
                  setState(() {
                    _editedSeller.name = text;
                  });
                },
              ),
              TextField(
                controller: _codeController,
                decoration: InputDecoration(labelText: "Código do Vendedor"),
                keyboardType: TextInputType.number,
                onChanged: (text){
                  _sellerEdited = true;
                  _editedSeller.code = int.parse(text);
                },
              ),
            ],
          ),
        ),
        floatingActionButton: FloatingActionButton(
          onPressed: (){
            if(_editedSeller.name != null && _editedSeller.name.isNotEmpty){
              Navigator.pop(context, _editedSeller);
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
    if(_sellerEdited){
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

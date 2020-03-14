import 'package:flutter/material.dart';
import 'dart:convert';
import 'dart:async' show Future;
import 'package:flutter/services.dart' show rootBundle;
import 'package:venda_produto/models/produto_models.dart';
import 'package:venda_produto/ui/import_produto.dart';


class ListProduto extends StatefulWidget {
  @override
  _ListProdutoState createState() => _ListProdutoState();
}

class _ListProdutoState extends State<ListProduto> {

  Future<String> _carregaProdutoJson() async {
    return await rootBundle.loadString('assets/produtos.json');
  }
  Future carregaProduto() async {
    String jsonString = await _carregaProdutoJson();
    final jsonResponse = json.decode(jsonString);

    Product produto = new Product.fromJson(jsonResponse);

    print(produto.name);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Lista de Porduto"),
      ),
      floatingActionButton: FloatingActionButton(
          child: Icon(Icons.import_export),
          onPressed: (){
            carregaProduto();
          }),
    );
  }
}

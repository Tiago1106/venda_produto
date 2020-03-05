import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:venda_produto/helpers/api_produto.dart';
import 'package:venda_produto/models/api.dart';

class ListViewProduto extends StatefulWidget {
  @override
  _ListViewProdutoState createState() => _ListViewProdutoState();
}

class _ListViewProdutoState extends State<ListViewProduto> {
  var produtos = new List<ProdutoApi>();

  _getProdutos() {
    API.getUsers().then((response) {
      setState(() {
        Iterable list = json.decode(response.body);
        produtos = list.map((model) => ProdutoApi.fromJson(model)).toList();
      });
    });
  }
  initState() {
    super.initState();
    _getProdutos();
  }
  dispose() {
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Lista de Produtos"),
      ),
      body: ListView.builder(
        itemCount: produtos.length,
        itemBuilder: (context, index){
          return ListTile(title: Text(produtos[index].name));
        },
      ),
    );
  }
}
